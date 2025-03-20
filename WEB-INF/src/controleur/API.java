package controleur;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modele.dao.DaoFollower;
import modele.dao.DaoMessage;
import modele.dao.DaoThread;
import modele.dto.Message;
import modele.dto.Thread;

@WebServlet("/api/threads/*")
public class API extends HttpServlet {
    ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule());
    DaoFollower daoFollower = new DaoFollower();
    DaoThread daoThread = new DaoThread();
    DaoMessage daoMessage = new DaoMessage();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String username = (String) req.getSession().getAttribute("username");
        // vérification de l'authentification
        if(username  == null){
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            out.close();
            return ;
        }

        String info = req.getPathInfo();

        // Si aucune information n'est renseigné, on renvoie tous les threads du user
        if (info == null || info.equals("/")) {
            List<Thread> threads = daoFollower.findThreadsByUsername(username);
            out.println(objectMapper.writeValueAsString(threads));
            out.close();
            return;
        }

        String[] splits = info.split("/");

        // Vérifie la longueur de la requête
        if(splits.length > 4){
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            out.close();
            return;
        }

        int idThread;

        // Récupère l'id et vérifie que c'est un entier
        try {
            idThread = Integer.parseInt(splits[1]);
        } catch (NumberFormatException e){
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            out.close();
            return;
        }

        Thread thread = daoThread.findById(idThread);
        // Vérifie que le thread existe
        if(thread == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            out.close();
            return;
        }

        // Vérifie que l'utilisateur à accès au thread
        if(!daoFollower.userIsInThread(username, idThread)){
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            out.close();
            return;
        }

        // Lorsque la longueur de la requete est 2, renvoie les informations du thread
        if(splits.length == 2) {
            out.println(objectMapper.writeValueAsString(thread));
            out.close();
            return;
        }

        // Vérifie que le 3eme argument est "messages"
        if(!splits[2].equals("messages")){
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            out.close();
            return;
        }

        List<Message> messages = daoMessage.findByThreadId(idThread);
        // Lorsque la longueur de la requete est 3, renvoie tous les messages du thread
        if (splits.length == 3){
            out.println(objectMapper.writeValueAsString(messages));
            out.close();
            return ;
        }

        int idMessage;
        // Récupère l'id et vérifie que c'est un entier
        try {
            idMessage = Integer.parseInt(splits[3]);
        } catch (NumberFormatException e){
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            out.close();
            return;
        }

        Message message = daoMessage.findById(idMessage);
        // Vérifie que le message existe
        if(message == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            out.close();
            return;
        }

        // Vérifie que le message appartient au thread
        if(message.getId_thread() != idThread){
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            out.close();
            return ;
        }

        out.println(objectMapper.writeValueAsString(message));
        out.close();
    }
}
