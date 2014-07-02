echo nome commit:
read LINE;
git add *
git add .
git commit -am "$LINE"
git push -u origin master
