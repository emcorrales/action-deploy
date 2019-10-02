#! /bin/bash -xe
MY_JEKYLL_SITE=my_jekyll_site

gem install bundler
bundle install
git clone --bare --branch=gh-pages https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages
JEKYLL_ENV=production bundle exec jekyll build -d $MY_JEKYLL_SITE
[ ! -z $INPUT_CUSTOM_DOMAIN ] && echo $INPUT_CUSTOM_DOMAIN > $MY_JEKYLL_SITE/CNAME

git config user.name "$INPUT_GIT_COMMITTER_NAME"
git config user.email $INPUT_GIT_COMMITTER_EMAIL

git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE checkout
git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE add $MY_JEKYLL_SITE
git commit -m "Deploy!"
git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE push https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages


