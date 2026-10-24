# Notes de livraison : Systèmes et réseaux, chapitre 6 « Sécuriser le système d'information »

BTS SIO 1re année, tronc commun SISR et SLAM (bloc 3), 2026-2027 · livraison du 24 octobre 2026

## 1. Fichiers livrés

| Fichier | Rôle |
|---|---|
| `index.html` | Support de cours et de TP interactif, en un seul fichier à ouvrir en local (environ 305 Ko, capture intégrée). |
| `capture-ch6-http-https.pcap` | Copie de la capture de la partie 4, déjà intégrée au support (24 trames). Elle contient une connexion à un formulaire en HTTP, avec le mot de passe et le cookie de session lisibles, puis la même connexion en HTTPS (TLS 1.3). |

**Correctif du chapitre 5 livré en même temps.** Dans le `index.html` du chapitre 5 livré plus tôt, les quiz des parties 2 à 5 n'avaient ni titre ni étiquette « Quiz de fin de partie ». Ils apparaissaient donc mal nommés dans le bilan et absents de la rubrique correspondante du compte rendu. Le fichier corrigé remplace le précédent. Les étudiants qui ont déjà commencé gardent leurs réponses : les identifiants des activités n'ont pas changé.

## 2. Support interactif (`index.html`)

### Réglages

- Clé de stockage : `reseaux-sio1-ch6:v1` ; préfixe des identifiants étudiants : `SEC` ; nom des fichiers : `sauvegarde-reseaux-ch6-…json`, `compte-rendu-reseaux-ch6-…html`.
- Public : **tronc commun SISR et SLAM**.
  - La partie 3 et le TP 16 (commutateurs, Wi-Fi) sont plus orientés SISR, mais ne demandent que les bases de commutation du chapitre 2.
  - Les parties 2 et 4 (mots de passe, hachage, HTTPS) et un défi du TP bonus s'adressent directement aux SLAM.
- Compétences : B3.1, B3.2, B3.3, B3.4 ; B2.3 SISR pour la sécurité des équipements d'interconnexion.
- Règle IA : **pas d'IA**. Elle est rappelée dans les règles du jeu, en tête de chaque partie et dans les consignes des TP.
- Cadre légal affiché dès la page de démarrage : les outils de test (analyse de ports, capture, tests de mots de passe) ne servent que sur la maquette (article 323-1 du Code pénal).

### Parcours (environ 15 h 30, défis non compris)

| Étape | Titre | Durée |
|---|---|---|
| Partie 1 | Les fondamentaux : risques, besoins de sécurité et cadre légal | 1 h 30 |
| Partie 2 | Attaques courantes et protection des identités | 1 h 30 |
| Partie 3 | Sécuriser l'accès au réseau : commutateurs et Wi-Fi | 1 h 30 |
| TP 16 | Sécuriser le réseau d'accès de la M2L (Packet Tracer) | 2 h 30 |
| Partie 4 | Chiffrement, certificats et HTTPS | 1 h 30 |
| TP 17 | Durcir et auditer le serveur web (SRV-DEB) | 3 h |
| Partie 5 | Vulnérabilités et réponse à incident | 1 h |
| TP bonus | Mission intégratrice : audit de sécurité de la M2L | 3 h |

Le support contient :
- 25 questions de quiz, réparties en 5 quiz ;
- 25 réponses rédigées avec leur correction ;
- 7 activités auto-corrigées : 3 tableaux à cocher, 2 associations et 2 sélections de lignes (un courriel d'hameçonnage et la capture).

### Décisions de l'enseignant (rappel)

- Plan annuel : chapitre 6 consacré à la cybersécurité, avec les TP 16 et 17 et un TP bonus intégrateur.
- Outils : Packet Tracer, matériel Cisco, VirtualBox, Debian, Windows Server 2019, pfSense, GLPI.
- Contexte M2L du Réseau Certa. Pas d'IA.

### Choix faits en l'absence de consigne (à valider)

- **Plan détaillé reconstruit.** Je n'ai pas retrouvé le détail du plan du chapitre 6 validé au début de l'année : seuls les grands thèmes avaient été conservés. Le découpage a donc été reconstruit à partir de ce qui avait été annoncé dans les chapitres 4 et 5 :
  - sécurité du réseau d'accès, 802.1X, WPA3, surveillance DHCP ;
  - durcissement des comptes, journaux, gestion des vulnérabilités, réponse à incident.

  **À comparer avec le plan que vous aviez validé.**
- **TP 16 sur un réseau à plat** (VLAN 1) pour rester accessible aux SLAM, qui n'ont pas suivi le chapitre 4 :
  - réseau de la ligue de volley (ligue 06, `172.16.8.160/27`) ;
  - le VLAN 106 et l'inspection ARP dynamique sont proposés en défi.
- **802.1X filaire traité en cours seulement.** Packet Tracer ne gère pas, à ma connaissance, 802.1X sur les ports des commutateurs. Le TP met donc en œuvre RADIUS par le Wi-Fi WPA2 Entreprise (borne WRT300N et service AAA d'un Server-PT).
- **Faux serveur DHCP** simulé par un second Server-PT nommé PIRATE (`10.66.66.0/24`).
- **TP 17** :
  - certificat **auto-signé** pour la maquette ; le certificat de l'autorité interne (AD CS) est proposé en défi ;
  - **HSTS volontairement laissé en commentaire** : avec un certificat auto-signé, il rendrait le site inaccessible ;
  - le serveur a besoin d'un accès aux dépôts Debian ;
  - audit avec Lynis et nmap, installés sur SRV-DEB lui-même ;
  - test des ports depuis PC-CLIENT avec `Test-NetConnection`.
- **TP bonus** :
  - audit par binômes avec lettre de mission ;
  - 12 constats inventés, cohérents avec les chapitres 2 à 5 ;
  - cotation des risques sur 16 (vraisemblance × gravité, de 1 à 4 chacune), plan d'action, page de sensibilisation, restitution orale de 5 minutes ;
  - deux défis : un exercice de crise sur table animé par l'enseignant, et l'audit d'une application PHP pour les SLAM, selon l'OWASP.
- **Durée** : environ 15 h 30, dont 3 h pour le TP bonus, que l'on peut ne faire qu'en partie (missions 2, 3 et 5 seulement, par exemple).

### Corrections apportées aux sources et points d'actualité

- Recommandation de la CNIL sur les mots de passe (2022), vérifiée sur cnil.fr :
  - le principe est un niveau d'entropie : 80 bits pour un mot de passe seul, 50 bits avec une restriction d'accès, 13 bits avec un matériel détenu et un blocage après 3 échecs ;
  - le renouvellement périodique n'est plus exigé pour les comptes ordinaires.
- Code pénal, article 323-1 :
  - 3 ans et 100 000 € pour l'accès frauduleux, depuis la loi du 24 janvier 2023 ;
  - 5 ans et 150 000 € s'il y a des dommages.
- **NIS 2** : à l'automne 2026, le projet de loi de transposition (« résilience des infrastructures critiques ») n'était **pas encore définitivement adopté**. Son examen à l'Assemblée a été reporté en octobre 2026. Le support le dit ; à mettre à jour selon l'évolution.
- **Certificats** : le support indique que les durées maximales des certificats publics sont réduites progressivement (200 jours depuis mars 2026, 47 jours prévus en 2029). À vérifier si le calendrier a changé.
- **Debian 12** : `rsyslog` n'est plus installé par défaut, d'où `backend = systemd` pour fail2ban (paquet `python3-systemd`). Hachage des mots de passe système : yescrypt (`$y$`).

### Ajouts par rapport aux sources

- **Capture pcap fabriquée** (24 trames, sommes de contrôle IP et TCP correctes). Elle montre une connexion HTTP avec un formulaire de connexion et un cookie `PHPSESSID` en clair, puis la même connexion en HTTPS :
  - un Client Hello TLS 1.3 valide, avec SNI `intranet.m2l.lan`, trois suites de TLS 1.3 et un key_share X25519 ;
  - un Server Hello qui choisit `TLS_AES_128_GCM_SHA256`, suivi de données chiffrées (aléatoires).

  La capture passe par pfSense : TTL 63 côté serveur.
- **Calculs d'entropie et de temps d'attaque**, vérifiés par calcul : 37,6 / 47,6 / 79,6 / 83,4 bits ; Diceware à 6 mots, 77,5 bits ; condensats SHA-256 réels.
- **Exemples et encadrés** : guide d'hygiène de l'ANSSI, WannaCry (MS17-010), Log4Shell (CVE-2021-44228), évaluation des failles avec le catalogue KEV, faux point d'accès (*evil twin*), ce que le cadenas ne garantit pas, règles professionnelles en stage.
- **Fiches mémo** : notions et commandes (Cisco, SSH, OpenSSL, ufw, fail2ban, audit).

### Tests réalisés

- Chromium (Playwright), à 1 280 px et 375 px de large :
  - aucune erreur JavaScript (seules les polices Google ne se chargent pas hors ligne) ;
  - aucun défilement horizontal de la page.
- Les 7 activités auto-corrigées et les 5 quiz (25 questions) ont été remplis avec les réponses attendues : le moteur les note tous justes.
- Réponse rédigée, téléchargement de la capture (fichier identique à l'original), sauvegarde, compte rendu et restauration dans un navigateur vierge : conformes.
- Captures d'écran en thème sombre et sur téléphone. Deux corrections :
  - un libellé du schéma 802.1X sortait de son cadre ;
  - trois éléments des cartes de partie étaient trop longs.
- La capture a été relue avec un décodeur maison (sommes de contrôle, enregistrements TLS), mais **pas dans Wireshark**.
- **Non exécutés ici** : configurations Packet Tracer, commandes Cisco, configuration Apache, OpenSSL, SSH, ufw et fail2ban (pas de Debian complet avec systemd, ni de Packet Tracer). Les commandes Debian ont été écrites pour Debian 12 et sont à valider en salle.

## 3. Diaporama de lancement

Pas encore produit (à la demande).

## 4. Points à vérifier avant distribution

- [ ] Comparer le découpage du chapitre avec le plan validé au départ (section 2).
- [ ] Ouvrir la capture dans Wireshark : affichage `TLSv1.3`, SNI, « Suivre le flux TCP » sur la connexion HTTP.
- [ ] **TP 16 dans la version de Packet Tracer du lycée** :
  - [ ] `ip dhcp snooping`, avec la nécessité de `no ip dhcp snooping information option` ;
  - [ ] passage de la requête DHCP des clients sans fil à travers la WRT300N en pont, qui reçoit son adresse sur un port LAN (sinon, utiliser une adresse statique, prévue dans la correction) ;
  - [ ] intitulés exacts de *Wireless Security* (WPA2 Enterprise) et du service AAA ;
  - [ ] `clear port-security sticky` et `ip arp inspection` (défi).
- [ ] **TP 17 sur un SRV-DEB réel** :
  - [ ] `sshd -T` (valeur `without-password`) ;
  - [ ] `unattended-upgrades` ;
  - [ ] configuration Apache SSL et redirection ;
  - [ ] `openssl s_client -tls1_1` (message obtenu) ;
  - [ ] démarrage de fail2ban avec `backend = systemd` ;
  - [ ] indice Lynis avant et après.
- [ ] Copie de la clé publique depuis Windows : la commande `type … | ssh …` en PowerShell.
- [ ] Préparer pour le TP bonus le déroulé de l'exercice de crise (4 événements, toutes les 5 minutes) et l'organisation des restitutions orales.
- [ ] Valider les choix faits en l'absence de consigne.

## 5. Autres remarques

- Ce chapitre clôt le parcours annuel des chapitres 2 à 6. Il reste le chapitre 1 (système et poste de travail, TP 1 à 3) et les diaporamas de lancement.
- Le TP bonus peut servir d'épreuve de synthèse de fin d'année ou de préparation aux situations professionnelles du portefeuille de compétences.
