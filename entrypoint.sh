#! /bin/bash -xe
MY_JEKYLL_SITE=$HOME/my_jekyll_site
mkdir -p $MY_JEKYLL_SITE

gem install bundler
bundle install

git clone --bare https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages

git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE branch -a | grep remotes/origin/gh-pagess
if [ $? -eq 0 ]; then
  git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE checkout gh-pages
else
  git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE checkout -b gh-pages
fi

rm -rf $MY_JEKYLL_SITE/*
JEKYLL_ENV=production bundle exec jekyll build -d $MY_JEKYLL_SITE
[ ! -z $INPUT_CUSTOM_DOMAIN ] && echo $INPUT_CUSTOM_DOMAIN > $MY_JEKYLL_SITE/CNAME

git config --global user.name "$INPUT_GIT_COMMITTER_NAME"
git config --global user.email $INPUT_GIT_COMMITTER_EMAIL

git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE add $MY_JEKYLL_SITE
git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE commit -m "Deploy!"
git --git-dir=gh-pages --work-tree=$MY_JEKYLL_SITE push https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git gh-pages
