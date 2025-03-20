<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/res/favicon_error.ico">
        <title>Villeneuve Chat - Erreur</title>
    </head>
    <body>
        <div class="container d-flex justify-content-center align-items-center flex-column">
            <img class="mx-auto mt-5" id="logo" src="res/villeneuve_chat_logo_error.jpg" width="350px">
            
            <div class="mt-5 border border-3 border-dark rounded-5 p-5">
                <h2>⚠️ Une <strong>erreur</strong> est survenue ⚠️</h2>
                <div class="alert alert-danger mt-3" role="alert">
                    <%=request.getAttribute("error") %>
                </div>
            </div>

            <div>
                <a href="navigation?page=accueil" class="btn btn-primary mt-5">Retourner à l'accueil <i class="bi bi-house-fill"></i></a>
            </div>
        </div>
        <footer class="fixed-bottom">
            <div class="d-flex justify-content-between border-top p-3">
                <span>Villeneuve Chat &copy;</span>
                <span>Florine Lefebvre & Maxime Gosselin</span>
                <a href="https://fr.wikipedia.org/wiki/Message_d%27erreur">Ah les erreurs...</a>
            </div>
        </footer>
    </body>
</html>