#!/bin/bash 
set -euo pipefail

REPO="https://github.com/DMayrant/Nginx-Helm-Chart.git"

# adding helm chart to repo
echo "adding helm chart to repo..." 
git init
git add .
git commit -m "add helm chart"
git branch -M main
git remote add origin "$REPO"
git push -u origin main
echo "repo updated successful✅"

echo "Creating helm repo via gitHub pages..."
helm repo index . 
echo "completed creating helm repo ✅"

echo "installing helm repo.."
helm repo add my-charts "$REPO"
helm repo update 
helm install my-app my-charts/nginx
