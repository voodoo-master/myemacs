#!/bin/bash

export LC_ALL="zh_CN.UTF-8"

program_dir="/usr/local/bin"
program_name=`ls $program_dir/emacs-*`

ps -ef|grep -v grep|grep -q $program_name

is_running=$?

if [ $is_running -ne 0 ]
then
    $program_name "$@"
else
    if [ $# -gt 0 ]
    then
        echo "more than 0 params"
        $program_dir/emacsclient "$@"
    else
        echo "emacs is already running"
        exit 0
    fi
fi

