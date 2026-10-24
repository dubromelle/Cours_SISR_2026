# Notes de livraison : Systèmes et réseaux, chapitre 5 « Administrer, automatiser, dépanner »

BTS SIO 1re année, tronc commun SISR et SLAM (avec des aspects B2.3 réservés aux SISR), 2026-2027 · livraison du 24 octobre 2026

## 1. Fichiers livrés

| Fichier | Rôle |
|---|---|
| `index.html` | Support de cours et de TP interactif, en un seul fichier à ouvrir en local (environ 280 Ko, fichiers du TP 14 intégrés). |
| `membres-ligues.csv` | Copie du fichier du TP 14, déjà téléchargeable depuis le support : 10 membres de 3 ligues, UTF-8, séparateur `;`. |
| `creer-comptes-ligues.sh` | Copie du script Bash du TP 14, déjà téléchargeable depuis le support. |
| `creer-comptes-ad.ps1` | **Réservé à l'enseignant** : la correction du script PowerShell du TP 14, en UTF-8 avec BOM. Elle figure aussi dans la correction du support, que l'étudiant voit après avoir rédigé sa réponse. |

## 2. Support interactif (`index.html`)

### Réglages

- Clé de stockage : `reseaux-sio1-ch5:v1` ; préfixe des identifiants étudiants : `ADM` ; nom des fichiers : `sauvegarde-reseaux-ch5-…json`, `compte-rendu-reseaux-ch5-…html`.
- Public : **tronc commun SISR et SLAM**. Le TP 13 (mission 5) et la partie 3 (centralisation, SNMP) contiennent des aspects de B2.3 plus utiles aux SISR.
- Compétences : B1.1 (gérer le patrimoine informatique), B1.2 (répondre aux incidents et aux demandes), B2.3 SISR (exploitation et administration), B3.3 (sécurité des accès, journalisation, RGPD).
- Règle IA : **pas d'IA**. Elle est rappelée dans les règles du jeu, en tête de chaque partie et dans les consignes des TP.
- Outils : VirtualBox avec SRV-WIN (Windows Server 2019, contrôleur de domaine), SRV-DEB (Debian 12), **PC-CLIENT (Windows 10 ou 11 Pro ou Éducation)**, pfSense (facultatif), GLPI, PowerShell ISE ou VS Code.

### Parcours (environ 13 h 30, défis non compris)

| Étape | Titre | Durée |
|---|---|---|
| Partie 1 | L'annuaire et l'authentification centralisée | 1 h 30 |
| TP 13 | Créer le domaine m2l.lan et y joindre un poste | 2 h 30 |
| Partie 2 | Les scripts d'administration : Bash et PowerShell | 1 h 30 |
| TP 14 | Créer des comptes en masse à partir d'un fichier CSV | 2 h 30 |
| Partie 3 | Journaux et indicateurs | 1 h |
| Partie 4 | Sauvegarder et restaurer | 1 h |
| Partie 5 | Gérer les incidents et les demandes | 1 h |
| TP 15 | Jeu de rôle de dépannage avec GLPI | 2 h 30 |

Le support contient 29 questions de quiz (7 quiz), 23 réponses rédigées avec correction et 9 activités auto-corrigées : 3 associations, 5 tableaux à cocher et 1 sélection de lignes dans un journal. Les TP gardent la numérotation 13 à 15 du plan annuel.

### Décisions de l'enseignant (rappel)

- Plan du chapitre 5 validé au départ. Les cinq parties et les trois TP sont repris tels quels.
- Outils : VirtualBox, Debian, Windows Server 2019, pfSense, GLPI.
- Contexte M2L du Réseau Certa. Pas d'IA.

### Choix faits en l'absence de consigne (à valider)

- **Une machine virtuelle cliente Windows est nécessaire** : PC-CLIENT, en Windows 10 ou 11 **Pro ou Éducation**. L'édition Famille ne peut pas rejoindre un domaine. Elle est sur le réseau interne `tp5` et reçoit son adresse du DHCP de SRV-WIN.
- **Promotion de SRV-WIN (TP 13)** :
  - la zone DNS standard `m2l.lan` du chapitre 3 est d'abord exportée dans un fichier texte puis **supprimée**, pour laisser la promotion créer une zone intégrée à Active Directory ;
  - les enregistrements de `srv-deb` (172.16.2.241, adresse de la DMZ du TP 12, ou 192.168.50.10 si le TP 12 n'a pas été fait) et les alias `www` et `intranet` sont recréés ensuite ;
  - le serveur DHCP est autorisé dans l'annuaire ;
  - la disparition des comptes locaux du TP 9 et des droits du partage `Volley` est exploitée comme un apprentissage : les droits sont refaits avec AGDLP au TP 14.
- **Arborescence de l'annuaire** :
  - `OU=M2L`, avec en dessous `Administration`, `Ligues` (une OU par ligue), `Ordinateurs` et `Groupes` ;
  - groupes `GG_<Ligue>` (globaux, dans l'OU de la ligue) et `GL_Partage_Volley_M` (domaine local, dans `Groupes`) ;
  - compte d'administration distinct `adm.paul.garnier`.
- **GPO et politique de mots de passe** :
  - la GPO `GPO-Ligues-Restrictions` (pas de Panneau de configuration) est liée à l'OU `Ligues` ;
  - mots de passe de 12 caractères au moins, verrouillage après 5 échecs pendant 15 minutes.
- **Règle de nommage** `prenom.nom`, en minuscules, sans accents, espaces ni apostrophes, et de 20 caractères au plus (limite de `SamAccountName`). Elle est commune au script Bash et au script PowerShell.
- **Script Bash fourni, script PowerShell à écrire.** Le TP 14 donne le script Linux pour la lecture de code et demande d'écrire celui d'Active Directory.
  - Les étudiants SLAM peuvent faire le lien avec le C# : variables, conditions, boucles, fonctions.
  - Mot de passe provisoire : `M2l!` suivi de 8 caractères aléatoires sans caractères ambigus. Le préfixe garantit la complexité exigée par défaut.
- **GLPI (TP 15)** :
  - le support suppose **une instance GLPI fournie par l'enseignant** ;
  - chaque étudiant a deux comptes, l'un avec le profil *Self-Service*, l'autre avec le profil *Technician* ;
  - le support n'en décrit pas l'installation. Elle pourrait faire l'objet d'un TP SLAM (PHP, MariaDB) ou d'un TP de 2e année.
- **Matrice de priorité** de la partie 5 : matrice 3 × 3 (impact × urgence), avec des priorités de 1 à 5. Elle est cohérente avec le calcul par défaut de GLPI, mais simplifiée.
- **Exemples chiffrés** :
  - sauvegardes : 100 Go et 5 Go modifiés par jour, soit 130 Go en incrémentales et 205 Go en différentielles, avec une panne le jeudi matin ;
  - RAID avec des disques de 4 To ;
  - journal SSH avec une attaque depuis le Wi-Fi visiteurs `172.16.0.57`, ce qui révèle aussi une erreur de règle du pare-feu ;
  - serveur de journaux et de sauvegarde à l'adresse fictive `172.16.2.230` (réseau des serveurs).

### Catalogue des pannes du TP 15 (réservé à l'enseignant)

Chaque panne est à introduire après l'instantané `avant-TP15`, dans un ordre de difficulté croissante. La « fiche utilisateur » indique ce que l'étudiant qui joue l'utilisateur dit au téléphone.

| N° | Panne à introduire | Fiche utilisateur | Diagnostic attendu | Correction |
|---|---|---|---|---|
| 1 | Carte réseau de PC-CLIENT « câble débranché » dans VirtualBox | « Je n'ai plus rien, ni Internet ni le dossier de la ligue. » | `ipconfig` : média déconnecté | Reconnecter le câble virtuel |
| 2 | Étendue DHCP désactivée : `Set-DhcpServerv4Scope -ScopeId 192.168.50.0 -State InActive`, puis `ipconfig /release` sur le poste | « Mon ordinateur affiche “pas d'Internet” depuis que je l'ai redémarré. » | Adresse 169.254.x.x ; `Get-DhcpServerv4Scope` | `-State Active`, puis `ipconfig /renew` |
| 3 | Compte `lea.martin` désactivé (`Disable-ADAccount`) | « Mon mot de passe ne marche plus, mais je suis sûre de moi. » | Message « Votre compte a été désactivé » ; `Get-ADUser -Properties Enabled` | `Enable-ADAccount` ; chercher qui l'a désactivé (événement 4725) |
| 4 | `jean-marc.dubois` retiré de `GG_Volley` | « Je ne peux plus ouvrir le dossier Volley, mes collègues oui. » | Accès refusé ; `whoami /groups`, `Get-ADGroupMember` | Le remettre dans le groupe, puis fermer et rouvrir la session |
| 5 | Enregistrement DNS `intranet` supprimé | « Le site intranet ne s'affiche plus. » | Le site répond par son adresse IP mais pas par son nom ; `nslookup intranet.m2l.lan` | Recréer l'alias |
| 6 | Apache arrêté et désactivé sur SRV-DEB (`systemctl disable --now apache2`) | « Le site web de la M2L ne répond plus. » | `ping` OK, `Test-NetConnection -Port 80` en échec ; `systemctl status apache2` | `systemctl enable --now apache2` |
| 7 | Erreur de syntaxe dans `/etc/apache2/sites-enabled/000-default.conf` (balise non fermée), puis redémarrage d'Apache | « Le site ne marche plus depuis la maintenance de ce matin. » | `systemctl status apache2`, `journalctl -u apache2`, `apache2ctl configtest` | Corriger la ligne indiquée, `configtest`, puis redémarrage |
| 8 | Horloge de PC-CLIENT avancée de 20 minutes, synchronisation désactivée | « Impossible d'ouvrir ma session, l'ordinateur dit qu'il y a un problème. » | Message sur l'heure ; écart > 5 min (Kerberos) | Corriger l'heure, `w32tm /resync` |
| 9 | Option DHCP 006 (serveur DNS) remplacée par `192.168.50.62` | « Plus aucun nouvel ordinateur ne peut rejoindre le domaine. » | `ipconfig /all` : mauvais serveur DNS ; `nslookup -type=SRV _ldap._tcp.m2l.lan` en échec | Remettre `192.168.50.20` |
| 10 | (SISR, si pfSense est en place) règle LAN vers DMZ HTTP désactivée | « Le site web marche depuis chez moi mais pas au bureau. » | Le test depuis le WAN est réussi, celui depuis le LAN échoue ; journal du pare-feu | Réactiver la règle |

Pannes à **éviter** : renommer ou supprimer le domaine, modifier le mot de passe DSRM, toucher aux rôles FSMO. Une erreur de manipulation pendant la réparation obligerait à repartir de l'instantané.

### Corrections apportées aux sources

- Pas de nouvelle source pour ce chapitre. Le contenu s'appuie sur le guide d'accompagnement (B1.1, B1.2, B2.3 SISR, B3.3) et sur le contexte M2L.
- Mises à jour techniques intégrées :
  - Debian 12 n'installe plus `rsyslog` par défaut : on utilise `journalctl`, et `/var/log/auth.log` n'existe que si l'on ajoute le paquet ;
  - Windows PowerShell 5.1 lit les `.ps1` sans BOM en Windows-1252, d'où la consigne d'enregistrer en UTF-8 avec BOM.

### Ajouts par rapport aux sources

- Script Bash complet et testé (mode `--test`, idempotence, retrait du retour chariot Windows, nommage, journal, changement de mot de passe obligatoire).
- Script PowerShell de correction (OU et groupes créés à la demande, mot de passe aléatoire, journal, `-Test`).
- Défis :
  - désactivation des comptes des membres partis, avec la durée de conservation exigée par le RGPD ;
  - choix de ne pas joindre un serveur de la DMZ au domaine ;
  - bilan du centre de services à partir des statistiques de GLPI.
- Dépannage du domaine : contrôleur introuvable (DNS), relation d'approbation rompue après la restauration d'un instantané, décalage d'horloge et Kerberos.
- Encadrés : obligations CNIL sur les journaux, rançongiciels et règle 3-2-1-1-0, SNMPv3, rotation GFS, le métier de technicien support.
- Fiches mémo : notions et commandes (Active Directory, GPO, AGDLP, comptes Linux, journaux, indicateurs, sauvegarde).

### Tests réalisés

- Chromium (Playwright), à 1 280 px et 375 px de large :
  - aucune erreur JavaScript (seules les polices Google ne se chargent pas hors ligne) ;
  - aucun défilement horizontal de la page.
- Les 9 activités auto-corrigées et les 7 quiz (29 questions) ont été remplis avec les réponses attendues : le moteur les note tous justes.
- Réponse rédigée, téléchargement des deux fichiers du TP 14 (identiques aux originaux), sauvegarde, compte rendu et restauration dans un navigateur vierge : conformes.
- Thème sombre vérifié par captures d'écran. Deux corrections :
  - un libellé du schéma des tickets chevauchait une flèche ;
  - la figure 3-2-1 a été remplacée par des cartes lisibles sur téléphone.
- **Script Bash réellement exécuté** dans un conteneur Debian : création des 10 comptes, relance (10 ignorés), fichier enregistré sous Windows (CRLF), mode test, refus sans droits root. Les comptes de test ont été supprimés. Les exemples Bash de la partie 2 (trace, seuil du disque) et la restauration `tar` d'un seul fichier ont aussi été exécutés.
- Les calculs (volumes de sauvegarde, capacités RAID, adresse de la ligue 06) ont été vérifiés.
- **Aucune commande PowerShell, Active Directory ni GLPI n'a été exécutée** pendant la préparation (pas de Windows Server ni de GLPI disponibles ici).

## 3. Diaporama de lancement

Pas encore produit (à la demande).

## 4. Points à vérifier avant distribution

- [ ] Ouvrir `index.html` dans Firefox sous Windows et sous Kubuntu : sauvegarde, reprise, téléchargement des deux fichiers du TP 14.
- [ ] **Refaire le TP 13 sur Windows Server 2019** :
  - [ ] `Remove-DnsServerZone` avant la promotion, puis `Install-ADDSForest` ;
  - [ ] messages exacts (jonction, relation d'approbation, horloge) ;
  - [ ] intitulé de la stratégie « Interdire l'accès au Panneau de configuration et à l'application Paramètres du PC » ;
  - [ ] effet de `Set-GPRegistryValue` sur le poste.
- [ ] **Exécuter `creer-comptes-ad.ps1`** sur le domaine de test : nommage (`emilie.rousseau-dela`), compte `lea.martin` ignoré, complexité des mots de passe, encodage des fonctions accentuées.
- [ ] Vérifier `Grant-SmbShareAccess` et `icacls` avec le préfixe `M2L\` sur le partage `Volley` du TP 9.
- [ ] Préparer l'instance GLPI : comptes Self-Service et Technician par étudiant, catégories (Réseau, Compte, Impression, Web, Poste), matrice de priorité, intitulés des menus selon la version installée.
- [ ] Préparer les fiches utilisateur et les enveloppes de pannes du TP 15 à partir du catalogue (section 2).
- [ ] Vérifier que les postes de la salle peuvent faire tourner trois machines virtuelles en même temps (SRV-WIN, SRV-DEB, PC-CLIENT), plus pfSense.
- [ ] Valider les choix faits en l'absence de consigne (section 2).

## 5. Autres remarques

- Le domaine `m2l.lan`, les journaux et GLPI servent au chapitre 6 (cybersécurité) : durcissement des comptes, analyse de journaux, gestion des vulnérabilités, réponse à incident.
- Le TP 14 se prête à un travail commun avec les enseignants de programmation (SLAM) : même algorithme en C#, en Bash et en PowerShell.
