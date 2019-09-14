# Build and deploy your Jekyll site to Github Pages.

This action is meant for Jekyll sites that have custom themes because GitHub supports only a limited number of Jekyll Themes.

This action builds your Jekyll site then force pushes it to your repo's gh-pages branch.

## Warning!
This action will override the commits on your gh-pages branch. Please be sure that you are willing to lose the current commits from your gh-pages branch.

## Inputs
| Name               | Description                                                                                                                                            | Required | Sample Value                |
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|----------|-----------------------------|
| GITHUB_TOKEN       | A token to allow this action to perform git operations on your repo.                                                                                   | yes      | ${{ secrets.GITHUB_TOKEN }} |
| GIT_COMMITER_NAME  | The Git commiter's name.                                                                                                                               | yes      | Emmanuel Corrales           |
| GIT_COMMITER_EMAIL | The Git commiter's email.                                                                                                                              | yes      | contact@emcorrales          |
| CUSTOM_DOMAIN      | The custom domain for your Github Pages. Use this if you want to use your own domain instead of the one provided by GitHub Pages(e.g. user.github.io). | no       | example.com                 |
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
        token: ${{ secrets.GITHUB_TOKEN }}
        name: Emmanuel Corrales
        email: contact@emcorrales.com
        domain: contact@emcorrales.com
```
