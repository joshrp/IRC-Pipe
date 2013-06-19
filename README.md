#IRC Pipe
##Command line interface to IRSSI

###Usage:
irc [-c iplayer] [-u Josh] [-m "This is my Data: %0"]

You will need [irc remote control](http://arvin.schnell-web.net/irssi/remote_control.html) installed in `.irssi/scripts/` to enable remote command of irssi. This creates a FIFO in `~/.irssi/rc` which will send EVERYTHING to irssi.

Exmaple Usages:

######Default:
    echo "some text" | irc
  
######Output to channel: 
    echo "Hai" | irc -c mychan
 
######Send to user (as found in default channel): 
    echo "Hai" | irc -u Josh

######Send to user from specified channel: 
    echo "Hai" | irc -c iplayer -u Josh

######Send formatted message to default channel, "here's some crap code": 
    echo "Crap" | irc -m"here's some %0 code "

###Implementation
It's horrid, there's no feedback from irssi so it's just assumed every command works, and continue on.

We switch to the specified channel by joining it `/join #$CHANNEL`. 

We issue `/query $USER` if needed.

We issue `/say $MESSAGE` after processing.

If any of those fail, it will still execute. So if we can't join a channel, then the message will just get sent in the active window. This is a Bad Thing. 

Even worse: If a user isn't found, the message is just output to the channel. Very Bad Thing.

Take Care.

##Plus 
My Bash skills are lacking to a monkey using Bing.

Please improve this script.