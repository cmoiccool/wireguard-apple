#!/bin/bash

pwd && ls -al 
cd Sources/WireGuardKitGo
pwd && ls -al 

make
echo "---------------------------------------------------------------------------"
pwd && ls -al
cd out
pwd && ls -al
cp WireGuardKit.framework
pwd && ls -al