<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="modele.dao.DaoUser" %>
<%@ page import="modele.dto.User" %>

<%
    DaoUser daoUser = new DaoUser();
    String username = (String) session.getAttribute("username");
    User user = daoUser.findByUsername(username);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8">
        <title>Villeneuve Chat - Accueil</title>
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
                                <a class="nav-link py-3 px-2" title="Accueil" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <i class="bi-house-fill fs-1"></i>
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
                                <a href="navigation?page=compte" class="link-dark py-3 px-2" title="Compte" data-bs-toggle="tooltip" data-bs-placement="right">
                                    <div><i class="bi-person-circle h2"></i></div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm p-3 min-vh-100 d-flex flex-column">

                    <h1>Bienvenue <%= user.getFirstname()%> <%= user.getLastname()%> !</h1>
                    <hr />
                    <p>Villeneuve Chat est une plateforme de discussion en ligne où vous pouvez échanger facilement avec d'autres utilisateurs. Créez des fils de discussion, participez en temps réel et explorez les sujets qui vous intéressent.</p>

                    <h4>Créer un fil</h4>
                    <p>Sur Villeneuve Chat, créer un fil de discussion est très simple.
                    Cliquez sur l'icône de <a href="navigation?page=creerFil">création de fil <i class="bi-plus-square"></i></a> située dans la barre de navigation.
                    Cela vous permettra de créer un nouveau fil. Il vous suffit ensuite de choisir un titre pour votre fil, puis de publier.
                    Votre fil est immédiatement créé et prêt à accueillir des messages, permettant ainsi aux autres utilisateurs de rejoindre la conversation et d'échanger avec vous.</p>

                    <h4>Suivre un fil</h4>
                    <p>Rejoindre un fil sur Villeneuve Chat est facile.
                    Il vous suffit de <a href="navigation?page=fils">parcourir les fils disponibles <i class="bi-threads"></i></a> pour trouver celui qui vous intéresse.
                    Une fois que vous avez trouvé un fil, cliquez simplement sur le bouton "suivre" pour entrer dans la discussion.
                    Vous pourrez alors lire les messages précédents et y répondre, en ajoutant votre propre contribution à la conversation.
                    C’est un moyen rapide de participer aux échanges et de rester informé des derniers développements sur les sujets qui vous passionnent.</p>

                    <h4>Voir les fils suivis</h4>
                    <p>Pour consulter les fils que vous suivez sur Villeneuve Chat, il vous suffit de cliquer sur l'icone des <a href="navigation?page=filsSuivis">fils suivis <i class="bi-chat-heart"></i></a>.
                    Vous y trouverez tous les fils auxquels vous êtes abonné.
                    En cliquant sur l’un d’eux, vous pourrez voir les dernières mises à jour et répondre aux nouveaux messages.
                    Cela vous permet de rester à jour sur les discussions qui vous intéressent sans avoir à rechercher constamment les fils.</p>

                    <h4>Modifier votre compte</h4>
                    <p>
                        Pour accéder à vos informations, allez dans <a href="navigation?page=compte">l'onglet compte <i class="bi-person-circle"></i></a>.
                        Vous pouvez y modifier votre mot de passe, prénom et votre nom, et voir vos fils créés.
                    </p>

                    <p>
                        Vous savez maintenant naviguer comme un.e pro sur notre plateforme, depuis votre odinateur, tablette ou smartphone !
                        Vous avez encore plein de choses à raconter, d'histoire à partager et de temps à passer sur Villeneuve Chat <i class="bi-heart"></i>
                    </p>

                    <div class="mt-auto">
                        <hr />
                        <p>Projet réalisé au sein de l'IUT de lille pour la <a href="res/SAe_S4_sujet_ReseauSocial.pdf">SAÉ S4.A02.1</a> (Web Backend)</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>