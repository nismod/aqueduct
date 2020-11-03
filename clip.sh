#!/usr/bin/env bash

# Clip to bounding box
adm3="GHA"

xmin="-3.262509"
ymin="4.737128"
xmax="1.187968"
ymax="11.162937"


mkdir -p $adm3

ls *.tif | parallel gdalwarp -te $xmin $ymin $xmax $ymax {} $adm3/{}
