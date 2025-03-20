package controleur;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/navigation")
public class Navigation extends HttpServlet{
    @Override
    public void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String page = (String) req.getParameter("page");
        // vérification de l'authentification
        if(req.getSession().getAttribute("username") == null && !page.equals("signin")) {
            resp.sendRedirect("index.html");
            return;
        }

        String vue;

        switch (page){
            case "fils":
                vue = "WEB-INF/vue/fils.jsp";
                break;
            case "signin":
                vue = "WEB-INF/vue/signin.jsp";
                break;
            case "login":
                vue = "WEB-INF/vue/login.jsp";
                break;
            case "compte":
                vue = "WEB-INF/vue/compte.jsp";
                break;
            case "filsSuivis":
                vue = "WEB-INF/vue/filsSuivis.jsp";
                break;
            case "creerFil":
                vue = "WEB-INF/vue/creerFil.jsp";
                break;
            case "accueil":
                vue = "WEB-INF/vue/accueil.jsp";
                break;
            default:
                req.setAttribute("error", "Ne changez pas l'url vous même!");
                vue = "/WEB-INF/vue/error.jsp";
                break;
        }
        req.getRequestDispatcher(vue).forward(req, resp);

    }
}