#! /bin/bash -xe
MY_JEKYLL_SITE=my_jekyll_site

gem install bundler
bundle install
bundle exec jekyll build -d $MY_JEKYLL_SITE
[ ! -z $INPUT_CUSTOM_DOMAIN ] && echo $INPUT_CUSTOM_DOMAIN > $MY_JEKYLL_SITE/CNAME

git config user.name "$INPUT_GIT_COMMITER_NAME"
git config user.email $INPUT_GIT_COMMITTER_EMAIL

git add $MY_JEKYLL_SITE
git commit -m "Deploy!"
git subtree split -P $MY_JEKYLL_SITE -b gh-pages
git push https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages --force
