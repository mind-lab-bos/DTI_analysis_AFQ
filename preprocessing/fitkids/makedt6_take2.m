% Create a cell array where each cell is the path to a data directory. In our case, sub111_1 is an example.
sub_dirs = fileread('sub_dirs.txt');
sub_dirs = regexp(sub_dirs, '\r\n|\r|\n', 'split');

% Run the dtiMakeDt6FromFsl function to generate DT6.mat files from FSL preprocessed data 
for ii = 1:length(sub_dirs);
    addpath (char(strcat(sub_dirs(ii))));
    cd (char(strcat(sub_dirs(ii))));
    b0filename = char(strcat(sub_dirs(ii), '_dfit_S0.nii.gz'));
    
    % Use the flirted FA image! If you I already ran flirt on all the FA images during probtrackx and it is saved to a flirt directory in each subject directory.
    
    FAfilename = char(strcat('flirt/', sub_dirs(ii), '_dfit_FA_flirt.nii.gz'));
    dtiMakeDt6FromFsl([b0filename], [FAfilename], ['dt6.mat']);
    cd ..
    end
end
