%% Start in the folder conta

for ii = 1:length(sub_dirs);
    addpath (char(strcat(sub_dirs(ii))));
    cd (char(strcat(sub_dirs(ii))));
    fileNameList = char(strcat(sub_dirs(ii), '_dfit_FA.nii.gz'))
    mrAnatAverageAcpcNifti(fileNameList, 'average.nii.gz')

    cd ..
    end
    %% Use the GUI to select ACPC landmarks
