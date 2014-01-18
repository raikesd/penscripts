#!/bin/bash
arp-scan -I eth0 -l | perl -ne '/((\d{1,3}\.){3}\d{1,3})/ and $ip=$1 and $_=`nmblookup -A $ip` and /([[:alnum:]-]+)\s+<00>[^<]+<ACTIVE>/m and printf "%15s %s\n",$ip,$1'


