%%%%%%%
function template_dtiInit(INPUTDIRPATH, DIRTOANALYZE)

% Initialize path names from template_dtiInit.bash
INPUTDIRPATH = char(INPUTDIRPATH)
DIRTOANALYZE = char(DIRTOANALYZE)

% Go to the individual subject folder (named DIRTOANALYZE)
% INPUTDIRPATH is the base file path, in this case, /work/mindlab/Projects/mci/mci_afq
cd(INPUTDIRPATH)
cd(DIRTOANALYZE)
% Initialize dtiInit parameters (rotateBvecsWithCanXform is needed for Siemens scanners) and output directory
dwParams = dtiInitParams('rotateBvecsWithCanXform', 1, 'outDir', char(strcat(INPUTDIRPATH, '/', DIRTOANALYZE)), 'clobber', 1)
% Run dtiInit with the specified .nii.gz file and acpc aligned T1 weighted file
[dt6FileName, outBaseDir] = dtiInit([char(strcat(DIRTOANALYZE, '_dwi.nii.gz'))],['average_T1w_acpc.nii.gz'],dwParams);