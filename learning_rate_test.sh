#!/bin/bash
# Qualitative testing of learning rate for Adam optimizer with learning rates between 0.0003 and 0.9997
# E.g. ./learning_rate_test.sh "Qualitiate appeal | sense of aesthetic" test1.png 180

TEXT="$1"
FILENAME="$2"
ITERATIONS="$3"

OPTIMISER=Adam
SEED=`shuf -i 1-9999999999 -n 1` # Keep the same seed each epoch for more deterministic runs

# Extract
FILENAME_NO_EXT=${FILENAME%.*}
FILE_EXTENSION=${FILENAME##*.}

# File counter
n=0

for i in $(seq 0.0003 0.1999 1.1996)
do
	padded_count=$(printf "%04d" "$n")
	python generate.py -p="$TEXT" -opt="$OPTIMISER" -lr="$i" -i="$ITERATIONS" --seed="$SEED" -o="$FILENAME"
	cp "$FILENAME" "$FILENAME_NO_EXT"-"$padded_count"."$FILE_EXTENSION"
	n=$((n+1))
done