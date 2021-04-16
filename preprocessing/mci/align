%% Start in the folder containing subject folders

for ii = 1:length(sub_dirs);
  addpath (char(strcat(sub_dirs(ii))));
  cd (char(strcat(sub_dirs(ii))));
  fileNameList = char(strcat(sub_dirs(ii), '_run-02_T1w.nii.gz'))
  mrAnatAverageAcpcNifti(fileNameList, 'average_T1w_acpc.nii.gz')
  cd ..
end

%% Use the GUI to select ACPC landmarks
