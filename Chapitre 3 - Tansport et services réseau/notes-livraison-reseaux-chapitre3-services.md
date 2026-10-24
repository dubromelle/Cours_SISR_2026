# Notes de livraison : Systèmes et réseaux, chapitre 3 « Transport et services réseau »

BTS SIO 1re année, 2026-2027 · livraison du 24 octobre 2026

## 1. Fichiers livrés

| Fichier | Rôle |
|---|---|
| `index.html` | Support de cours et de TP interactif, en un seul fichier à ouvrir en local (environ 270 Ko, captures Wireshark intégrées). |
| `capture-ch3-tcp-http.pcap` | Copie de la capture de la partie 1, déjà intégrée au support : connexion TCP, requête web, connexion refusée. |
| `capture-ch3-dhcp.pcap` | Copie de la capture de la partie 2 : échange DORA, sondes ARP, renouvellement. |
| `capture-ch3-dns.pcap` | Copie de la capture de la partie 3 : requêtes A et AAAA avec alias, NXDOMAIN, résolution inverse. |

## 2. Support interactif (`index.html`)

### Réglages

- Clé de stockage : `reseaux-sio1-ch3:v1` ; préfixe des identifiants étudiants : `SVC` ; nom des fichiers : `sauvegarde-reseaux-ch3-…json`, `compte-rendu-reseaux-ch3-…html`.
- Règle IA : **pas d'IA** pendant tout le chapitre. Elle est rappelée dans les règles du jeu, en tête de chaque partie et dans les consignes des TP. Les commandes sont à taper, pas à copier-coller.
- Outils : VirtualBox (SRV-DEB sous Debian et SRV-WIN sous Windows Server 2019, réseau interne `tp5` du chapitre 2), Cisco Packet Tracer, Wireshark, invite de commandes et PowerShell, terminal Linux.
- Règle de sécurité affichée sur la page de démarrage et dans les TP : jamais de serveur DHCP en dehors du réseau interne de VirtualBox ou de Packet Tracer.
- Fil rouge : contexte M2L (Réseau Certa) et plan d'adressage du chapitre 2. Le réseau de test `192.168.50.0/26` du TP 5 est réutilisé.

### Parcours (environ 11 h 15, défis non compris)

| Étape | Titre | Durée |
|---|---|---|
| Partie 1 | La couche transport : TCP et UDP | 1 h 30 |
| Partie 2 | DHCP : l'adressage automatique | 1 h |
| Partie 3 | DNS : des noms aux adresses | 1 h 30 |
| TP 8 | Installer et tester DHCP et DNS | 3 h |
| Partie 4 | Les services applicatifs et leur déploiement | 1 h 15 |
| TP 9 | Déployer un serveur web et un partage de fichiers | 3 h |

Le support contient 22 questions de quiz, 18 réponses rédigées avec correction et 10 activités auto-corrigées (tableaux à cocher, associations, lignes à repérer). La numérotation des TP suit le plan annuel (TP 8 et 9).

### Décisions de l'enseignant (rappel)

- Un support par chapitre, avec le plan du chapitre 3 validé au départ : TCP/UDP, DHCP, DNS, TP 8, services applicatifs, TP 9.
- Outils : VirtualBox, Packet Tracer, Debian, Windows Server 2019. pfSense et GLPI ne servent pas encore dans ce chapitre.
- Contexte Réseau Certa M2L. Pas d'IA.

### Choix faits en l'absence de consigne (à valider)

- **Répartition des rôles serveurs.**
  - Choix : DNS et DHCP sur **Windows Server 2019** ; site web (Apache) sur **Debian** ; partage de fichiers SMB sur **Windows Server**.
  - Raison : le contexte M2L indique que le serveur d'annuaire et de fichiers de l'administration « assure aussi le DHCP », et la DMZ héberge le serveur web.
  - Toutes les configurations sont données en interface graphique et en PowerShell.
- **Domaine interne `m2l.lan`.** Un encadré explique les bonnes pratiques actuelles : `.internal`, réservé par l'ICANN en 2024, ou un sous-domaine d'un domaine possédé. Ce nom peut être changé facilement si vous utilisez un autre domaine avec vos étudiants.
- **Machine cliente.** Il n'y a pas de poste client virtuel : **SRV-DEB sert de client** DHCP et DNS au TP 8, puis revient en adresse fixe avant le TP 9. Si vous disposez d'une machine virtuelle Windows 11 cliente, elle peut remplacer SRV-DEB dans ces tests.
- **Installation des paquets.** Les paquets Debian nécessaires (`bind9-dnsutils`, `curl`, `apache2`, `smbclient`) sont installés une seule fois au début du TP 8, avec la carte en mode NAT, puis la carte repasse en réseau interne.
- **Durée.** La durée totale est d'environ 11 h 15, contre environ 12 h annoncées dans le plan. Le TP 8 et le TP 9 sont estimés à 3 h chacun (2 h 30 et 2 h dans le plan), parce qu'ils comprennent l'installation des rôles et la rédaction du rapport de test.

### Corrections apportées aux sources

- Aucune nouvelle source n'a été fournie pour ce chapitre : le contenu s'appuie sur le guide d'accompagnement (B1.2, B1.5, B2.2) et sur le contexte M2L déjà utilisés au chapitre 2.

### Ajouts par rapport aux sources

- **Trois captures pcap fabriquées pour le cours**, intégrées au support. Les sommes de contrôle IP, TCP et UDP sont correctes. Les adresses MAC et IP sont celles du réseau de test.
  - TCP/HTTP (12 trames) : poignée de main, `GET /` de 74 octets, réponse `200 OK` de 323 octets, fermeture FIN, puis une connexion vers le port 443 refusée par un RST.
  - DHCP (8 trames) : DORA (bail de 8 jours, T1 à 4 jours, T2 à 7 jours), sondes ARP, renouvellement en envoi individuel.
  - DNS (8 trames) : A via un CNAME, AAAA sans adresse IPv6, NXDOMAIN, PTR.
- Résultats attendus chiffrés et vérifiés :
  - acquittements 75, 324 et 325 ;
  - durées de bail et pourcentages T1 et T2 ;
  - zone inverse `in-addr.arpa` ;
  - jeux d'essai complets, avec cas positifs et cas négatifs (404, `NT_STATUS_ACCESS_DENIED`, `NT_STATUS_LOGON_FAILURE`, NXDOMAIN, délai DNS, absence d'offre DHCP).
- Maquette Packet Tracer de la M2L à trois réseaux (serveurs, multimédia, administration), avec un serveur DHCP central, un relais `ip helper-address` sur le routeur 4331, un serveur DNS et un serveur HTTP.
- Encadrés « En profondeur » et « En entreprise » : connexion refusée ou filtrée, nom du domaine interne, DHCPv6, ports ouverts et surface d'attaque, faux serveur DHCP.
- Démarche de déploiement d'un service (B1.5) : tests d'intégration et tests d'acceptation, rapport de test, documentation technique et documentation utilisateur, avec une documentation utilisateur à rédiger au TP 9.
- Défis facultatifs : enregistrements AAAA et préférence pour IPv6 (TP 8) ; hôtes virtuels Apache (TP 9).
- Fiches mémo dans le bilan : notions, ports, commandes Windows / Linux / Cisco.
- CSS : règles ajoutées pour éviter le débordement horizontal des listes d'étapes sur téléphone (le moteur n'a pas été modifié).

### Tests réalisés

- Chromium (Playwright), à 1 280 px et 375 px de large : aucune erreur JavaScript (seules les polices Google ne se chargent pas hors ligne) et, après correction, aucun défilement horizontal.
- Les 10 activités auto-corrigées et les 4 quiz (22 questions) ont été remplis avec les réponses attendues : tous notés justes par le moteur.
- Réponse rédigée : correction débloquée après la rédaction, puis auto-évaluation.
- Fichiers : téléchargement des trois captures (identiques aux originaux), sauvegarde, compte rendu, restauration dans un navigateur vierge.
- Thème sombre vérifié par captures d'écran ; correction d'une étiquette coupée dans le schéma TCP.
- Les captures ont été relues avec un décodeur écrit pour l'occasion (en-têtes, sommes de contrôle, contenu DHCP et DNS), mais **pas dans Wireshark**.

## 3. Diaporama de lancement

Pas encore produit (à la demande, comme pour le chapitre 2).

## 4. Points à vérifier avant distribution

- [ ] Ouvrir `index.html` dans Firefox sous Windows et sous Kubuntu : sauvegarde, reprise, téléchargement des trois captures.
- [ ] Ouvrir les trois captures dans le Wireshark du lycée et comparer la colonne Info aux tableaux du support (numéros relatifs `Seq` et `Ack`, `ARP Probe`, `No such name`).
- [ ] Packet Tracer (TP 8) :
  - [ ] le serveur DHCP choisit bien le bon pool pour les deux réseaux relayés (`ip helper-address`) ;
  - [ ] l'enregistrement CNAME est accepté par le service DNS du serveur ;
  - [ ] le routeur 4331 dispose de l'interface G0/0/2.
- [ ] Windows Server 2019 :
  - [ ] cmdlets DNS et DHCP ;
  - [ ] `netsh dhcp add securitygroups` hors domaine ;
  - [ ] règle de pare-feu `FPS-SMB-In-TCP` ;
  - [ ] présence de `curl.exe` ;
  - [ ] complexité exigée pour les mots de passe des comptes locaux.
- [ ] Debian :
  - [ ] passage de `inet static` à `inet dhcp` et retour (ordre `ifdown`, modification, `ifup`) ;
  - [ ] message du client DHCP en l'absence de serveur (il dépend de la version de Debian : `dhclient` ou `dhcpcd`) ;
  - [ ] `/etc/resolv.conf` récrit par le client DHCP.
- [ ] `smbclient` avec un compte local Windows (`-U 'SRV-WIN\utilisateur'`) : messages `NT_STATUS_ACCESS_DENIED` et `NT_STATUS_LOGON_FAILURE`.
- [ ] Valider les choix faits en l'absence de consigne (section 2).

## 5. Autres remarques

- Le chapitre 4 (bloc 2 SISR : VLAN, routage, NAT, DMZ, pfSense) peut réutiliser directement la maquette Packet Tracer du TP 8 et les deux services du TP 9.
