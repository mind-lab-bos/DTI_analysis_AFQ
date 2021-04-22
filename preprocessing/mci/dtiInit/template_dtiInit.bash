#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=job.DIRTOANALYZE
#SBATCH --ntasks=1
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --mem=60G
#SBATCH --output=DIRTOANALYZE.output
#SBATCH --error=DIRTOANALYZE.error

# Load the matlab module and run the template_dtiInit.m script using paths from dtiInit.sh
module load matlab/R2020a

matlab -nodisplay -nosplash -r "template_dtiInit('INPUTDIRPATH', 'DIRTOANALYZE')"