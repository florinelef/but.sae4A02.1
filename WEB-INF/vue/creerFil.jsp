<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <title>Villeneuve Chat - Créer un fil</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="<%= request.getContextPath() %>/res/font.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/res/favicon.ico">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-auto bg-light sticky-top">
                    <div class="d-flex flex-md-column flex-row flex-nowrap bg-light align-items-center sticky-top">
                        <ul class="nav nav-pills nav-flush flex-md-column flex-row flex-nowrap mb-auto mx-auto text-center justify-content-between w-100 px-3 align-items-center">
                            <div class="d-block p-3 pt-3">
                                <img src="<%= request.getContextPath() %>/res/mini_logo.png" width="45px">
                            </div>
                            <li class="nav-item">
                                <a href="navigation?page=accueil" class="nav-link py-3 px-2" title="Accueil" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-house fs-1"></i>
                                </a>
                            </li>
                            <li>
                                <a href="navigation?page=fils" class="nav-link py-3 px-2" title="Fils" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-threads fs-1"></i>
                                </a>
                            </li>
                            <li>
                                <a href="navigation?page=filsSuivis" class="nav-link py-3 px-2" title="Fils suivis" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-chat-heart fs-1"></i>
                                </a>
                            </li>
                            <li>
                                <a class="nav-link py-3 px-2" title="Créer un fil" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-plus-square-fill fs-1"></i>
                                </a>
                            </li>
                            <li>
                                <a href="navigation?page=compte" class="link-dark py-3 px-2" title="Compte" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <div><i class="bi-person-circle h2"></i></div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm p-3 min-vh-100">

                    <h1>Créer un fil !</h1>
                    <hr />
                    <p>
                        Sur cette page, vous pouvez créer un fil que vous suivrez automatiquement.
                        Vous avez juste à lui donner un nom et le tour est joué !
                    </p>

                    <div class="d-flex justify-content-center mt-5">
                        <form id="creatingThreadForm" action="thread" method="post" class="w-75">
                            <input type="hidden" name="action" value="create"/>
                            <div>
                                <div class="mt-2 mb-3">
                                    <p class="mb-1">Nom du fil</p>
                                    <input class="form-control" name="name" type="text" placeholder="Chasse & pêche" maxlength="75" required>
                                </div>
                                <div class="mb-3">
                                    <p class="mb-1">Créateur / Créatrice</p>
                                    <input class="form-control" name="username" type="text" value="<%= (String) session.getAttribute("username")%>" disabled>
                                </div>
                            </div>
                            <div class="mt-5 d-flex justify-content-center">
                                <input class="btn btn-primary" type="submit" value="Créer un fil">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>