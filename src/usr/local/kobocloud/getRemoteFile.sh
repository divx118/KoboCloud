#!/bin/sh

linkLine="$1"
localFile="$2"
user="$3"    

#load config
. `dirname $0`/config.sh


if [ "$user" = "" ]; then
    curlCommand=$CURL
else
    curlCommand="$CURL -u $user: "
fi
    
echo $curlCommand
    
echo "$linkLine -> $localFile"

remoteSize=`$curlCommand -k -L --silent --head "$linkLine" | sed -n 's/^Content-Length\: \([0-9]*\).*/\1/ip'`
if [ -f $localFile ]; then
  localSize=`stat -c%s "$localFile"`
else
  localSize=0
fi
if [ $localSize -ge $remoteSize ]; then
  echo "File exists: skipping"
else
  $curlCommand -k --silent -C - -L -o "$localFile" "$linkLine" # try resuming
  if [ $? -ne 0 ]; then
    echo "Error resuming: redownload file"
    $curlCommand -k --silent -L -o "$localFile" "$linkLine" # restart download
  fi
fi
