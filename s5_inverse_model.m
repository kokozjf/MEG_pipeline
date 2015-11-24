%% inverse model

load('forward_model.mat');

% create spatial filter using the lcmv beamformer
cfg                  = [];
cfg.method           = 'lcmv';
cfg.grid             = lf; % leadfield, which has the grid information
cfg.vol              = vol; % volume conduction model (headmodel)
cfg.lcmv.keepfilter  = 'yes';
cfg.lcmv.lambda      = '5%';
cfg.lcmv.fixedori    = 'yes'; % project on axis of most variance using SVD
source_avg           = ft_sourceanalysis(cfg, ERF);

%% pst and post 
ERF_part_cfg = []; 
ERF_part_cfg.toilim = [-0.1 0];
datapre = ft_redefinetrial(ERF_part_cfg, filting_data); 

ERF_part_cfg = [];
ERF_part_cfg.covariance= 'yes';
ERF_part_cfg.channel   = 'MEG';
avgpre = ft_timelockanalysis(ERF_part_cfg,datapre);

cfg=[];
cfg.method='lcmv';
cfg.grid=lf;
cfg.grid.filter=source_avg.avg.filter;
cfg.vol=vol;
sourcepre=ft_sourceanalysis(cfg, avgpre);


for i = 0:0.1:0.4 % automatical beamforming
    ERF_part_cfg.toilim = [i i+0.1];
    datapost = ft_redefinetrial(ERF_part_cfg, filting_data);
    ERF_part_cfg = [];
    ERF_part_cfg.covariance='yes';
    ERF_part_cfg.channel   = 'MEG';
    avgpst = ft_timelockanalysis(ERF_part_cfg,datapost);
    
    cfg=[];
    cfg.method='lcmv';
    cfg.grid=lf;
    cfg.grid.filter=source_avg.avg.filter;
    cfg.vol=vol;
    sourcepst=ft_sourceanalysis(cfg, avgpst);
    
    ERF_source = sourcepst;
    ERF_source.avg.pow= (sourcepst.avg.pow - sourcepre.avg.pow)./sourcepre.avg.pow;


    % plot source
    cfg              = [];
    cfg.parameter    = 'avg.pow';
    cfg.interpmethod = 'nearest';
    source_int  = ft_sourceinterpolate(cfg, ERF_source, mri);
%     source_int.mask = source_int.pow > max(source_int.pow(:)*0.5);
    source_int.mask = source_int.pow > 0.2;
    
    cfg = [];
    norm_source_int = ft_volumenormalise(cfg, source_int);
    
    
    %draw figure
    cfg               = [];
    cfg.method        = 'surface';
    cfg.funparameter  = 'pow';
    cfg.funcolormap = 'jet';
    cfg.maskparameter = 'mask';
    cfg.funcolorlim = [-0.8 0.8];
    cfg.surfdownsample = 10;
    ft_sourceplot(cfg,norm_source_int);
    
    view ([90 0]);
    left_name = strcat('figure/norm_right_',num2str(i),'_',num2str(i + 0.1),'.png');
    saveas(gcf,left_name,'png');
    
    view ([-90 0]);
    right_name = strcat('figure/norm_left_',num2str(i),'_',num2str(i + 0.1),'.png');
    saveas(gcf,right_name,'png');
    close all;
    
%     cfg               = [];
%     cfg.method        = 'slice';
%     cfg.funparameter  = 'pow';
%     cfg.funcolormap = 'jet';
%     cfg.surfdownsample = 10;
%     ft_sourceplot(cfg,norm_source_int);
%     
%     right_name = strcat('figure/slice_',num2str(i),'.png');
%     saveas(gcf,right_name,'png');
%     close all;

end