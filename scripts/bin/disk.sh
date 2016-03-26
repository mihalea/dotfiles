#!/bin/sh

df -h -P -l $1 | tail -n 1 | awk '{ print $4; }'
