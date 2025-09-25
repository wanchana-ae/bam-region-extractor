# BAM Region Cutter

A simple Bash script to extract specific regions from multiple BAM files based on a positions file.  
This is useful for analyzing or subsetting BAM files for genes, exons, or genomic regions of interest.

---

## Features
- Extract regions from BAM files using `samtools view`.
- Supports multiple positions and multiple BAM files.
- Automatically indexes the output BAM.
- Organizes output into folders based on chromosome, coordinates, and gene name.

---

## Requirements
- Linux environment
- Bash
- Samtools (version >= 1.10 recommended)
- Optional: GNU Parallel (for faster processing of multiple BAMs)

---

## Input Files

### 1. BAM list (`name_bam.txt`)
A plain text file with one BAM file path per line:

```/path/to/W_OS_00001.bam
   /path/to/W_OS_00002.bam```

### 2. Positions file (`positions.txt`)
A CSV file with **Chr,Start,Stop,Gene** columns:

```3,30080831,30081831,Os03g0734400
   3,30430405,30431405,Os03g0741500```

## Configuration
You can edit the top variables in the script:

- `INFO_FILE="name_bam.txt"`
- `POS_FILE="positions.txt"`
- `PATH_OUTPUT="./"`
- `NUMBER_CPU=16`


## Usage
### 1. Load samtools module:
```bash
ml load samtools
```
### 2. Run the script:
```bash
chmod +x ./Cutbam_V2.sh
./Cutbam_V2.sh
```
### 3. Output structure:
```
PATH_OUTPUT/
├── Chr3_30080831_30081831_Os03g0734400/
│   ├── W_OS_00001.bam
│   ├── W_OS_00001.bam.bai
│   └── ...
└── Chr3_30430405_30431405_Os03g0741500/
    ├── W_OS_00001.bam
    ├── W_OS_00001.bam.bai
    └── ...
```
