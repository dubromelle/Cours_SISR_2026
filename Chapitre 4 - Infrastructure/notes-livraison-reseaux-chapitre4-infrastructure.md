# Notes de livraison : Systèmes et réseaux, chapitre 4 « Concevoir et construire l'infrastructure »

BTS SIO 1re année, option SISR, 2026-2027 · livraison du 24 octobre 2026

## 1. Fichiers livrés

| Fichier | Rôle |
|---|---|
| `index.html` | Support de cours et de TP interactif, en un seul fichier à ouvrir en local (environ 275 Ko, capture intégrée). |
| `capture-ch4-trunk-8021q.pcap` | Copie de la capture de la partie 2, déjà intégrée au support : un lien trunk 802.1Q et un ping du VLAN 10 vers le VLAN 20 par un routeur sur un bâton. |

## 2. Support interactif (`index.html`)

### Réglages

- Clé de stockage : `reseaux-sio1-ch4:v1` ; préfixe des identifiants étudiants : `INF` ; nom des fichiers : `sauvegarde-reseaux-ch4-…json`, `compte-rendu-reseaux-ch4-…html`.
- Public : **option SISR** (bloc 2, semestre 2). Les étudiants SLAM ne suivent pas ce chapitre.
- Règle IA : **pas d'IA**. Elle est rappelée dans les règles du jeu, en tête de chaque partie et dans les consignes des TP.
- Outils : Cisco Packet Tracer (routeurs 4331, commutateurs 2960), matériel Cisco de la baie (console, PuTTY ou `screen`), VirtualBox avec pfSense, SRV-WIN et SRV-DEB, Wireshark.
- Règle de sécurité affichée : jamais d'équipement de la baie relié au réseau du lycée. Les machines virtuelles restent en réseau interne, sauf le WAN de pfSense en NAT VirtualBox.

### Parcours (environ 15 h 30, défis non compris)

| Étape | Titre | Durée |
|---|---|---|
| Partie 1 | Concevoir une architecture réseau | 1 h |
| Partie 2 | Les VLAN et le routage inter-VLAN | 1 h 30 |
| TP 10 | Segmenter la M2L en VLAN | 3 h |
| Partie 3 | Le routage | 1 h 30 |
| TP 11 | Relier le site annexe et Internet | 2 h 30 |
| Partie 4 | La traduction d'adresses (NAT) | 45 min |
| Partie 5 | Périmètres de sécurité, DMZ et filtrage | 1 h 15 |
| TP 12 | Une DMZ protégée par pfSense | 3 h |
| Partie 6 | L'accès distant sécurisé : SSH, RDP, VPN | 1 h |

Le support contient 27 questions de quiz, 22 réponses rédigées avec correction et 8 activités auto-corrigées. Les TP gardent la numérotation 10 à 12 du plan annuel. Deux parties se terminent par une mise en pratique dans Packet Tracer : la NAT (partie 4) et SSH (partie 6).

### Décisions de l'enseignant (rappel)

- Plan du chapitre 4 validé au départ. Chapitre réservé aux SISR.
- Outils : Packet Tracer, matériel Cisco, VirtualBox, Debian, Windows Server 2019, **pfSense**.
- Contexte M2L du Réseau Certa. Pas d'IA.

### Choix faits en l'absence de consigne (à valider)

- **Plan de VLAN de la M2L**, construit sur le plan d'adressage du chapitre 2 :

  | VLAN | Usage | Réseau |
  |---|---|---|
  | 10 | Administration | `172.16.2.128/26` |
  | 20 | Salle multimédia | `172.16.2.192/27` |
  | 30 | Serveurs | `172.16.2.224/28` |
  | 40 | Téléphonie | `172.16.2.0/25` |
  | 50 | Wi-Fi visiteurs | `172.16.0.0/23` |
  | 99 | Gestion des équipements | `172.16.3.0/28` (pris dans la réserve) |
  | 101 à 124 | Ligue *nn* = VLAN 100 + *nn* | réseaux des ligues |
  | 999 | VLAN natif inutilisé | — |

- **Site annexe ajouté au contexte M2L** pour pratiquer le routage entre sites, présenté comme tel aux étudiants :
  - réseau de l'annexe `172.16.12.0/24` et liaison inter-sites `172.16.15.248/30`, pris dans la réserve du plan ;
  - opérateur et Internet simulés avec les adresses de documentation `203.0.113.0/30` et `198.51.100.0/24`.
- **Enchaînement des maquettes Packet Tracer** : TP 10, puis TP 11, puis mises en pratique NAT et SSH. Le routeur R1 du TP 10 devient le routeur du site principal.
- **TP 12 (pfSense)** :
  - pfSense a trois cartes VirtualBox : WAN en NAT, LAN sur `tp5` (`192.168.50.62/26`, la passerelle prévue depuis le TP 5), DMZ sur `dmz` (`172.16.2.246/29`) ;
  - SRV-DEB est déplacé dans la DMZ (`172.16.2.241`) et l'enregistrement DNS `srv-deb` est mis à jour ;
  - la publication du site est testée depuis le poste physique par une redirection de ports VirtualBox (`127.0.0.1:8080`) suivie d'une redirection de ports pfSense ;
  - l'option « Block private networks » est décochée sur le WAN, ce qui est expliqué aux étudiants.
- **Machine virtuelle pfSense et navigateur.** Le support suppose une machine virtuelle pfSense **fournie par l'enseignant ou installée selon la procédure de la salle** : l'installateur de pfSense CE évolue et demande parfois un accès en ligne. Il recommande aussi Firefox sur SRV-WIN, car l'interface web de pfSense demande un navigateur récent.
- **Durée.** La durée totale est d'environ 15 h 30, pour environ 16 h au plan. Les TP sont plus longs que prévu (TP 10 : 3 h, TP 11 : 2 h 30, TP 12 : 3 h) parce qu'ils comprennent le matériel réel, le dépannage et les rapports de test.

### Corrections apportées aux sources

- Pas de nouvelle source pour ce chapitre. Le contenu s'appuie sur le guide d'accompagnement (B2.1, B2.2, B2.3 SISR ; B3.4 pour les zones et l'administration à distance) et sur le contexte M2L.

### Ajouts par rapport aux sources

- **Capture pcap fabriquée** (9 trames étiquetées 802.1Q, sommes de contrôle correctes). Le même paquet y apparaît dans le VLAN 10 puis dans le VLAN 20, avec un TTL qui passe de 128 à 127 et de nouvelles adresses MAC. Le premier ping est perdu pendant la résolution ARP du routeur, et la taille de 64 octets s'explique par l'étiquette.
- Configurations Cisco complètes, avec leur correction :
  - configuration de base, VLAN, trunks avec VLAN natif 999 et liste des VLAN autorisés, ports inutilisés désactivés ;
  - interface de gestion, sous-interfaces du routeur, routes statiques et par défaut, route résumée `172.16.12.0/23` ;
  - OSPF (défi), PAT, ACL étendues (visiteurs, ligue 06, gestion) et SSH.
- Tickets de dépannage à reproduire dans la maquette :
  - port dans le mauvais VLAN, VLAN non autorisé sur le trunk, VLAN natif différent aux deux bouts ;
  - prochain saut erroné, route retour manquante.
- Matrice des flux de la M2L (9 flux) et règles pfSense ordonnées, avec un alias `PORTS_WEB`, la lecture du journal du pare-feu, le rapport de test et le défi du moindre privilège sur le LAN.
- Exemples et encadrés : schéma d'architecture cible de la M2L, panne BGP de Facebook en 2021, NAT chez l'opérateur (CGNAT), bastion d'administration, modèle zéro confiance.
- Fiches mémo : notions et commandes Cisco.

### Tests réalisés

- Chromium (Playwright), à 1 280 px et 375 px de large : aucune erreur JavaScript (seules les polices Google ne se chargent pas hors ligne) et aucun défilement horizontal de la page.
- Les 8 activités auto-corrigées et les 6 quiz (27 questions) ont été remplis avec les réponses attendues : tous notés justes par le moteur.
- Réponse rédigée, téléchargement de la capture (fichier identique à l'original), sauvegarde, compte rendu et restauration dans un navigateur vierge : conformes.
- Thème sombre vérifié par captures d'écran ; un texte qui dépassait du schéma d'architecture a été corrigé.
- Les adresses, passerelles, masques génériques, routes résumées et choix de route par le préfixe le plus long ont été recalculés avec le module `ipaddress` de Python.
- La capture a été relue avec un décodeur maison, mais **pas dans Wireshark**.
- **Aucune configuration Cisco ni pfSense n'a été exécutée** pendant la préparation (pas de Packet Tracer ni de pfSense disponibles ici).

## 3. Diaporama de lancement

Pas encore produit (à la demande).

## 4. Points à vérifier avant distribution

- [ ] Ouvrir `index.html` dans Firefox sous Windows et sous Kubuntu : sauvegarde, reprise, téléchargement de la capture.
- [ ] Ouvrir la capture dans Wireshark : colonne VLAN, noms de fabricant (`RealtekSemic_…`, `Cisco_…`).
- [ ] **Refaire les TP 10 et 11 dans la version de Packet Tracer du lycée** :
  - [ ] syntaxe `interface range FastEthernet0/11 - 24 , GigabitEthernet0/2` ;
  - [ ] sous-interfaces du routeur 4331 et `ip helper-address` sur les sous-interfaces (défi) ;
  - [ ] sortie de `show ip route` ;
  - [ ] PAT et `show ip nat translations` ;
  - [ ] OSPF avec `default-information originate` ;
  - [ ] invite de `crypto key generate rsa` et client SSH des PC.
- [ ] Matériel réel : modèles et versions d'IOS, noms d'interfaces (Gi0/1 ou Gi1/0/1), remise à zéro (`vlan.dat`).
- [ ] **pfSense** (TP 12) :
  - [ ] menus de la console et de l'interface web selon la version installée ;
  - [ ] intitulés des options (« Block private networks… », « Filter rule association ») ;
  - [ ] fonctionnement de la redirection VirtualBox `127.0.0.1:8080` vers le WAN de pfSense, puis vers la DMZ ;
  - [ ] accès des machines virtuelles à Internet à travers le réseau du lycée (tests DNS et `apt update`).
- [ ] Préparer et distribuer la machine virtuelle pfSense (ou la procédure d'installation), et Firefox pour SRV-WIN.
- [ ] Valider les choix faits en l'absence de consigne (section 2).

## 5. Autres remarques

- La matrice des flux, les règles pfSense et le VLAN de gestion préparent directement le chapitre 6 (cybersécurité : chaîne de liaison, 802.1X, WPA3, surveillance DHCP) et la deuxième année (haute disponibilité, STP, OSPF, VPN).
- Le chapitre 5 (administration : Active Directory, scripts, journaux, sauvegardes, GLPI) peut réutiliser SRV-WIN, le VLAN des serveurs et le réseau de test.
