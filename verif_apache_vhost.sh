#!/bin/bash

echo "=== 🔍 Vérification Apache & VHosts ==="

# Vérifier si Apache est installé
if ! command -v apache2 >/dev/null 2>&1; then
  echo "❌ Apache2 n'est pas installé."
  exit 1
fi

# Statut Apache
echo -e "\n-- État du service Apache --"
systemctl status apache2 | grep -E "Active|Loaded"

# Vhosts activés
echo -e "\n-- Vhosts activés --"
ls /etc/apache2/sites-enabled/

# Vérification syntaxe Apache
echo -e "\n-- Test de configuration Apache --"
apachectl configtest

# Ports écoutés
echo -e "\n-- Ports écoutés par Apache --"
ss -tuln | grep ":80\|:443"

# Domaine pointé ?
echo -e "\n-- Adresse IP publique du serveur --"
curl -s ifconfig.me

echo -e "\n-- DNS pointant vers l’IP publique ? (vérifie manuellement si besoin) --"

# Redémarrage Apache proposé
read -p $'\n🔁 Voulez-vous redémarrer Apache ? (o/n) : ' choice
if [[ "$choice" == "o" || "$choice" == "O" ]]; then
  systemctl restart apache2
  echo "✅ Apache redémarré."
else
  echo "⏭️ Apache n’a pas été redémarré."
fi

echo -e "\n✅ Vérification terminée."
