#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=job.DIRTOANALYZE
#SBATCH --time=24:00:00
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --output=DIRTOANALYZE.output
#SBATCH --error=DIRTOANALYZE.error

## This is the directory where all our subject file names are sitting
mainDir=(/work/mindlab/Projects/fitkids2mus/matlabprograms/original_data)

## This is the list of our sub???_1 names
sub_dirs=$(cat sub_dirs.txt)

## Change directory the main directory
cd $mainDir

## For each subject
for i in $sub_dirs
do	
    ## if sub???_1/sub???_1_dfit.dt6.mat exists:
    if [  -f ${i}/${i}_dfit_dt6.mat ]; then
        ## copy the dt6 file and rename it to dt6.mat
        echo "copying ${i}/${i}_dfit_dt6.mat"
	cp ${i}/${i}_dfit_dt6.mat ${i}/dt6.mat
    fi
done
