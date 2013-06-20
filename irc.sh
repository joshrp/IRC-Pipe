#!/bin/bash
usage()
{
cat << EOF
usage: $0 options

Reads STDIN and outputs to specified channel [iplayer]

OPTIONS:
   -h      Show this message
   -c      Channel, defaults to \#iplayer
   -u      Spcific user in channel
   -m      Message to parse, use "%s" to place piped content
   -n      Dry Run, just echo commands

EOF
exit;
}

USER=false
CHANNEL=iplayer
MESSAGE=false
DATA=false
RC=~/.irssi/rc
TESTMODE=false

while getopts “:hc:u:m:n” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         c)
             CHANNEL=$OPTARG
             ;;
         u)
             USER=$OPTARG
             ;;
         m)
             MESSAGE=$OPTARG
             ;;
         n)
             TESTMODE=true
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

read DATA;

function send_cmd {
  if [ $TESTMODE == true ]; then
    TARGET=/tmp/irctest
  else
    TARGET=$RC
  fi
  echo $@ > $TARGET
  if [ $TESTMODE == true ]; then
    cat /tmp/irctest && rm /tmp/irctest
  fi
}

if [ "$MESSAGE" != false ]; then
  MSG=$(printf "$MESSAGE" $DATA);
else
	MSG="$DATA"
fi

if [ $USER != false ]; then
  send_cmd "/query $USER";
  send_cmd "/msg $USER $MSG";
else
  send_cmd "/join #$CHANNEL";
  send_cmd "/msg #$CHANNEL $MSG";
fi
