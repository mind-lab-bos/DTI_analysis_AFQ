% Loop over all 20 fiber groups
for jj = 1:20
    % Run an independent samples t-test comparing FA values between the
    % groups at each point along each tract
    [h(jj,:),p(jj,:),~,Tstats(jj)] = ttest2(afq.patient_data(jj).FA,afq.control_data(jj).FA);
end

% Load the cleaned segmented fibers for the first control subject
for ss = 1:length(sub_dirs);
    fg = dtiReadFibers(fullfile(sub_dir{ss},'fibers','MoriGroups_clean_D5_L4.mat'));
    % Load the subject's dt6 file
    dt = dtiLoadDt6(fullfile(sub_dirs{ss},'dt6.mat'));
    % Compute Tract Profiles with 100 nodes
    numNodes = 100;
    [fa, md, rd, ad, cl, volume, TractProfile] = AFQ_ComputeTractProperties(fg,dt,numNodes);
    % Add the pvalues and T statistics from the group comparison to the tract
    % profile. This same code could be used to add correlation coeficients or
    % other statistics
    for jj = 1:20
        TractProfile(jj) = AFQ_TractProfileSet(TractProfile(jj),'vals','pval',p(jj,:));
        TractProfile(jj) = AFQ_TractProfileSet(TractProfile(jj),'vals','Tstat',Tstats(jj).tstat);
    end
    
    % Save the tract profile to the subject's directory
    cd (char(strcat(sub_dirs(ss))));
    save(sub_dirs{ss}, 'TractProfile.mat');
    
    for jj = 1:20
        % The hot colormap is a good one because it will allow us to make regions
        % of the profile where p>0.05 black.
        cmap = 'hot';
        % Set the color range to black out non significant regions of the tract. We
        % will render the T-stat profile such that T statistics greater than 5 will
        % be white and T statistics less than 1 will be black. Obviously a T value
        % of 1 is not considered significant however in this example we only have 3
        % subjects in each group hence we use a low value just to demonstrate the
        % proceedure.
        crange = [1 4];
        % Set the number of fibers to render. More fibers takes longer
        numfibers = 1000;
        % Render the left corticospinal tract (fibers colored light blue) with a
        % Tract Profile of T statistics. Each fiber will have a 1mm radius and the
        % tract profile will have a 6mm radius.
        AFQ_RenderFibers(fg(jj),'color',[.8 .8 1],'tractprofile',TractProfile(jj),...
            'val','Tstat','numfibers',numfibers,'cmap',cmap,'crange',crange,...
            'radius',[1 6]);
        
        % Add the slice x=-15 from the subject's b=0 image
        mkdir images
        b0 = readFileNifti('average.nii.gz');
        
        if jj/2 == 0
            AFQ_AddImageTo3dPlot(b0,[-1,0,0]);
            view(300, 25);
        
        else
            AFQ_AddImageTo3dPlot(b0,[1,0,0]);
            view(65, 24);
        end
        
        exportgraphics(gcf, char(strcat('images/', tract_file_names(jj), '.png')));
        close(gcf);
    end
    cd ..
end
