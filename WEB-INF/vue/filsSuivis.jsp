<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="modele.dao.DaoThread" %>
<%@ page import="modele.dto.Thread" %>
<%@ page import="modele.dao.DaoUser" %>
<%@ page import="modele.dto.User" %>
<%@ page import="modele.dto.Thread" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%!
    DaoThread daoThread = new DaoThread();
    DaoUser daoUser = new DaoUser();
%>

<%
    User user = daoUser.findByUsername((String) request.getSession().getAttribute("username"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <title>Villeneuve Chat - Fils suivis</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link href="res/font.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/res/favicon.ico">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-auto bg-light sticky-top">
                    <div class="d-flex flex-md-column flex-row flex-nowrap bg-light align-items-center sticky-top">
                        <ul class="nav nav-pills nav-flush flex-md-column flex-row flex-nowrap mb-auto mx-auto text-center justify-content-between w-100 px-3 align-items-center">
                            <div class="d-block p-3 pt-3">
                                <img src="res/mini_logo.png" width="45px">
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
                                <a class="nav-link py-3 px-2" title="Fils suivis" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-chat-heart-fill fs-1"></i>
                                </a>
                            </li>
                            <li>
                                <a href="navigation?page=creerFil" class="nav-link py-3 px-2" title="Créer un fil" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-plus-square fs-1"></i>
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

                    <h1>Fils suivis !</h1>
                    <hr />
                    <% if(daoThread.findThreadFollow(user.getUsername()).size() == 0){ %>
                    <div class="p-2 mb-3">
                        <div class="d-flex justify-content-center align-items-center">
                            <label class="fs-3">Vous ne suivez aucun fil :</label>
                            <a class="ms-3 align-self-center btn btn-success" href="navigation?page=fils">Voir les fils <i class="bi-threads-fill"></i></a>
                        </div>
                    </div>
                    <% } else { %>
                        <% for (Thread fil : daoThread.findThreadFollow(user.getUsername())) { %>

                        <div class="p-2 border border-primary border-3 rounded mb-3">
                            <div class="d-flex justify-content-between">
                                <div class="ms-2">
                                    <p class="fs-3"><%= fil.getName() %></p>
                                    <span class="text-secondary">Par @<%= fil.getCreator()%> le <%=fil.getDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%></span>
                                </div>
                                <div class="d-flex">
                                    <a class="me-3 align-self-center btn btn-primary" href="thread?action=open&id=<%=fil.getId_thread() %>">Ouvrir <i class="bi-chat-fill"></i></a>
                                    <a class="me-3 align-self-center btn btn-danger <% if (daoThread.isCreatorOf(user.getUsername(), fil.getId_thread())) { %> disabled <% } %>" href="thread?action=unfollow&id=<%=fil.getId_thread() %>">Ne plus suivre <i class="bi-x-circle-fill"></i></a>
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
    </body>
</html>