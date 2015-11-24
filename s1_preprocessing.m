%% preprocessing cfg
% define trials
cfg = [];
cfg.dataset = MEG_dataset{MEG_num}; 
cfg.trialdef.eventtype = 'frontpanel trigger';
cfg.trialdef.eventvalue = trigger_value(MEG_num);
cfg.trialdef.prestim    = 1;
cfg.trialdef.poststim   = 2; 
cfg.channel = 'meg';
cfg = ft_definetrial(cfg);
raw_data = ft_preprocessing(cfg);

% bandpass filter
cfg = [];
cfg.preproc.demean = 'yes';
cfg.bpfilter = 'yes';
cfg.bpfreq = [1 35]; 
filting_data = ft_preprocessing(cfg,raw_data);
raw_ERF = ft_timelockanalysis(cfg, filting_data);

% check edge artifacts
plot_cfg = [];
plot_cfg.viewmode = 'butterfly';
plot_cfg.colorgroups = 'allblack';
ft_databrowser(plot_cfg, raw_ERF);
saveas(gcf,'figure/edge_artifacts_check.png');
close all;


save('results.mat');