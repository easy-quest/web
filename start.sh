#!/usr/bin/env bash
#!/data/data/com.termux/files/usr/bin/env bash
source baner.sh
#=============================================================================
# filename.toml --- bash script
# Copyright (c) 2050 @EasyQuest
# Author: Ivan Yastrebov < easy-quest@mail.ru >
# URL: https://easy-quest.github.io/web/
#=============================================================================
banner

MESSAGE="Сценарии оболочки - это весело!"
echo "$MESSAGE"

FILE="./.venv/bin/activate"

if [ -e "$FILE" ]
then
  echo "Виртуаллное окружение существует"
else
  echo "Виртуаллное окружение не установленно"
echo "Попытаюсь исправить"
  sleep 3
  function_venv
  if [ -e "$FILE" ]
  then
    echo "Исправила ситуацию, Виртуальое окружение установленно"
  fi
fi


# cat > .github/workflows/ci.yml << ZZZ
# name: ci #
# on:
  # push:
    # branches: #
      # - master
      # - main
# jobs:
  # deploy:
    # runs-on: ubuntu-latest
    # steps:
      # - uses: actions/checkout@v2
      # - uses: actions/setup-python@v2
        # with:
          # python-version: 3.x
      # - run: pip install mkdocs-material #
      # - run: mkdocs gh-deploy --force
# zzz


# mkdocs gh-deploy --force

# gitlab

# cat > .gitlab-ci.yml << ZZZ

# image: python:latest
# pages:
  # stage: deploy
  # only:
    # - master
  # script:
    # - pip install mkdocs-material
    # - mkdocs build --site-dir public
  # artifacts:
    # paths:
      # - public
# ZZZ

#⠣ esim.i2p.gitlab.io/web
