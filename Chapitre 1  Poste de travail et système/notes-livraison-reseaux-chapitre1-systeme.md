# Notes de livraison : Systèmes et réseaux, chapitre 1 « Le poste de travail et le système »

BTS SIO 1re année, tronc commun SISR et SLAM, 2026-2027 · livraison du 24 octobre 2026

## 1. Fichiers livrés

| Fichier | Rôle |
|---|---|
| `index.html` | Support de cours et de TP interactif, en un seul fichier à ouvrir en local (environ 270 Ko). |

## 2. Support interactif (`index.html`)

### Réglages

- Clé de stockage : `reseaux-sio1-ch1:v1` ; préfixe des identifiants étudiants : `SYS` ; nom des fichiers : `sauvegarde-reseaux-ch1-…json`, `compte-rendu-reseaux-ch1-…html`.
- Public : **tronc commun SISR et SLAM**, en tout début de première année, sans prérequis.
- Compétences : B1.1 (patrimoine, licences, cycle de vie), B1.2 (diagnostic, langage de commande), bases de B2.1 SISR (installation d'un système serveur), B3.3 (comptes, privilèges, droits).
- Règle IA : **pas d'IA**. Elle est rappelée dans les règles du jeu, en tête de chaque partie et dans les consignes des TP.
- Règle affichée dès la page de démarrage : sur le poste de la salle, on observe seulement. Tout ce qui modifie un système se fait dans les machines virtuelles, jamais en accès par pont.

### Parcours (environ 15 h, défis non compris)

| Étape | Titre | Durée |
|---|---|---|
| Partie 1 | L'ordinateur et ses composants | 1 h 30 |
| Partie 2 | Représenter l'information : binaire, hexadécimal, unités | 1 h 30 |
| TP 1 | Inventorier et choisir un poste de travail | 2 h |
| Partie 3 | Le système d'exploitation | 1 h 30 |
| Partie 4 | La virtualisation | 1 h |
| TP 2 | Créer les serveurs virtuels SRV-DEB et SRV-WIN | 3 h |
| Partie 5 | Administrer en ligne de commande : Linux et Windows | 2 h |
| TP 3 | Administrer les fichiers, les comptes et les droits | 2 h 30 |

Le support contient :
- 25 questions de quiz, réparties en 5 quiz ;
- 19 réponses rédigées avec leur correction ;
- 8 activités auto-corrigées : 4 associations et 4 tableaux à cocher.

### Décisions de l'enseignant (rappel)

- Plan annuel : chapitre 1 « système et poste », avec les TP 1 à 3.
- Outils : VirtualBox, Debian, Windows Server 2019 ; postes de la salle sous Windows ou Kubuntu.
- Contexte M2L du Réseau Certa. Pas d'IA.

### Choix faits en l'absence de consigne (à valider)

- **Plan détaillé reconstruit.** Je n'ai pas retrouvé le détail du plan du chapitre 1 validé au début de l'année. Le découpage a été construit à partir de ce que les chapitres 2 à 6 supposent acquis :
  - le binaire ;
  - le poste et la carte réseau ;
  - les machines virtuelles SRV-DEB et SRV-WIN, avec le compte `etudiant` et `sudo` ;
  - les modes réseau de VirtualBox ;
  - les commandes de base ;
  - les droits NTFS.

  **À comparer avec le plan que vous aviez validé.**
- **Version de Debian.** Le TP 2 fait installer **Debian 13 « trixie »** (version stable depuis août 2025), ou Debian 12 si c'est l'image que vous fournissez. Depuis le 12 juillet 2026, Debian 12 ne reçoit plus que le support à long terme (LTS, jusqu'au 30 juin 2028). Les chapitres 2 à 6 ont été écrits pour Debian 12, mais les commandes employées sont identiques sous Debian 13. **À décider** : harmoniser la mention de version dans ces supports, si vous passez à Debian 13.
- **Installation de Debian** :
  - mot de passe root laissé vide, donc root verrouillé et `sudo` pour le compte `etudiant`, comme dans tous les chapitres ;
  - nom `srv-deb`, domaine `m2l.lan` ;
  - sans interface graphique, avec le serveur SSH.
- **SRV-WIN** :
  - Windows Server 2019 Standard Evaluation (expérience de bureau) ;
  - 4 Go de mémoire, 50 Go de disque ;
  - installation automatique de VirtualBox désactivée, pour que l'étudiant fasse l'installation lui-même ;
  - la période d'évaluation de 180 jours est signalée.
- **Poste client Windows 10.** Le TP 1 et la partie 3 exploitent la **fin de support de Windows 10** (14 octobre 2025). Rappel : le chapitre 5 prévoit un PC-CLIENT « Windows 10 ou 11 » ; il vaut mieux y préférer Windows 11.
- **TP 3** :
  - comptes de test `volley1` et `tennis1`, différents de ceux du TP 9 (chapitre 3) pour éviter les conflits ;
  - droits Linux 770, puis setgid (2770) pour le dossier commun ;
  - droits NTFS avec `icacls`, en utilisant les SID `*S-1-5-32-544` et `*S-1-5-18`, indépendants de la langue ;
  - tests avec `su -` et `runas`.
- **TP 1** : 4 offres de matériel inventées (dont une reconditionnée), à affecter à 4 besoins de la M2L ; mission sur la fin de vie (DEEE, effacement, Linux sur les postes non compatibles avec Windows 11).

### Corrections apportées aux sources et points d'actualité

- Dates de support vérifiées :
  - Windows 10 : 14 octobre 2025 ;
  - Windows Server 2019 : 9 janvier 2029 ;
  - Debian 12 : passage en LTS le 12 juillet 2026, jusqu'au 30 juin 2028 (annonce Debian).
- Empreinte environnementale : la source est l'étude ADEME-Arcep de 2022. Les terminaux représentent environ 79 % de l'empreinte carbone du numérique, et leur fabrication en est la cause principale (plus des trois quarts de leur empreinte).

### Ajouts par rapport aux sources

- Schémas : architecture de von Neumann, hyperviseurs de type 1 et 2.
- Tableaux de référence :
  - hiérarchie des mémoires (ordres de grandeur) ;
  - préfixes SI et binaires (1 To = 931 Gio) ;
  - modes réseau de VirtualBox, avec leur usage dans le cours ;
  - équivalents Linux / PowerShell.
- Encadrés : loi de Moore, cycle de vie du matériel et numérique responsable, pourquoi le binaire (et `0.1 + 0.2` en C#), machines virtuelles et conteneurs, cahier de bord du technicien.
- Défis :
  - inventaire exporté en CSV avec PowerShell ;
  - SSH vers SRV-DEB par une redirection de ports VirtualBox (`127.0.0.1:2222`) ;
  - commandes de recherche (`grep`, `find`, `ps`, tubes).
- Fiches mémo : notions et commandes Linux et Windows.

### Tests réalisés

- Chromium (Playwright), à 1 280 px et 375 px de large :
  - aucune erreur JavaScript (seules les polices Google ne se chargent pas hors ligne) ;
  - aucun défilement horizontal de la page.
- Les 8 activités auto-corrigées et les 5 quiz (25 questions) ont été remplis avec les réponses attendues : le moteur les note tous justes.
- Réponse rédigée, sauvegarde, compte rendu et restauration dans un navigateur vierge : conformes.
- Captures d'écran sur téléphone. Corrections :
  - un libellé du schéma de von Neumann dépassait de son cadre ;
  - l'explication de l'invite de commande a été mise en tableau ;
  - « SRV-DEB » était coupé au trait d'union.
- **Exécuté réellement** dans un conteneur Linux (Ubuntu, `adduser` 3.137) :
  - le scénario Linux complet du TP 3 : groupes, comptes, droits 770, tests avec `su -`, échec puis réussite du test 4 avec le setgid, `umask 0002`, puis nettoyage ;
  - les conversions et calculs de la partie 2 (vérifiés en Python).
- **Non exécutés ici** : installations de Debian et de Windows Server, commandes PowerShell, `icacls`, VirtualBox.

## 3. Diaporama de lancement

Pas encore produit (à la demande).

## 4. Points à vérifier avant distribution

- [ ] Comparer le découpage du chapitre avec le plan validé au départ.
- [ ] Décider de la version de Debian (13 recommandée) et harmoniser les chapitres 2 à 6 si besoin.
- [ ] Préparer les images ISO (Debian netinst, Windows Server 2019 Evaluation en français) dans le dossier de la salle.
- [ ] Vérifier que la virtualisation matérielle est activée dans l'UEFI des postes, et que Hyper-V, WSL 2 ou l'intégrité de la mémoire ne ralentissent pas VirtualBox.
- [ ] Vérifier l'espace disque disponible pour les machines virtuelles (environ 25 Go par étudiant).
- [ ] VirtualBox 7 : libellé exact de l'option qui désactive l'installation sans surveillance, partitions créées pour Windows (BIOS ou EFI selon le réglage par défaut).
- [ ] Debian 13 : partitions créées par l'installation assistée, droits des dossiers personnels, `adduser` qui ajoute le groupe `users`.
- [ ] Windows : `New-Item -ItemType Directory` avec plusieurs chemins, `icacls … /inheritance:r /grant` avec des SID, `runas /user:volley1 powershell` sur SRV-WIN.
- [ ] Commandes d'inventaire du TP 1 sur les postes de la salle, sans droits d'administration.
- [ ] Valider les choix faits en l'absence de consigne.

## 5. Autres remarques

- Avec ce chapitre, les supports des chapitres 1 à 6 sont tous produits. Reste à faire, à la demande : les diaporamas de lancement, et l'harmonisation de la version de Debian entre les chapitres.
- Le TP 2 produit les deux machines virtuelles utilisées toute l'année. Il est conseillé d'exporter une machine de secours (*Fichier > Exporter un appareil virtuel*) pour les étudiants dont l'installation échouerait.
