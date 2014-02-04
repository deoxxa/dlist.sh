#!/bin/sh

. ./dlist.sh

dlist_init ABC

dlist_push ABC 5
dlist_push ABC 6
dlist_push ABC 7
dlist_push ABC 8

echo "Length: $(dlist_length ABC)"
echo "Offset 3: $(dlist_get ABC 3)"
