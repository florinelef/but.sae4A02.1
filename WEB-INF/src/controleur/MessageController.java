package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modele.dao.DaoLike;
import modele.dao.DaoMessage;
import modele.dto.Like;
import modele.dto.Message;
import org.apache.commons.text.StringEscapeUtils;
import org.apache.commons.text.translate.CharSequenceTranslator;


import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/message")
public class MessageController extends HttpServlet {
    DaoMessage daoMessage = new DaoMessage();
    DaoLike daoLike = new DaoLike();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username;
        // vérification de l'authentification
        if((username = (String) req.getSession().getAttribute("username")) == null){
            resp.sendRedirect("index.html");
            return ;
        }
        String action = (String) req.getParameter("action");
        String vue;

        switch (action){
            case "send":
                CharSequenceTranslator cst = StringEscapeUtils.ESCAPE_HTML4;
                String contenu = cst.translate(req.getParameter("message"));
                try {
                    int idThread = Integer.parseInt(req.getParameter("thread"));

                    if (contenu != null && !contenu.isEmpty()) {
                        Message message = new Message(0, username, idThread, contenu, LocalDateTime.now());
                        daoMessage.create(message);
                    }
                    vue = "thread?action=open&id=" + idThread;
                } catch (NumberFormatException exception){
                    req.setAttribute("error", "Ne changez pas l'url vous même!");
                    vue = "/WEB-INF/vue/error.jsp";
                }
                break;

            case "like":
                try {
                    int idMessage = Integer.parseInt(req.getParameter("message"));
                    int idThread = Integer.parseInt(req.getParameter("thread"));
                    Like like = new Like(username, idMessage);

                    // Vérifier si l'utilisateur a déjà liké ce message
                    if (daoLike.isAlreadyLike(idMessage, username)) {
                        daoLike.delete(like); // Supprime le like
                    } else {
                        daoLike.create(like); // Ajoute le like
                    }
                    vue = "thread?action=open&id=" + idThread;
                } catch (NumberFormatException exception) {
                    req.setAttribute("error", "Ne changez pas l'URL vous-même !");
                    vue = "/WEB-INF/error.jsp";
                }
                break;
            default:
                req.setAttribute("error", "Ne changez pas l'url vous même!");
                vue = "/WEB-INF/vue/error.jsp";
        }
        req.getRequestDispatcher(vue).forward(req, resp);
    }
}
