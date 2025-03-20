<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="modele.dao.DaoThread" %>
<%@ page import="modele.dto.Thread" %>
<%@ page import="modele.dao.DaoUser" %>
<%@ page import="modele.dto.User" %>
<%@ page import="modele.dao.DaoMessage" %>
<%@ page import="modele.dto.Message" %>
<%@ page import="modele.dao.DaoFollower" %>
<%@ page import="modele.dao.DaoLike" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.lang.NumberFormatException" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>

<%!
    DaoThread daoThread = new DaoThread();
    DaoUser daoUser = new DaoUser();
    DaoMessage daoMessage = new DaoMessage();
    DaoFollower daoFollower = new DaoFollower();
    DaoLike daoLike = new DaoLike();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("'le' dd/MM/yyyy 'à' HH'h'mm");
%>

<%
    User user = daoUser.findByUsername((String) request.getSession().getAttribute("username"));
    int id = Integer.parseInt(request.getParameter("id"));
    Thread thread = daoThread.findById(id);
    List<Message> messages = daoMessage.findByThreadId(id);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <title><%=thread.getName() %></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="<%= request.getContextPath() %>/res/font.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/res/favicon.ico">

        <!-- Pour le offcanva (liste des utilisateurs du threads) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script defer>
            // Faire défiler la page vers le bas
            window.onload = function() {
              window.scrollTo(0, document.body.scrollHeight);
            };
        </script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="fixed-top p-3 bg-white border-bottom border-2 border-dark">
                <h1 class="d-flex mb-0 justify-content-between">
                    <a href="navigation?page=accueil">
                        <i class="bi bi-house"></i>
                    </a>
                    <label>
                        <%=thread.getName() %>
                    </label>
                    <a class="icon-link" data-bs-toggle="offcanvas" href="#userlist" role="button" aria-controls="offcanvasExample">
                        <i class="bi bi-people"></i>
                    </a>
                </h1>
            </div>
            <div class="p-3 min-vh-100 d-flex flex-column">

                <div class="offcanvas offcanvas-end" tabindex="-1" id="userlist" aria-labelledby="Utilisateurs">
                    <div class="offcanvas-header">
                        <h4 class="offcanvas-title">Utilisateurs</h5>
                        <a class="ms-auto fs-3 me-3" data-bs-dismiss="offcanvas"><i class="bi-arrow-right-circle"></i></a>
                    </div>
                    <div class="offcanvas-body">
                        <h5>Créateur / Créatrice</h5>
                        <ul class="list-group">
                            <li class="list-group-item">@<%=thread.getCreator() %></li>
                        </ul>
                        <hr>
                        <h5>Utilisateurs suivant ce fil</h5>
                        <ul class="list-group">
                            <% for (User userFollow : daoFollower.findUsersByThreadID(id)) { %>
                            <% if (!daoThread.isCreatorOf(userFollow.getUsername(), thread.getId_thread())) {%>
                            <li class="list-group-item">@<%=userFollow.getUsername() %></li>
                            <% }} %>
                        </ul>
                    </div>
                </div>

                <div id="messages" class="container-lg" style="margin-top: 60px; margin-bottom: 85px;">

                    <% for (Message message : messages) {
                        String sender;
                        String color;
                        String icon;
                        boolean userIsSender = message.getSender().equals(user.getUsername());
                        boolean messageIsLikedByUser = daoLike.isAlreadyLike(message.getId_message(), user.getUsername());
                        if (userIsSender) {
                            sender = "vous";
                            color = "primary";
                        } else {
                            sender = message.getSender();
                            color = "secondary";
                        } 
                        if(messageIsLikedByUser){
                            icon = "bi bi-heart-fill";
                        } else {
                            icon = "bi bi-heart";
                        }
                        %>

                        <div id="me" class="row d-inline-block m-3">
                            <label class="ms-3 fs-6 text-secondary">par <strong><%=sender %></strong>, <%=message.getTime().format(formatter)%></label>
                            <div>
                                <label class="p-3 border border-3 border-<%=color %> rounded-pill bg-<%=color %>-subtle"><%=message.getMessage() %></label>
                                <span class="ms-3">
                                    <a href="message?action=like&message=<%=message.getId_message()%>&thread=<%=id%>"><i class="text-danger <%= icon %>"></i></a>
                                    <%=daoLike.countLikesByMessage(message.getId_message())%>
                                </span>
                            </div>
                        </div>
                        <br>
                    <% } %>
                <div id="input" class="fixed-bottom p-2 bg-white border-top border-2 border-dark">
                    <form class="input-group mb-3 container-lg" method="post" action="message">
                        <input type="hidden" name="action" value="send" />
                        <input type="hidden" name="thread" value="<%=id%>" />
                        <a class="input-group-text link-primary" href="thread?action=open&id=<%=id %>">
                            <i class="bi-arrow-clockwise"></i>
                        </a>
                        <input name="message" class="form-control" placeholder="Entrez votre message ici." maxlength=1024 required>
                        <input type="submit" class="input-group-text" value="Envoyer">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>