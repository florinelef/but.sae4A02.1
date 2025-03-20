package controleur;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modele.dao.DaoUser;
import modele.dto.User;

@WebServlet("/account")
public class Account extends HttpServlet{
    DaoUser daoUser = new DaoUser();

    @Override
    public void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = (String) req.getSession().getAttribute("username");
        // vérification de l'authentification
        if(username  == null){
            resp.sendRedirect("index.html");
            return ;
        }

        String action = (String) req.getParameter("action");
        HttpSession session = req.getSession();

        switch (action){
            case "logout":
                session.invalidate();
                resp.sendRedirect("index.html");
                break;
            case "update":
                String firstname = req.getParameter("firstname");
                String lastname = req.getParameter("lastname");
                String password = req.getParameter("password");

                User user = daoUser.findByUsername(username);
                user.setFirstname(firstname);
                user.setLastname(lastname);
                if(!password.equals("")){
                    String hashedPassword;
        
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

                    user.setPassword(hashedPassword);
                }
                daoUser.update(user);
                resp.sendRedirect("navigation?page=compte");
                break;
            default:
                req.setAttribute("error", "Ne changez pas l'url vous même!");
                req.getRequestDispatcher("/WEB-INF/vue/error.jsp").forward(req, resp);
                return;
        }
    }
}