#!/bin/bash

# Controlla se ci sono aggiornamenti disponibili
updates=$(checkupdates 2>/dev/null | wc -l)

# Formatta l'output come JSON per Waybar
if [ "$updates" -eq 0 ]; then
  echo '{"text":"0", "class":"up-to-date", "tooltip":"Il sistema è aggiornato"}'
else
  echo "{\"text\":\"$updates\", \"class\":\"updates-available\", \"tooltip\":\"$updates aggiornamenti disponibili\"}"
fi
