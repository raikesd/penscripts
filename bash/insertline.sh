#!/bin/bash
sed -i -n 'H;${x;s/^\n//;s/exit .*\n/shutdown now -h\n&/;p;}' /etc/rc.local
if [ $? -eq 0 ]
then
	echo "/etc/rc.local updated successfully"
else
	echo "/etc/rc.local not updated."
fi
