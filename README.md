# Rapport de Projet TP Intégration - SubTracker

## Description du projet

SubTracker est une application web de gestion d'abonnements (Node.js/MongoDB). L'objectif de ce projet était de conteneuriser l'application avec Docker, de l'orchestrer localement avec Docker Compose, puis de la déployer sur un cluster Kubernetes hébergé sur une machine virtuelle Azure.

## Explication du pipeline CI/CD

Le pipeline est géré via GitHub Actions. À chaque `git push` sur la branche `main` :

1. **Tests & Build** : Installation des dépendances Node.js et exécution des tests.
2. **Docker Build & Push** : Création de l'image Docker (via un multi-stage build pour l'optimisation) et envoi sécurisé sur Docker Hub.
3. **Déploiement Continu (CD)** : Connexion SSH automatisée à la VM Azure pour déclencher un `kubectl rollout restart`, mettant à jour les pods sans interruption de service.

## Étapes de déploiement

1. Création d'une VM Ubuntu sur Azure et ouverture du port 30000.
2. Installation de Docker et du cluster Kubernetes léger (K3s).
3. Sécurisation des variables d'environnement via des **Secrets**Kubernetes (`kubectl create secret generic`).
4. Application des manifestes (Deployment et Service NodePort) pour exposer l'application sur internet.

## Difficultés rencontrées et solutions

- **Manque de RAM pour K3s** : Kubernetes plantait à cause d'un manque de RAM sur la VM Azure La solution a été d'augmenter la taille de la VM Azure pour passer à au moins 2 Go de RAM.
- **Erreur de processeur (exec format error)** : Lors du build de l'image Docker, l'architecture du processeur posait problème car elle était incompatible avec le serveur Azure. J'ai résolu le problème en utilisant la compilation croisée (`docker build --platform linux/amd64`).

# Projet déployer sur : http://20.19.48.107:30000
