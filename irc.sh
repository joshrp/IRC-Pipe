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
   -m      Message to parse, use "%0" to place piped content

EOF
exit;
}

USER=false
CHANNEL=iplayer
MESSAGE=false
DATA=false
RC=~/.irssi/rc

while getopts “:hc:u:m:” OPTION
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
         ?)
             usage
             exit
             ;;
     esac
done


read DATA;

if [ "$MESSAGE" != false ]; then
	MSG=$(echo $MESSAGE | sed s/%0/$DATA/gmi);
else
	MSG="$DATA"
fi

echo "/join #$CHANNEL" > $RC;

if [ $USER != false ]; then
	echo "/query $USER" > $RC;
fi

echo "/say $MSG" > $RC;


