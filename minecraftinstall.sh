#!/bin/bash

echo "Minecraft Server installer Skript von C-onn3r, https://bit.ly/4cP5qr6"

read -p "Die .jar Dateien werden von files.allemeinedaten.de heruntergeladen, dieser Server wird von mir bereitgestellt, es werden keine daten erfasst. Möchtest du fortfahren? (ja/nein): " choice
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

echo "Welche Minecraft Server-Version möchtest du installieren?"
echo "1 -> 1.20.4"
echo "2 -> 1.20" 
echo "3 -> 1.19.4"
echo "4 -> 1.18.2"
echo "5 -> 1.17.1"
echo "6 -> 1.16.5"

read -p "Deine Auswahl: " minecraft_version

case "$minecraft_version" in
  1  ) wget --output-document=paper.jar https://files.allemeinedaten.de/api/shares/UzMDU0M/files/97aa44a6-0c61-4487-8878-2b6ddfe8481b;; # .20.4   Versions without 1. 
  2  ) wget --output-document=paper.jar https://files.allemeinedaten.de/api/shares/UzMDU0M/files/dff386e7-2c90-4a19-b419-df70f1bc1757;; # .20.0 
  3  ) wget --output-document=paper.jar https://files.allemeinedaten.de/api/shares/UzMDU0M/files/21e9363b-7eed-4627-b95f-dffbe332b983;; # .19.4 
  4  ) wget --output-document=paper.jar https://files.allemeinedaten.de/api/shares/UzMDU0M/files/de2fe5d5-fe08-4ef4-adeb-b03caa8be10e;; # .18.2
  5  ) wget --output-document=paper.jar https://files.allemeinedaten.de/api/shares/UzMDU0M/files/858e910a-cc0a-4225-93b0-99f706e57a7b;; # .17.1 
  6  ) wget --output-document=paper.jar https://files.allemeinedaten.de/api/shares/UzMDU0M/files/ed076320-4e34-4878-9ed2-89d5eb369839;; # .16.5
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
