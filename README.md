# Build and deploy your Jekyll site to Github Pages.

This action is meant for Jekyll sites that have custom themes because GitHub
supports only a limited number of Jekyll Themes. This action builds your Jekyll
site then pushes it to your repo's gh-pages branch.

## Create a new token.

The token from secrets.GITHUB_TOKEN cannot trigger gh-pages build events. A new token must be created.
1. Go to https://github.com/settings/tokens and click the "**Generate new token**" button.
2. Check the repo checkbox to give access to you project's repo.
3. Go to your project's settings page and click the "**Add a new secret**" button.
4. Fill up the form with the token you generated from step 1. You can use any name for your secret(e.g. **DEPLOY_GH_PAGES_TOKEN**).
5. Click the "**Add secret**" button.
5. Use this secret as input to github_token. (see sample below)

## Inputs
| Name               | Description                                                                                                                                            | Required | Sample Value                |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|----------|-----------------------------|
| github_token       | A token to allow this action to perform git operations on your repo.                                                                                   | yes      | ${{ secrets.DEPLOY_GH_PAGES_TOKEN }} |
| git_commiter_name  | The Git commiter's name.                                                                                                                               | yes      | Emmanuel Corrales           |
| git_commiter_email | The Git commiter's email.                                                                                                                              | yes      | contact@emcorrales          |
| custom_domain      | The custom domain for your Github Pages. Use this if you want to use your own domain instead of the one provided by GitHub Pages(e.g. user.github.io). | no       | example.com                 |
### Example Workflow
```yaml
name: Deployment

on:
  push:
    branches:
    - master

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - uses: emcorrales/action-jekyll-deploy-gh-pages@v0.1
      with:
        github_token: ${{ secrets.DEPLOY_GH_PAGES_TOKEN }}
        git_commiter_name: Emmanuel Corrales
        git_commiter_email: contact@emcorrales.com
        custom_domain: contact@emcorrales.com
```
