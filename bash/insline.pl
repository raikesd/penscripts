#!/usr/bin/perl -w
s/exit 0\n/shutdown now -h\niexit 0\n/; s/continue./\ncontinue./; print '
