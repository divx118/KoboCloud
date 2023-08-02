#!/bin/sh
Logs=/mnt/onboard/.add/kobocloud
Lib="/mnt/onboard/Digital Editions"
SD=/mnt/sd/kobocloud
UserConfig=/mnt/onboard/.add/kobocloud/kobocloudrc
Dt="date +%Y-%m-%d_%H:%M:%S"
CURL="$KC_HOME/curl --cacert \"$KC_HOME/ca-bundle.crt\" "
