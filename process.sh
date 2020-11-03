#!/usr/bin/env bash

adm3="GHA"

mkdir -p $adm3/threshold
mkdir -p $adm3/vector

pushd $adm3

# 0.5m to 1m

from_threshold="0.5"
to_threshold="1"

ls *.tif | sed 's/.tif//' | parallel \
    gdal_calc.py \
        -A {}.tif \
        --outfile="threshold/{}_${from_threshold}m${to_threshold}m.tif" \
        --calc="\"logical_and(A>=$from_threshold,A<$to_threshold)\"" \
        --type=Byte \
        --NoDataValue=0 \
        --co=SPARSE_OK=YES \
        --co=NBITS=1 \
        --quiet \
        --co=COMPRESS=LZW


ls *.tif | sed 's/.tif//' | parallel \
    gdal_polygonize.py \
        "threshold/{}_${from_threshold}m${to_threshold}m.tif" \
        -q \
        -f "GPKG" \
        vector/{}_${from_threshold}m${to_threshold}m.gpkg


# 1m to 4m

from_threshold="1"
to_threshold="4"

ls *.tif | sed 's/.tif//' | parallel \
    gdal_calc.py \
        -A {}.tif \
        --outfile="threshold/{}_${from_threshold}m${to_threshold}m.tif" \
        --calc="\"logical_and(A>=$from_threshold,A<$to_threshold)\"" \
        --type=Byte \
        --NoDataValue=0 \
        --co=SPARSE_OK=YES \
        --co=NBITS=1 \
        --quiet \
        --co=COMPRESS=LZW

ls *.tif | sed 's/.tif//' | parallel \
    gdal_polygonize.py \
        "threshold/{}_${from_threshold}m${to_threshold}m.tif" \
        -q \
        -f "GPKG" \
        vector/{}_${from_threshold}m${to_threshold}m.gpkg


# 4m to 999m

from_threshold="4"
to_threshold="999"

ls *.tif | sed 's/.tif//' | parallel \
    gdal_calc.py \
        -A {}.tif \
        --outfile="threshold/{}_${from_threshold}m${to_threshold}m.tif" \
        --calc="\"logical_and(A>=$from_threshold,A<$to_threshold)\"" \
        --type=Byte \
        --NoDataValue=0 \
        --co=SPARSE_OK=YES \
        --co=NBITS=1 \
        --quiet \
        --co=COMPRESS=LZW

ls *.tif | sed 's/.tif//' | parallel \
    gdal_polygonize.py \
        "threshold/{}_${from_threshold}m${to_threshold}m.tif" \
        -q \
        -f "GPKG" \
        vector/{}_${from_threshold}m${to_threshold}m.gpkg

popd
