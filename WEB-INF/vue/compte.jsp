<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="modele.dao.DaoUser" %>
<%@ page import="modele.dao.DaoThread" %>
<%@ page import="modele.dto.User" %>
<%@ page import="modele.dto.Thread" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    DaoUser daoUser = new DaoUser();
    DaoThread daoThread = new DaoThread();
    String username = (String) session.getAttribute("username");
    User user = daoUser.findByUsername(username);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <title>Villeneuve Chat - Compte</title>
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
                                <a href="navigation?page=creerFil" class="nav-link py-3 px-2" title="Créer un fil" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-plus-square fs-1"></i>
                                </a>
                            </li>
                            <li>
                                <a href="navigation?page=compte" class="link-dark py-3 px-3" title="Compte" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <div><i class="bi-person-circle h2"></i><div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm p-3 min-vh-100 d-flex flex-column">

                    <h1 class="d-flex justify-content-between align-items-center">Votre compte !
                        <a href="account?action=logout" class="btn btn-outline-danger">
                            Déconnexion
                        </a>
                    </h1>
                    <hr />
                    
                    <p>Sur cette page, vous pouvez voir et modifier les informations de votre compte, ainsi qu'obtenir la liste des fils que vous avez créé.</p>

                    <div class="d-flex justify-content-center mt-5">
                        <form id="modifyAccountForm" action="account" method="post" class="w-75">
                            <input type="hidden" name="action" value="update"/>
                            <div>
                                <div class="mb-3">
                                    <p class="mb-1">
                                        Pseudonyme 
                                        <a type="button" data-bs-toggle="tooltip" title="Vous ne pouvez pas changer de pseudonyme">
                                            <i class="bi-info-circle"></i>
                                        </a>
                                    </p>
                                    <input class="form-control" name="username" type="text" value="<%= username %>" disabled>
                                </div>
                                <div class="mt-2 mb-3">
                                    <p class="mb-1">Mot de passe</p>
                                    <input class="form-control" name="password" type="password" placeholder="••••••••••" maxlength="50">
                                </div>
                                <div class="mt-2 mb-3">
                                    <p class="mb-1">Prénom</p>
                                    <input class="form-control" name="firstname" pattern="[a-zA-Z-]{3,50}" type="text" value="<%= user.getFirstname() %>" maxlength="50" required>
                                </div>
                                <div class="mt-2 mb-3">
                                    <p class="mb-1">Nom de famille</p>
                                    <input class="form-control" name="lastname" pattern="[a-zA-Z-]{3,50}" type="text" value="<%= user.getLastname() %>" maxlength="50" required>
                                </div>
                            </div>
                            <div class="mt-5 d-flex justify-content-center">
                                <input class="btn btn-primary" type="submit" value="Mettre à jour mes informations">
                            </div>
                        </form>
                    </div>

                    <div id="myThreads" class="mt-5">
                        <h4>Mes fils</h4>
                        <hr>

                        <%  if (daoThread.findByCreator(username).size() == 0){ %>
                            <div class="p-2 mb-3">
                                <div class="d-flex justify-content-center align-items-center">
                                    <label class="fs-3">Vous n'avez pas de fil :</label>
                                    <a class="ms-3 align-self-center btn btn-success" href="navigation?page=creerFil">Créer un fil <i class="bi-plus-square-fill"></i></a>
                                </div>
                            </div>
                        <% } else { %>

                            <% for(Thread thread : daoThread.findByCreator(username)){ %>

                            <div class="p-2 border border-primary border-3 rounded mb-3">
                                <div class="d-flex justify-content-between">
                                    <div class="ms-2">
                                        <p class="fs-3"><%= thread.getName() %></p>
                                        <span class="text-secondary">Par vous le <%= thread.getDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></span>
                                    </div>
                                    <div class="d-flex">
                                        <a class="me-3 align-self-center btn btn-primary" href="?chat=<%= thread.getId_thread() %>">Ouvrir <i class="bi-chat-fill"></i></a>
                                        <a class="me-3 align-self-center btn btn-danger" href="thread?action=delete&id=<%= thread.getId_thread() %>">Supprimer <i class="bi-x-circle-fill"></i></a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        <div class="bg-light p-3 d-flex justify-content-center border-top border-3">
                            <a href="#" class="btn btn-outline-secondary">Remonter <i class="bi-arrow-up"></i></a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>