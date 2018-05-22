#!/bin/bash
# coding: utf-8

# <bitbar.title>Kinnosuke check in/out</bitbar.title>
# <bitbar.version>v1.0.0</bitbar.version>
# <bitbar.author>Uchio Kondo</bitbar.author>
# <bitbar.author.github>udzura</bitbar.author.github>
# <bitbar.desc>Check in/out your office via kinnosuke</bitbar.desc>
# <bitbar.image>https://raw.githubusercontent.com/udzura/bitbar-kinnosuke-cli/master/screemshot.png</bitbar.image>
# <bitbar.dependencies>bash</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/udzura/bitbar-kinnosuke-cli</bitbar.abouturl>

export PATH=$PATH:/usr/local/bin
if ! which kinnosuke-clocking-cli >/dev/null; then
    echo "💀Error | color=red"
    echo '---'
    echo "Please install kinnosuke-cli | color=red"
    echo "➡️ Vist GitHub | color=red href=https://github.com/yano3/kinnosuke-clocking-cli/"
    exit 1
fi

if test -f ~/.kinnosuke; then
    source ~/.kinnosuke
else
    echo "💀Error | color=red"
    echo '---'
    echo "Please create config file ~/.kinnosuke as: | color=red"
    echo "export KINNOSUKE_COMPANYCD=\"...\" | color=red"
    echo "export KINNOSUKE_LOGINCD=\"...\" | color=red"
    echo "export KINNOSUKE_PASSWORD=\"...\" | color=red"
    exit 1
fi

popup() {
    msg="$1"
    echo $msg
    osascript -e "display notification \"${msg}\" with title \"Kinnosuke\""
}

case "$1" in
    checkin)
        res=$(kinnosuke-clocking-cli -y)
        if [ "$?" -eq "0" ]; then
            popup "Check in OK: ${res}"
        else
            popup "Check in failed"
        fi
        exit
        ;;
    checkout)
        res=$(kinnosuke-clocking-cli -o -y)
        if [ "$?" -eq "0" ]; then
            popup "Check out OK: ${res}"
        else
            popup "Check out failed"
        fi
        exit
        ;;
esac

res=$(kinnosuke-clocking-cli -n -y)
if [ "$?" -ne "0" ]; then
    echo "⚡️Error | color=red"
    echo '---'
    echo "kinnosuke command failed(may be offline or prohibited IP) | color=red"
    exit 1
fi

cin=$(echo $res | awk -F, '{print $1}' | awk '{print $2}')
cout=$(echo $res | awk -F, '{print $2}' | awk '{print $2}')
color=black

if [ "$cin" = "<notyet>" ]; then
    color=red
fi
if [ "$cout" = "<notyet>" ]; then
    if ! /usr/bin/ruby -rtime -e 'exit Time.now < Time.parse("18:00")'; then
        color=red
    fi
fi

echo "🏢${cin} 🚶‍♂️${cout} | color=${color}"

echo '---'
echo "🏢 Check in | bash='$0' param1=checkin terminal=false"
echo "🚶‍♂️ Check out | bash='$0' param1=checkout terminal=false"
