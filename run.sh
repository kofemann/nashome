#!/bin/sh

#nmbd -D
smbd --foreground --log-stdout < /dev/null
