#!/bin/bash 
set -euo pipefail

REPO_NAME="Nginx-Helm-Chart"
GIT_HUB_USER="DMayrant"
BRANCH="feature/gitops-implementation"

echo "packaging helm chart 📦..."
helm package .

echo "Creating helm repo index 📑..."
helm repo index .
cat index.yaml

# workflow for gitHub implementation
echo "----------------------"
echo "GitHub actions..."
git checkout main
git pull --rebase origin main
git checkout -b "$BRANCH" || git checkout "$BRANCH"
git add . 
git commit -m "<message>"
git push origin "$BRANCH"

echo "----------------------"
echo "installing helm repo..."
helm repo add my-charts https://$GIT_HUB_USER.github.io/$REPO_NAME
helm repo update 
helm install my-app my-charts/nginx
echo "Done 🫡"
