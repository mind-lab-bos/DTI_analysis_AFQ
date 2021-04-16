for ii = 1:length(sub_dirs);
  cd (char(strcat(sub_dirs(ii))));
  if isfile(dt6filename)
    warningMessage = sprintf('Warning: dt6.mat exists\n%s', dt6filename);
    cd ..
  else
      %% Since data is from a Siemens scanner, make sure to set rotateBvecsWithCanXform to 1
    dwParams = dtiInitParams('rotateBvecsWithCanXform', 1)
	  [dt6FileName, outBaseDir] = dtiInit([],[],dwParams);
    cd ..
  end
end
