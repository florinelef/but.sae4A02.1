#!/bin/bash

# Ce script sert à utiliser l'application avec les données de base installées sans être en salle TP
# Il s'occupe de :
# 1. Créer un conteneur podman (il faut installer podman au préalable)
# 2. Lance les scripts d'initialisation et de setup de la base (repertoire baseDeDonnee)
# 3. Modifie le config.prop pour pouvoir utiliser la base de notre conteneur (ne se push pas dans le repo grâce au .gitignore)

podman run -d --name bdd -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_DB=bdd -p 9090:5432 docker.io/postgres && echo "Création du conteneur réussie"
#On attend que le port fonctionne
sleep 2

PGPASSWORD=password psql -h localhost -p 9090 -U user -d bdd -a -f ../baseDeDonnee/init.sql && PGPASSWORD=password psql -h localhost -p 9090 -U user -d bdd -a -f ../baseDeDonnee/setup.sql && echo "Ajout des tables et des données effectuée !"

echo "driver=org.postgresql.Driver
url=jdbc:postgresql://localhost:9090/bdd
login=user
password=password" > ../WEB-INF/config.prop && echo "Modification du config.prop effectuée."