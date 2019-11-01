#! /bin/bash
set -xe
MY_JEKYLL_SITE=$HOME/my_jekyll_site
ghprepo() {
  git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE $@
}

mkdir -p $MY_JEKYLL_SITE

gem install bundler
bundle install

git clone --bare https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages
set +e
ghprepo branch -a | grep remotes/origin/gh-pages | wc -l
if [ $(ghprepo branch -a | grep remotes/origin/gh-pages | wc -l) -eq 1 ]; then
  set -e
  ghprepo checkout gh-pages
else
  set -e
  ghprepo checkout -b gh-pages
fi

rm -rf $MY_JEKYLL_SITE/*
JEKYLL_ENV=production bundle exec jekyll build -d $MY_JEKYLL_SITE
[ ! -z $INPUT_CUSTOM_DOMAIN ] && echo $INPUT_CUSTOM_DOMAIN > $MY_JEKYLL_SITE/CNAME

git config --global user.name "$INPUT_GIT_COMMITTER_NAME"
git config --global user.email $INPUT_GIT_COMMITTER_EMAIL

ghprepo add $MY_JEKYLL_SITE
ghprepo commit -m "Deploy!"
ghprepo push https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages
