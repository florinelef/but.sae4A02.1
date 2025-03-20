package controleur;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/index.html")
public class Redirect extends HttpServlet{
    @Override
    public void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = (String) session.getAttribute("username");
        String vue = "";

        if (username == null) {
            vue="WEB-INF/vue/login.jsp";
        } else {
            vue="WEB-INF/vue/accueil.jsp";
        }

        req.getRequestDispatcher(vue).forward(req, resp);

    }
}