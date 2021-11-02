#!/data/data/com.termux/files/usr/bin/bash

set -e 


#python -m venv .venv 
#./.venv/bin/python -m pip install -U pip setuptools wheel pip-tools 
# ./.venv/bin/python -m pip install -U -r requirements.txt

if [ eq .chezmoi.os = "android" ]; then
    ./.venv/bin/mkdocs serve
fi


