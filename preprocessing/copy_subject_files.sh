#!/bin/bash

## This is the directory where all our subject directories will be placed
mainDir=(/work/mindlab/Projects/mci/mci_afq/subjects)

## This is where all the raw bids data is sitting
inputDir=(/work/mindlab/NUBIC/MCI_Study/raw_bids)

cd $inputDir

## This is the list of our sub-??? names
sub_dirs=` ls -d sub-???`

## Change directory to the main directory where we want subject files to be copied
cd $mainDir

## For each subject
for i in $sub_dirs
do	
    ## if dt6.mat exists for the subject:
    if [  -f /work/mindlab/Projects/mci/mci_afq/subjects/${i}/dt6.mat ]; then
        ## skip this subject, they have been processed already
        :
    # Otherwise, copy the bval/bvec/json/T1 weighted files into the directories of interest
    else
        mkdir $mainDir/${i}
	    cp $inputDir/${i}/dwi/${i}_dwi.bval $mainDir/${i}/${i}_dwi.bval
	    cp $inputDir/${i}/dwi/${i}_dwi.bvec $mainDir/${i}/${i}_dwi.bvec
	    cp $inputDir/${i}/dwi/${i}_dwi.json $mainDir/${i}/${i}_dwi.json
	    cp $inputDir/${i}/dwi/${i}_dwi.nii.gz $mainDir/${i}/${i}_dwi.nii.gz
	    cp $inputDir/${i}/anat/${i}_run-02_T1w.nii.gz $mainDir/${i}/${i}_run-02_T1w.nii.gz
	    echo "Copying raw bids data for ${i}"
	 
    fi
done

echo "$sub_dirs"