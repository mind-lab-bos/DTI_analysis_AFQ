#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=dtiinit
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=sbatch_submissions/dtiInit/dtiInit.output
#SBATCH --error=sbatch_submissions/dtiInit/dtiInit.error

## Specify the directory of where your scripts "live":
scriptsDir=/work/mindlab/Projects/mci/mci_afq/scripts/dtiInit

## OPTIONAL: create a separate input directory, where all sub??? files live, which is separate from the output files. 
## This may be useful for copying stuff back and forth. For now, it is set the same as "workDir":
inputDir=/work/mindlab/Projects/mci/mci_afq/subjects

## you can specify a particular directory you want to work in, or leave it as the current 
## directory, with variable "$PWD". 
workDir=/work/mindlab/Projects/mci/mci_afq/subjects

# Go to where the files are sitting for dtiInit
cd $scriptsDir

## Get the list of directories to analyze:
list=$(cat sub_dirs.txt)

# go to the working directory and make directories to put the individually submitted scripts
cd $workDir
mkdir sbatch_submissions
mkdir sbatch_submissions/dtiInit

## loop through the list:
for i in $list
do	
	## if an output directory already exists, skip the analysis:
	if [ ! -d $workDir/dti128trilin ]; then
		## search and replace a pattern within the template.bash script to create
		## a new script that analyzes a particular directory named $i
		sed "s/DIRTOANALYZE/$i/g;s|INPUTDIRPATH|$inputDir|g" $scriptsDir/template_dtiInit.bash > $workDir/sbatch_submissions/dtiInit/submit_dtiInit_$i.bash
		sbatch $workDir/sbatch_submissions/dtiInit/submit_dtiInit_$i.bash
		echo "Running dtiInit for $i"
		sleep 1
	fi
done
