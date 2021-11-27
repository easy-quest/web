#!/usr/bin/env bash
#=============================================================================
# filename.sh --- bash script
# Copyright (c) 2050 @EasyQuest
# Author: {{ .name }} < {{ .email }} >
# URL: https://easy-quest.github.io/web/
#=============================================================================

function banner() {
cat <<\ZZZ
 _____                 ___                  _
| ____|__ _ ___ _   _ / _ \ _   _  ___  ___| |_
|  _| / _` / __| | | | | | | | | |/ _ \/ __| __|
| |__| (_| \__ \ |_| | |_| | |_| |  __/\__ \ |_
|_____\__,_|___/\__, |\__\_\\__,_|\___||___/\__|
                |___/
ZZZ
}
function function_venv() {
  #function_body
    py3=$(command -v python3.10)
  $py3 -m venv .venv
}


