% Create a cell array where each cell is the path to a data directory. In our case, sub111_1 is an example.
sub_dirs = fileread('sub_dirs.txt');
sub_dirs = regexp(sub_dirs, '\r\n|\r|\n', 'split');

% Run the dtiMakeDt6FromFsl function to generate DT6.mat files from FSL preprocessed data 
for ii = 1:length(sub_dirs);
    addpath (char(strcat(sub_dirs(ii))));
    cd (char(strcat(sub_dirs(ii))));
    dt6filename = char(strcat(sub_dirs(ii), '_dfit_dt6.mat'))
    if isfile(dt6filename)
        warningMessage = sprintf('Warning: dt6.mat exists\n%s', dt6filename);
        cd ..
    else
        b0filename = char(strcat(sub_dirs(ii), '_dfit_S0.nii.gz'));
        FAfilename = char(strcat(sub_dirs(ii), '_dfit_FA.nii.gz'));
        dtiMakeDt6FromFsl([b0filename], [FAfilename]);
        cd ..
    end
end
