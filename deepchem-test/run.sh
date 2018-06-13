#!/bin/bash

SEED=$1
HIDDEN=300
BASE=MPN-s"$SEED"h"$HIDDEN"
echo "random seed $SEED"
mkdir $BASE

#Small datasets
echo "training delaney"
mkdir $BASE/delaney
python nnregress.py --train data/delaney.csv --hidden $HIDDEN --save_dir $BASE/delaney --seed $SEED --batch 10 | tee $BASE/delaney/LOG

echo "training freesolv"
mkdir $BASE/freesolv
python nnregress.py --train data/freesolv.csv --hidden $HIDDEN --save_dir $BASE/freesolv --seed $SEED --batch 10 | tee $BASE/freesolv/LOG

echo "training lipo"
mkdir $BASE/lipo
python nnregress.py --train data/lipo.csv --hidden $HIDDEN --save_dir $BASE/lipo --seed $SEED --batch 10 | tee $BASE/lipo/LOG

echo "training bace"
mkdir $BASE/bace
python nnclassify.py --train data/bace.csv --hidden $HIDDEN --save_dir $BASE/bace --seed $SEED --batch 10 --split scaffold | tee $BASE/bace/LOG

echo "training BBBP"
mkdir $BASE/BBBP
python nnclassify.py --train data/BBBP.csv --hidden $HIDDEN --save_dir $BASE/BBBP --seed $SEED --batch 10 --split scaffold | tee $BASE/BBBP/LOG

echo "training tox21"
mkdir $BASE/tox21
python nnclassify.py --train data/tox21.csv --hidden $HIDDEN --save_dir $BASE/tox21 --seed $SEED | tee $BASE/tox21/LOG

echo "training toxcast"
mkdir $BASE/toxcast
python nnclassify.py --train data/toxcast.csv --hidden $HIDDEN --save_dir $BASE/toxcast --seed $SEED | tee $BASE/toxcast/LOG

echo "training sider"
mkdir $BASE/sider
python nnclassify.py --train data/sider.csv --hidden $HIDDEN --save_dir $BASE/sider --seed $SEED --batch 10 | tee $BASE/sider/LOG

echo "training clintox"
mkdir $BASE/clintox
python nnclassify.py --train data/clintox.csv --hidden $HIDDEN --save_dir $BASE/clintox --seed $SEED --batch 10 | tee $BASE/clintox/LOG

#Large datasets
echo "training MUV"
mkdir $BASE/muv
python nnclassify.py --train data/muv.csv --hidden $HIDDEN --save_dir $BASE/muv --seed $SEED --metric prc | tee $BASE/muv/LOG

echo "training HIV"
mkdir $BASE/HIV
python nnclassify.py --train data/HIV.csv --hidden $HIDDEN --save_dir $BASE/HIV --seed $SEED --split scaffold | tee $BASE/HIV/LOG

echo "training pcba"
mkdir $BASE/pcba
python nnclassify.py --train data/pcba.csv --hidden $HIDDEN --save_dir $BASE/pcba --seed $SEED --metric prc --anneal 50000 | tee $BASE/pcba/LOG
