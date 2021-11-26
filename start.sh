#!/usr/bin/env bash
#=============================================================================
# filename.toml --- bash script
# Copyright (c) 2050 @EasyQuest
# Author: Ivan Yastrebov < easy-quest@mail.ru >
# URL: https://easy-quest.github.io/web/
#=============================================================================


function function_venv() {
  #function_body
  py3=$(command -v python3.9)
  $py3 -m venv .venv
}

cat > .github/workflows/ci.yml << ZZZ
name: ci # 
on:
  push:
    branches: # 
      - master
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: 3.x
      - run: pip install mkdocs-material # 
      - run: mkdocs gh-deploy --force
zzz


mkdocs gh-deploy --force

# gitlab

cat > .gitlab-ci.yml << ZZZ

image: python:latest
pages:
  stage: deploy
  only:
    - master
  script:
    - pip install mkdocs-material
    - mkdocs build --site-dir public
  artifacts:
    paths:
      - public
ZZZ

esim.i2p.gitlab.io/web
