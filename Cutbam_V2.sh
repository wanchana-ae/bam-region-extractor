#!/bin/bash
#================================================================================================
# Cut BAM files by multiple positions with read positions from a file
# Refactored version
#================================================================================================

# Input/Output files
INFO_FILE="name_bam.txt"       # List of BAM files (one per line)
POS_FILE="positions.txt"       # Chr,start,stop,gene
PATH_OUTPUT="./"
TMP="/tmp/"
NUMBER_CPU=16

# Load samtools module
ml load samtools

# Print Info
echo "===================================================================================="
echo "Input BAM list       : $INFO_FILE"
echo "Positions file       : $POS_FILE"
echo "Output path          : $PATH_OUTPUT"
echo "Number of CPU threads: $NUMBER_CPU"
echo "===================================================================================="
sleep 2

# Create output path
mkdir -p "$PATH_OUTPUT"

# Read positions file
while IFS=',' read -r Chr Start Stop Gene; do
    Positions="${Chr}:${Start}-${Stop}"
    Extend_output="Chr${Chr}_${Start}_${Stop}_${Gene}"
    mkdir -p "${PATH_OUTPUT}/${Extend_output}"

    echo "Processing positions: $Positions ($Gene)"

    # Read BAM list
    while IFS= read -r SampleBAM; do
        # Get sample name without path and extension
        Name_output=$(basename "$SampleBAM" .bam)
        OutBAM="${PATH_OUTPUT}/${Extend_output}/${Name_output}.bam"

        echo "------------------------------------------------------------------------------------"
        echo "Sample BAM : $SampleBAM"
        echo "Output BAM : $OutBAM"
        echo "Positions  : $Positions"
        echo "------------------------------------------------------------------------------------"

        # Cut BAM and index
        samtools view -h -b --threads 1 "$SampleBAM" "$Positions" > "$OutBAM"
        samtools index -b -@ "$NUMBER_CPU" "$OutBAM"

    done < "$INFO_FILE"

done < "$POS_FILE"

echo "All Done!"
