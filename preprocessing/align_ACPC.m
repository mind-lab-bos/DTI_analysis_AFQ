for ii = 1:length(sub_dirs);
    addpath (char(strcat(sub_dirs(ii))));
    cd (char(strcat(sub_dirs(ii))));
    fileNameList = 'char(strcat(sub_dirs(ii), '1_dfit_FA.mat'))'
    outFileName = 'dt6.mat'
    mrAnatAverageAcpcNifti
    %% Use the GUI to select ACPC landmarks
