#!/bin/bash

function prop {
    grep "${2}" $1|cut -d'=' -f2
}

PASSWORD_FILE=$(prop /Users/serverscript/credential 'pwd')
PIN_COPIED=$(pbpaste)"\r"


  /usr/bin/expect <(cat << EOF
spawn ssh user@host
expect "password"
send $PASSWORD_FILE
expect "PIN"
send $PIN_COPIED
interact
EOF
)
