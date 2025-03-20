<%@ page contentType="text/html; charset=UTF-8"%>
<%
    // l'authentification - redirection vers l'accueil si deja connecté
    if(request.getSession().getAttribute("username") != null) response.sendRedirect("navigation?page=accueil");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <title>Villeneuve Chat - Créer un compte</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="res/font.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/res/favicon.ico">
    </head>
    <body>
        <div class="container d-flex justify-content-center flex-column">
            <img class="mx-auto mt-5" id="logo" src="res/villeneuve_chat_logo.jpg" width="350px">
            
            <h1 class="mx-auto fw-bold mt-3">Créer un compte</h1>
            <div class="mx-auto mt-1">
                <%
                String error = (String)request.getAttribute("error");
                if(error != null){
                    out.println("<div class=\"alert alert-danger\" role=\"alert\">" + error + "</div>");
                }
                %>
                <form id="loginForm" action="authent" method="post">
                    <input type="hidden" name="action" value="signin"/>
                    <div>
                        <div class="mt-2 mb-3">
                            <p class="mb-1">Pseudonyme</p>
                            <input class="form-control" name="username" pattern="[a-zA-Z0-9_.]{3,24}" type="text" placeholder="pmathieu" maxlength="24" required>
                        </div>
                        <div class="mb-3">
                            <p class="mb-1">Mot de passe</p>
                            <input class="form-control" name="password" type="password" placeholder="••••••••••" required>
                        </div>
                        <div class="mt-2 mb-3">
                            <p class="mb-1">Prénom</p>
                            <input class="form-control" name="firstname" pattern="[a-zA-Z-]{3,50}" type="text" placeholder="Philippe" maxlength="50" required>
                        </div>
                        <div class="mt-2 mb-3">
                            <p class="mb-1">Nom de famille</p>
                            <input class="form-control" name="lastname" pattern="[a-zA-Z-]{3,50}" type="text" placeholder="Mathieu" maxlength="50" required>
                        </div>
                    </div>
                    <div class="mt-5 d-flex flex-column justify-content-center">
                        <input class="btn btn-primary flex-fill" type="submit" value="Créer un compte">
                        <a class="btn btn-link mt-2" href="navigation?page=login">J'ai déjà un compte</a>
                    </div>
                </form>
            </div>
        </div>
        <footer class="fixed-bottom">
            <div class="d-flex justify-content-between border-top p-3">
                <span>Villeneuve Chat &copy;</span>
                <span>Florine Lefebvre & Maxime Gosselin</span>
                <a href="res/SAe_S4_sujet_ReseauSocial.pdf">Lien du sujet SAÉ</a>
            </div>
        </footer>
    </body>
</html>