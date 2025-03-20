package controleur;

import java.io.IOException;
import java.time.LocalDate;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.commons.text.translate.CharSequenceTranslator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modele.dao.DaoFollower;
import modele.dao.DaoThread;
import modele.dto.Follower;
import modele.dto.Thread;

@WebServlet("/thread")
public class ThreadController extends HttpServlet {
    DaoFollower daoFollower = new DaoFollower();
    DaoThread daoThread = new DaoThread();
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


        int idThread;
        if (req.getParameter("id") == null) idThread = -1;
        else {
            // Vérifie que l'id mis est bien un int (au cas où il a été changé à la main
            try {
                idThread = Integer.parseInt(req.getParameter("id"));
            }catch (NumberFormatException e) {
                req.setAttribute("error", "Ne changez pas l'url vous même!");
                vue = "WEB-INF/vue/error.jsp";
                req.getRequestDispatcher(vue).forward(req, resp);
                return;
            }
        }

        if(!action.equals("create") && daoThread.findById(idThread) == null){
            req.setAttribute("error", "Ne changez pas l'url vous même!");
            req.getRequestDispatcher("/WEB-INF/vue/error.jsp").forward(req, resp);
            return;
        }

        Follower follow = new Follower(username, idThread);

        
        switch (action){
            case "follow":
                if(daoFollower.checkFollowerExist(follow)){
                    req.setAttribute("error", "Vous suivez déjà ce fils");
                    req.getRequestDispatcher("/WEB-INF/vue/error.jsp").forward(req, resp);
                    return ;
                }
                daoFollower.create(follow);
                vue = "/thread?action=open&id=" + idThread;
                break;
            case "unfollow":
                daoFollower.delete(follow);
                vue = "WEB-INF/vue/filsSuivis.jsp";
                break;
            case "delete":
                daoThread.delete(idThread);
                vue = "WEB-INF/vue/compte.jsp";
                break;
            case "open":
                if(daoFollower.userIsInThread(username, idThread)){
                    vue = "WEB-INF/vue/chat.jsp?id=" + idThread;
                    break;
                }
                vue = "WEB-INF/vue/fils.jsp";
                break;
            case "create":
                String name = req.getParameter("name");
                CharSequenceTranslator cst = StringEscapeUtils.ESCAPE_HTML4;
                name = cst.translate(name);
                idThread = daoThread.create(new Thread(idThread, username, name, LocalDate.now()));
                follow = new Follower(username, idThread);
                daoFollower.create(follow);
                vue = "WEB-INF/vue/chat.jsp?id=" + idThread;
                break;
            default:
                req.setAttribute("error", "Ne changez pas l'url vous même!");
                vue = "/WEB-INF/vue/error.jsp";
                break;
        }
        req.getRequestDispatcher(vue).forward(req, resp);
    }
}
