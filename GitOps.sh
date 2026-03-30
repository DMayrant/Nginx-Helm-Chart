#!/bin/bash 
set -euo pipefail

REPO_NAME="Nginx-helm-chart"
GIT_HUB_USER="DMayrant"

echo "packaging helm chart 📦..."
helm package .

echo "Creating helm repo index 📑..."
helm repo index .

# adding helm chart to repo
echo "adding helm chart to repo..." 
git init
git add .
git commit -m "add helm chart"
git branch -M main
git remote add origin https://github.com/$GIT_HUB_USER/$REPO_NAME.git
git push -u origin main
echo "repo updated successful✅"

echo "installing helm repo.."
helm repo add my-charts https://$GIT_HUB_USER.github.io/$REPO_NAME
helm repo update 
helm install my-app my-charts/nginx
echo "Done 🫡"
