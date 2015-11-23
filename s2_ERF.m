%% redefine trials within the time range of interest
cfg = [];
cfg.toilim = [-0.1 0.6];
redefine_data = ft_redefinetrial(cfg, filting_data);

%% ERF for further ananyzing
cfg = [];
cfg.channel          = 'MEG';
cfg.covariance       = 'yes';
cfg.covariancewindow = 'all';

ERF = ft_timelockanalysis(cfg, redefine_data);

save('results.mat','-append');
