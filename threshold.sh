#!/usr/bin/env bash

# Cut at threshold and polygonize
# usage:
#   bash threshold.sh <adm3> <min_depth> <max_depth>
#
# e.g. for Ghana:
#   bash threshold.sh GHA 0.5 1.0

adm3=$1

min_depth=$2
max_depth=$3

# Sense check
echo "Cut and polygonize for $adm3, $min_depth <= depth < $max_depth"

# Make threshold and vector directories
mkdir -p $adm3/threshold
mkdir -p $adm3/vector

pushd $adm3

# Calculate mask where raster values are between thresholds
ls *.tif | sed 's/.tif//' | parallel \
    gdal_calc.py \
        -A {}.tif \
        --outfile="threshold/{}_${min_depth}m${max_depth}m.tif" \
        --calc="\"logical_and(A>=$min_depth,A<$max_depth)\"" \
        --type=Byte \
        --NoDataValue=0 \
        --co=SPARSE_OK=YES \
        --co=NBITS=1 \
        --quiet \
        --co=COMPRESS=LZW

# Convert raster masks to vector polygons
ls *.tif | sed 's/.tif//' | parallel \
    gdal_polygonize.py \
        "threshold/{}_${min_depth}m${max_depth}m.tif" \
        -q \
        -f "GPKG" \
        vector/{}_${min_depth}m${max_depth}m.gpkg

popd
