#! /bin/bash -xe
gem install bundler
bundle install
bundle exec jekyll build
[ -z $INPUT_DOMAIN ] && echo $INPUT_DOMAIN > _site/CNAME

git config user.email $INPUT_EMAIL
git config user.name "$INPUT_NAME"

git add _site
git commit -m "Deploy!"
git subtree split -P _site -b gh-pages
git push https://$GITHUB_ACTOR:$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages --force
