#!/bin/bash
echo "driver=org.postgresql.Driver
url=jdbc:postgresql://psqlserv/but2
login=maximegosselinetu
password=moi" > ../WEB-INF/config.prop && echo "Modification du config.prop effectuée."