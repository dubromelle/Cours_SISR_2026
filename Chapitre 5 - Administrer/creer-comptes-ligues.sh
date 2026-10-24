#!/bin/bash
# creer-comptes-ligues.sh — crée un compte Linux par membre de ligue
# à partir d'un fichier CSV (séparateur « ; », première ligne = en-têtes).
# Usage : sudo ./creer-comptes-ligues.sh membres-ligues.csv          (création)
#         ./creer-comptes-ligues.sh membres-ligues.csv --test        (simulation)
set -u
export LC_ALL=C.UTF-8      # traitement correct des caractères accentués, quelle que soit la langue du système

fichier="${1:-}"
mode="${2:-}"
journal="/var/log/creation-comptes.log"

# 1. Vérifier les paramètres
if [ -z "$fichier" ] || [ ! -f "$fichier" ]; then
    echo "Usage : $0 fichier.csv [--test]" >&2
    exit 1
fi
if [ "$mode" != "--test" ] && [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être lancé avec sudo (ou avec --test)." >&2
    exit 2
fi

# 2. Fabriquer l'identifiant : prenom.nom, minuscules, sans accents,
#    sans espaces ni apostrophes, 20 caractères au plus
fabriquer_login() {
    echo "$1.$2" \
      | sed -e 's/.*/\L&/' -e 'y/àâäéèêëîïôöùûüç/aaaeeeeiioouuuc/' -e "s/[ ']//g" \
      | cut -c1-20
}

crees=0
ignores=0

# 3. Lire le fichier ligne par ligne, sans la ligne d'en-têtes
while IFS=';' read -r prenom nom ligue fonction; do
    fonction="${fonction%$'\r'}"          # fichier enregistré sous Windows : retirer le retour chariot
    login=$(fabriquer_login "$prenom" "$nom")
    if [ -z "$login" ]; then
        echo "ERREUR  impossible de fabriquer l'identifiant de $prenom $nom" >&2
        continue
    fi
    groupe="ligue-$(echo "$ligue" | sed 's/.*/\L&/')"

    if id "$login" >/dev/null 2>&1; then
        echo "IGNORÉ  $login existe déjà"
        ignores=$((ignores + 1))
        continue
    fi

    if [ "$mode" = "--test" ]; then
        echo "TEST    $login ($prenom $nom, $fonction) -> groupe $groupe"
    else
        getent group "$groupe" >/dev/null || groupadd "$groupe"
        motdepasse=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 12)
        useradd -m -s /bin/bash -c "$prenom $nom - $fonction" -G "$groupe" "$login"
        echo "$login:$motdepasse" | chpasswd
        chage -d 0 "$login"                # changement de mot de passe obligatoire à la 1re connexion
        echo "$(date '+%F %T') CRÉÉ $login groupe=$groupe" >> "$journal"
        echo "CRÉÉ    $login -> groupe $groupe, mot de passe provisoire : $motdepasse"
    fi
    crees=$((crees + 1))
done < <(tail -n +2 "$fichier")

# 4. Bilan
echo "Bilan : $crees compte(s) traité(s), $ignores ignoré(s)."
