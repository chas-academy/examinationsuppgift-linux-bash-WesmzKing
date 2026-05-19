#!/bin/bash
#Säger till linux att köra detta scriptet med bash kod eller då enligt frågorna Execute the file using the Bash shell.

echo "This file will start to check if you have the correct rights to run this script"
sleep 1
# pausar scriptet i angiva sekunder, i detta fallet satte jag 1 sekund.

if [[ $EUID -ne 0 ]]; then
# Detta statement frågar om EUID (aktuell användare) not qeual till 0.
# Om använderen är vanlig användare och då UID 1001 som exempel kommer statment att bli TRUE.
# I detta fallet innebär TRUE att användern INTE är root och scriptet avslutas.
echo "You are not permitted to run this script, run as root"
exit 1
# exit 1 avslutar scriptet
fi
# fi är slutet av ett if statment.

for user in "$@"; do
# for 
echo "creating $user"
useradd -m "$user"
# useradd + -m skapar användaren + en hemkatalog samtidigt, blir då /home/användarnamnet
mkdir -p "/home/$user/Documents"
mkdir -p "/home/$user/Downloads"
mkdir -p "/home/$user/Work"
#mkdir 

chmod 700 "/home/$user/Documents"
chmod 700 "/home/$user/Downloads"
chmod 700 "/home/$user/Work"
#chmod 700 ger ägaren full rättigheter att read, write och execute.
#chmod läses som 7 0 0 där 7 är för ägaren, 0 är group rättigheter och sista 0:an är rättigheterna för alla andra.
#Med chmod 700 har däför $user fulla rättigheter över filerna som root tilldelat dom.

echo "Välkommen $user" > /home/$user/welcome.txt
# Genom att använda > skickas echo meddelandet och filen Welcome.txt skapas.
# Genom att sedan köra cat Welcome.txt kan man se innehållet i filen.
# > skickar med andra ord outputen till en fil istället för rätt ut i terminalen.
cut -d: -f1 /etc/passwd >> /home/$user/welcome.txt
# cut används för att klippa ut delar av text
# -d agerar som ett sätt att separera text, i detta fallet är det ":" som vi letar efter.
# -f1 använder första fältet i texten.
# Genom detta så istället för massa tecken, siffor och bokstäver som är svåra att läsa så tar den bara första delen i testen till nästa : vilket blir användarnamnet.
# >> skickar meddelandet längst ner i filen, i detta fallet lösenordet för användaren
done
# done avslutar for statment
