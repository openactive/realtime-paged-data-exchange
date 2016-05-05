#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# squash messages
git config --global push.default matching

# prepare respec build

# clear the respec directory
rm -rf respec || exit 0;

# get existing gh-pages
git clone -b develop "https://github.com/openactive/respec.git"

cd respec

npm install

cd ..


# clear and re-create the out directory
rm -rf out || exit 0;
mkdir out;

# go to the out directory and create a *new* Git repo
cd out
git init

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "travis@openactive.org"

# compile using spec-generator (handling each version separately)

echo Copying static files
cp -r ../0.1.0 .
cp -r ../0.2.2 .
cp -r ../0.2.3 .
cp -r ../WorkingDraft/* .

cd ..

echo Running respec2html

node respec/tools/respec2html.js

rm "$PWD/out/0.2.3/index.html"
node respec/tools/respec2html.js --haltonerror --haltonwarn --src "file://$PWD/0.2.3/index.html" --out "$PWD/out/0.2.3/index.html"
{
if [ ! -f "$PWD/out/0.2.3/index.html" ]; then
    echo "/out/0.2.3/index.html was not generated!"
    exit 2
fi
}

rm "$PWD/out/index.html"
node respec/tools/respec2html.js --haltonerror --haltonwarn --src "file://$PWD/WorkingDraft/index.html" --out "$PWD/out/index.html"
{
if [ ! -f "$PWD/out/index.html2" ]; then
    echo "/out/index.html was not generated!"
    exit 2
fi
}

cd out

# curl "https://labs.w3.org/spec-generator/?type=respec&url=http://openactive.github.io/spec-template/index.html" > index.static.html;

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
git add .
git commit -m "Deploy to GitHub Pages - Static"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1

cd ..
