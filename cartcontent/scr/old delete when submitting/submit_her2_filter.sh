#!/bin/bash
### Account information
#PBS -W group_list=dtu_00062 -A dtu_00062
### Job name
#PBS -N her2_filter
### Output files
#PBS -e /home/projects/dtu_00062/people/giomor/cart_test/her2_filter.err
#PBS -o /home/projects/dtu_00062/people/giomor/cart_test/her2_filter.out
### Email notifications: a=abort, b=begin, e=end
#PBS -m abe
#PBS -M giorgia.moranzoni@sund.ku.dk
### Resources: 1 thin node, 1 CPU, 180GB RAM, 3 hours
#PBS -l nodes=1:thinnode:ppn=1,mem=180gb,walltime=03:00:00

set -euo pipefail

echo "Working directory: $PBS_O_WORKDIR"
cd "$PBS_O_WORKDIR"

# Clean environment
module purge

# REQUIRED stack (do not reorder)
module load tools
module load intel/basekit/INITIALIZE/2023.0.0
module load intel/basekit/mkl/2023.0.0
module load gcc/14.2.0
module load R/4.5.0

# Sanity checks (very important)
which R
which Rscript
R --version

echo "Starting HER2 filtering at $(date)"
Rscript filter_her2_expression.R
echo "Finished at $(date)"