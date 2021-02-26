% Load dt6.mat for the first control participant (or any participant of interest)

dt = dtiLoadDt6(fullfile(sub_dirs{34},'dt6.mat'));
fg = dtiReadFibers(fullfile(sub_dirs{34},'fibers','MoriGroups_clean_D5_L4.mat'));
numNodes = 100;
[fa, md, rd, ad, cl, volume, TractProfile] = AFQ_ComputeTractProperties(fg,dt,numNodes);


for jj = 1:20
    % Run an independent samples t-test comparing FA values between the
    % groups at each point along each tract
    [h(jj,:),p(jj,:),~,Tstats(jj)] = ttest2(afq.patient_data(jj).FA,afq.control_data(jj).FA);
end
for jj = 1:20
    TractProfile(jj) = AFQ_TractProfileSet(TractProfile(jj),'vals','pval',p(jj,:));
    TractProfile(jj) = AFQ_TractProfileSet(TractProfile(jj),'vals','Tstat',Tstats(jj).tstat);
end

cmap = 'hot';
% Set the color range to black out non significant regions of the tract. We
% will render the T-stat profile such that T statistics greater than 5 will
% be white and T statistics less than 1 will be black. Obviously a T value
% of 1 is not considered significant however in this example we only have 3
% subjects in each group hence we use a low value just to demonstrate the
% proceedure.
crange = [1 4];
% Set the number of fibers to render. More fibers takes longer
numfibers = 200;

% Render the left corticospinal tract (fibers colored light blue) with a
% Tract Profile of T statistics. Each fiber will have a 1mm radius and the
% tract profile will have a 6mm radius.
AFQ_RenderFibers(fg(19),'color',[.8 .8 1],'tractprofile',TractProfile(19),...
    'val','Tstat','numfibers',numfibers,'cmap',cmap,'crange',crange,...
    'radius',[1 6]);
    
% Add the defining ROIs to the rendering.
[roi1 roi2] = AFQ_LoadROIs(19,sub_dirs{33});
% The rois will be rendered in dark blue
AFQ_RenderRoi(roi1,[0 0 .7]);
AFQ_RenderRoi(roi2,[0 0 .7]);

% Add the slice x=-15 from the subject's b=0 image
b0 = readFileNifti(dt.files.b0);
AFQ_AddImageTo3dPlot(b0,[-15,0,0]);
