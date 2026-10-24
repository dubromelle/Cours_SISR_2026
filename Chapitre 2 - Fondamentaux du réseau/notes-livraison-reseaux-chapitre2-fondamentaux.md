# Notes de livraison : Systèmes et réseaux, chapitre 2 « Les fondamentaux des réseaux : du câble à IPv4 et IPv6 »

BTS SIO 1re année, 2026-2027 · livraison du 23 octobre 2026

## 1. Fichiers livrés

| Fichier | Rôle |
|---|---|
| `index.html` | Support de cours et de TP interactif, en un seul fichier à ouvrir en local (environ 370 Ko, captures Wireshark intégrées). |
| `capture-tp4-ethernet-arp.pcap` | Copie de la capture du TP 4 (déjà intégrée au support, téléchargeable depuis la page du TP). |
| `capture-tp7-ipv6-ndp.pcap` | Copie de la capture du TP 7 (déjà intégrée au support). |

## 2. Support interactif (`index.html`)

### Réglages

- Clé de stockage : `reseaux-sio1-ch2:v1` ; préfixe des identifiants étudiants : `NET` ; nom des fichiers : `sauvegarde-reseaux-ch2-…json`, `compte-rendu-reseaux-ch2-…html`.
- Règle IA : **pas d'IA** pendant tout le chapitre. Elle est rappelée dans les « Règles du jeu » de la page de démarrage, dans l'encadré « Avant de commencer » de chaque partie et dans les consignes de chaque TP. La calculatrice est interdite pour les calculs d'adressage, sauf mention contraire.
- Outils : Cisco Packet Tracer, Wireshark, VirtualBox (Debian, Windows Server 2019, réseau interne), invite de commandes et PowerShell, terminal Linux. Matériel Cisco réel en option (TP 7).
- Règle de sécurité affichée : ne jamais modifier la configuration réseau d'un poste physique du lycée. Les configurations se font dans Packet Tracer ou dans les machines virtuelles.
- Fil rouge : contexte M2L (Maison des Ligues de Lorraine) du Réseau Certa.

### Parcours (environ 14 h 45, défis non compris)

| Étape | Titre | Durée |
|---|---|---|
| Partie 1 | Qu'est-ce qu'un réseau ? | 45 min |
| Partie 2 | Les modèles OSI et TCP/IP | 1 h |
| Partie 3 | Couches physique et liaison : câbles, Wi-Fi, Ethernet | 1 h 30 |
| TP 4 | Observer le réseau avec Wireshark | 1 h 30 |
| Partie 4 | L'adressage IPv4 | 1 h 30 |
| TP 5 | Calculer et configurer des adresses IPv4 | 1 h 30 |
| Partie 5 | Sous-réseaux, VLSM et plan d'adressage | 1 h 30 |
| TP 6 | Le plan d'adressage de la M2L | 1 h 30 |
| Partie 6 | ARP, ICMP et méthode de diagnostic | 1 h |
| Partie 7 | L'adressage IPv6 | 1 h 30 |
| TP 7 | IPv6 en pratique | 1 h 30 |

Le support contient 49 questions de quiz, 31 réponses rédigées avec correction et 18 activités auto-corrigées (tableaux à cocher, associations, lignes à repérer). Les TP gardent la numérotation 4 à 7 du plan annuel, car les TP 1 à 3 appartiennent au chapitre 1.

### Décisions de l'enseignant

- Un support par chapitre (six chapitres sur l'année). Ce chapitre 2 est produit en premier.
- Outils : VirtualBox, Cisco Packet Tracer, matériel Cisco, Debian et Windows Server 2019, pfSense, GLPI (pfSense et GLPI ne servent qu'à partir des chapitres 4 et 5).
- Entreprise fil rouge : un contexte du Réseau Certa. C'est la M2L qui a été retenue.
- Le chapitre 4 (bloc 2 SISR) ne sera pas suivi par les étudiants SLAM.
- Pas d'IA dans ce cours.
- Objectif de profondeur : qu'une personne qui suit le support soit capable d'enseigner les notions. D'où les encadrés « En profondeur » (historique, normes, fonctionnement interne) et « En entreprise » (réalité du terrain).

### Corrections apportées aux sources (à valider)

- Le fil rouge était annoncé en `.docx` (« GuideAccompagnement30oct2020.docx »). Il a été fourni en PDF ; c'est le PDF qui a servi. Le `.docx` joint est l'extrait de l'arrêté.
- Contexte M2L, plan de nommage : le format est écrit avec un point avant le numéro de prise (« …S[salle].P[poste] »), mais l'exemple donné (`BAE2L06S01P01`) n'en a pas. Le support retient la forme **sans point**, puisqu'un point dans un nom d'hôte est interprété comme un séparateur DNS. L'incohérence est expliquée aux étudiants dans un encadré du TP 6.
- Le contexte M2L ne donne aucun plan d'adressage : sa segmentation est un projet. Le plan IPv4 et IPv6 du TP 6 et du TP 7 est donc une **proposition pédagogique**, présentée comme telle aux étudiants. Il ne s'agit pas d'un plan officiel du Réseau Certa.
- Source du contexte M2L : le document « © Réseau Certa – Contexte M2L – BTS SIO » consulté est une copie hébergée sur fchevalier.net. Vérifier qu'il correspond à la version que vous utilisez avec vos étudiants.
- La demande citait un « Bloc 3 SISR » en 1re année. Le bloc 3 est commun aux deux options en 1re année (B3.1 à B3.4). Ce chapitre en traite la partie « chaîne de connexion du poste » (B3.3).

### Ajouts par rapport aux sources

- **Deux captures pcap fabriquées pour le cours**, intégrées au support (lien de téléchargement dans la page, aucun droit d'administration nécessaire) :
  - TP 4 (11 trames) : sollicitation de routeur IPv6, requête et réponse ARP vers le serveur, deux pings, ARP vers la passerelle, ping vers 9.9.9.9.
  - TP 7 (9 trames) : RS, RA (préfixe 2001:db8:acad:1::/64, A = 1, M = O = 0), NS de détection d'adresse dupliquée depuis `::`, NS et NA vers le serveur, deux pings IPv6.
  - Les sommes de contrôle sont correctes. Les adresses MAC utilisent les OUI VirtualBox (08:00:27) et Cisco (00:00:0c).
- Résultats attendus chiffrés, recalculés : tailles de trames 42, 60 et 98 octets (remplissage expliqué) ; temps de réponse 0,372 ms et environ 19,3 ms ; TTL 57, soit environ 7 routeurs ; EUI-64 ; adresses de nœud sollicité ; tous les calculs IPv4 (réseau, diffusion, plage, nombre d'hôtes) ; découpages VLSM ; résumés de routes.
- Plan d'adressage IPv4 de la M2L :
  - services dans `172.16.0.0/21` : Wi-Fi /23, téléphonie /25, administration /26, salle multimédia /27, serveurs /28, DMZ /29, interconnexion /30 ;
  - ligues dans `172.16.8.0/22`, un /27 par ligue, avec la règle « 172.16.8.0 + (n − 1) × 32 » ;
  - passerelle sur la dernière adresse utilisable.
- Plan IPv6 de la M2L dans `2001:db8:4d32::/48` (préfixe de documentation) : 4ᵉ groupe `0100` à `0700` pour les services, `10nn` pour les ligues.
- Tickets d'incident à diagnostiquer : mauvais masque, mauvaise passerelle, adresse en double, adresse de diffusion attribuée, APIPA, DNS, poste isolé.
- Pièges pratiques documentés : le pare-feu de Windows Server bloque le ping entrant (règles `FPS-ICMP4-ERQ-In` et `FPS-ICMP6-ERQ-In`) ; câble défectueux qui négocie à 100 Mb/s ; adresses MAC aléatoires en Wi-Fi.
- Liens vers les autres chapitres : chapitre 1 (poste, carte réseau), chapitre 3 (DHCP, DNS, TCP/UDP), chapitre 4 (NAT, VLAN, résumé de routes), chapitre cybersécurité (usurpation ARP, Wi-Fi, IPv6 et pare-feu).
- Défis facultatifs : capture en direct avec `tcpdump` dans la machine virtuelle, plus petit réseau commun, passage à 80 ligues, résumé IPv6 des ligues.
- Fiche mémo en deux tableaux dans le bilan : notions, et commandes Windows / Linux / Cisco.
- Styles ajoutés au gabarit (le moteur n'a pas été modifié) : encadrés « En profondeur » et « En entreprise », schémas SVG adaptés au thème sombre, tableaux binaires, bandeau d'encapsulation.

### Tests réalisés

- Chromium (Playwright), à 1 280 px et 375 px de large : aucune erreur JavaScript. Seules les polices Google ne se chargent pas hors ligne, et les polices système prennent le relais comme prévu. Aucun défilement horizontal de page sur téléphone.
- Les 31 activités auto-corrigées (quiz, tableaux, associations, lignes à repérer) ont été remplies avec les réponses attendues : toutes notées justes par le moteur.
- Réponse rédigée : la correction se débloque après la rédaction, puis l'auto-évaluation fonctionne.
- Fichiers : création du fichier de sauvegarde, bouton Sauvegarder, téléchargement des deux captures (fichiers identiques aux originaux), compte rendu téléchargé.
- Restauration du fichier de sauvegarde dans un navigateur vierge : les réponses reviennent.
- Thème sombre contrôlé par captures d'écran : schémas, tableaux, encadrés et blocs de code lisibles.
- Tous les calculs IPv4 et IPv6 du support recalculés indépendamment avec le module `ipaddress` de Python.
- Les captures ont été relues avec un décodeur écrit pour l'occasion (contenu de chaque trame, sommes de contrôle), mais **pas dans Wireshark**.

## 3. Diaporama de lancement

Pas encore produit. Il peut être proposé à la demande : 12 à 14 diapositives, avec des questions à main levée sur la taille de bloc et sur « local ou distant ».

## 4. Points à vérifier avant distribution

- [ ] Ouvrir `index.html` sous Windows 11 et sous Kubuntu (Firefox) : création de la sauvegarde, reprise du fichier, et téléchargement des captures depuis les TP 4 et 7 (lien `data:` en `file://`).
- [ ] Ouvrir les deux captures dans le Wireshark du lycée. Vérifier que la colonne Info et les noms de fabricants (`PCSSystemtec_…`, `Cisco_…`) correspondent aux tableaux du support.
- [ ] Vérifier que Wireshark est installé sur les postes Windows 11 et Kubuntu (ouverture d'un fichier, sans capture).
- [ ] Packet Tracer : version installée, présence des routeurs 4331 ou 2911, mode IPv6 *Automatic* des PC (TP 7), messages `Reply from…` et `Request timed out.` (TP 5).
- [ ] Machines virtuelles : nom de la carte Debian (`enp0s3`), présence de `sudo`, version de Debian (configuration par `/etc/network/interfaces`), nom de la carte Windows Server 2019 (`Ethernet`), règles de pare-feu `FPS-ICMP4-ERQ-In` et `FPS-ICMP6-ERQ-In`.
- [ ] Défi du TP 4 : adresse MAC de la passerelle NAT de VirtualBox (le support indique une adresse « de la forme 52:54:00:12:35:0x »).
- [ ] Sorties de commandes en français (`ping`, `tracert`, `ipconfig`) : elles peuvent varier légèrement selon la version de Windows.
- [ ] Durée totale : environ 14 h 45, contre environ 17 h annoncées dans le plan. Les défis et la mise en place des machines virtuelles comblent en partie l'écart. Ajuster les durées si besoin.
- [ ] Valider la liste des corrections apportées aux sources et le plan d'adressage proposé pour la M2L.

## 5. Autres remarques

- Prochain chapitre à produire au choix : le chapitre 1 (système et poste de travail), ou le chapitre 3 (transport et services : DHCP, DNS), qui s'appuie directement sur ce chapitre.
- Les scripts de construction (assemblage, vérifications, tests) sont conservés et permettent de régénérer `index.html` après une correction sans toucher au moteur.
