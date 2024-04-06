#!/bin/bash

echo "Minecraft Server installer Skript von C-onner -> https://c-onner.de"

read -p "Möchtest du die Installation starten? (ja/nein): " choice
case "$choice" in
  j|J|ja|Ja ) echo "Weiter geht's...";;
  * ) echo "Abbruch."; exit;;
esac

java -version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Java ist bereits installiert."
else
  echo "Java ist nicht installiert!"
  read -p "Welche Java-Version soll installiert werden? (11/17): " java_version
  sudo apt update
  sudo apt install openjdk-$java_version-jdk-headless -y
fi

read -p "Wie soll der Ordner heißen, in dem der Server installiert werden soll? " folder_name
mkdir $folder_name
cd $folder_name

read -p "Welche Minecraft Server-Version möchtest du installieren? (1.19.4, 1.18.2, 1.17.1, 1.16.5): " minecraft_version
case "$minecraft_version" in
  1.19.4 ) wget https://media.c-onner.det/_/download/scripts/minecraft/1.19/paper.jar;;
  1.18.2 ) wget https://media.c-onner.det/_/download/scripts/minecraft/1.18/paper.jar;;
  1.17.1 ) wget https://media.c-onner.det/_/download/scripts/minecraft/1.17/paper.jar;;
  1.16.5 ) wget https://media.c-onner.det/_/download/scripts/minecraft/1.16/paper.jar;;
  * ) echo "Ungültige Eingabe. Abbruch."; exit;;
esac

echo "Die Server .jar wurde erfolgreich installiert."

read -p "Wie viel MB Ram darf der Server nutzen? (Mindestens 512 MB!): " ram_amount

case "$ram_amount" in
    *[!0-9]*|0*)
        echo "Ungültige Eingabe. Abbruch."
        exit 1
        ;;
    * )
        ram_in_mb="$ram_amount"
        ;;
esac

# Erzeuge den Startbefehl für den Minecraft-Server
echo "screen -S minecraftserver java -Xms${ram_in_mb}M -Xmx${ram_in_mb}M -jar paper.jar" > start.sh

sudo apt install screen -y
chmod +x start.sh

echo "Dein Server wurde erfolgreich eingerichtet!"
echo "Beachte, dass du die eula.txt noch akzeptieren musst!"
echo "Erledige dies einfach mit 'nano eula.txt -> FALSE zu TRUE AENDERN!'."
echo "Deinen Server kannst du übrigens mit './start.sh' starten!"
./start.sh
