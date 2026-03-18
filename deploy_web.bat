@echo off
cd /d build\web
if exist .git rmdir /s /q .git
git init
git add .
git commit -m "Update"
git branch -M gh-pages
git remote add origin https://github.com/guilhermeeng99/guilhermeeng99.github.io.git
git push -f origin gh-pages
