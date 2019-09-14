#! /bin/bash -xe
gem install bundler
bundle install
bundle exec jekyll build
[ ! -z $INPUT_CUSTOM_DOMAIN ] && echo $INPUT_CUSTOM_DOMAIN > _site/CNAME

git config user.name "$INPUT_GIT_COMMITER_NAME"
git config user.email $INPUT_GIT_COMMITTER_EMAIL

git add _site
git commit -m "Deploy!"
git subtree split -P _site -b gh-pages
git push https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages --force
