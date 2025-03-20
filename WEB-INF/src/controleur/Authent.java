package controleur;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.commons.text.translate.CharSequenceTranslator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modele.dao.DaoUser;
import modele.dto.User;

@WebServlet("/authent")
public class Authent extends HttpServlet {
    DaoUser daoUser = new DaoUser();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        CharSequenceTranslator cst = StringEscapeUtils.ESCAPE_HTML4;
        
        if(username == null || password == null){
            req.setAttribute("error", "Vous ne pouvez pas avoir un pseudo ou mot de passe vide !");
            req.getRequestDispatcher("/WEB-INF/vue/error.jsp").forward(req, resp);
            return;
        }
        String hashedPassword;
        username = username.toLowerCase();
        username = cst.translate(username);
        
        MessageDigest md;
        this.getServletContext();
        try {
            md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] byteOfPasswordMD = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : byteOfPasswordMD) {
                sb.append(String.format("%02x", b));
            }
            hashedPassword = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            req.setAttribute("error", "Problème lors du hashage du mot de passe");
            req.getRequestDispatcher("/WEB-INF/vue/error.jsp").forward(req, resp);
            return;
        }

        String vue = "WEB-INF/vue/login.jsp";

        switch (action) {
            case "login":
                if (daoUser.checkUser(username, hashedPassword)) {
                    req.getSession().setAttribute("username", username);
                    resp.sendRedirect("navigation?page=accueil");
                    return;
                } else {
                    req.setAttribute("error", "Identifiant ou mot de passe incorrect");
                    req.getRequestDispatcher("/WEB-INF/vue/error.jsp");
                }
                break;
                
            case "signin":
                String firstname = req.getParameter("firstname");
                String lastname = req.getParameter("lastname");
                
                try {
                    daoUser.create(new User(username, hashedPassword, firstname, lastname));
                    req.getSession().setAttribute("username", username);
                    resp.sendRedirect("navigation?page=accueil");
                    return;
                } catch (Exception e) {
                    req.setAttribute("error", "Pseudonyme invalide / Nom d'utilisateur déjà pris");
                    vue = "WEB-INF/vue/signin.jsp";
                }
                break;
            default:
                req.setAttribute("error", "Ne changez pas l'url vous même!");
                req.getRequestDispatcher("/WEB-INF/vue/error.jsp");
        }
        req.getRequestDispatcher(vue).forward(req, resp);
    }
}
