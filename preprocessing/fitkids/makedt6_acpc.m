for ii = 1:length(sub_dirs);
  cd (char(strcat(sub_dirs(ii))));
  dt6filename = 'dt6_acpc.mat'
  if isfile(dt6filename)
    warningMessage = sprintf('Warning: dt6.mat exists\n%s', dt6filename);
    cd ..
  else
    b0filename = char(strcat(sub_dirs(ii), '_dfit_S0.nii.gz'));
    FAfilename = 'average.nii.gz';
    dtiMakeDt6FromFsl([b0filename], [FAfilename], dt6filename);
    cd ..
  end
end
