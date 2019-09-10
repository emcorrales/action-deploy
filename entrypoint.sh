#! /bin/bash -xe
gem install bundler
bundle install
bundle exec jekyll build

git config user.email $INPUT_EMAIL
git config user.name "$INPUT_NAME"

git add _site
git commit -m "Deploy!"
git subtree split -P _site -b gh-pages
git push https://$INPUT_ACTOR:$INPUT_TOKEN@$INPUT_URL gh-pages --force
