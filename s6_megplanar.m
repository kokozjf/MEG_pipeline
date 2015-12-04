% %% redefine trials within the time range of interest
% cfg = [];
% % cfg.toilim = [-0.1 1.4]; %aef
% cfg.toilim = [-0.1 0.8]; %aef
% redefine_data = ft_redefinetrial(cfg, filting_data);
% 
% %% ERF for further ananyzing
% cfg = [];
% cfg.channel          = 'MEG';
% cfg.covariance       = 'yes';
% cfg.covariancewindow = 'all';
% 
% ERF = ft_timelockanalysis(cfg, redefine_data);
% 
% % save('results.mat','ERF','-append');



cfg                 = [];
cfg.method          = 'template';
cfg.template        = 'CTF275_neighb.mat';
neighbours          = ft_prepare_neighbours(cfg, redefine_data);

cfg                 = [];
cfg.method          = 'sincos';
cfg.neighbours      = neighbours;
data_planar         = ft_megplanar(cfg, redefine_data);

cfg                 = [];
cfg.channel         = 'MEG';
cfg.vartrllength    = 1;
tl_planar           = ft_timelockanalysis(cfg, data_planar);

cfg                 = [];
tl_plancmb          = ft_combineplanar(cfg, tl_planar);

% cfg                 = [];
% cfg.showlabels      = 'yes';
% cfg.showoutline     = 'yes';
% cfg.layout          = 'CTF275.lay';
% ft_multiplotER(cfg, tl_plancmb);

%% topoplotER
cfg = [];
cfg.layout = 'CTF275.lay';
cfg.xlim = [-0.1:0.1:1.4]; %aef
% cfg.xlim = [-0.1:0.1:0.8]; %vef
cfg.zlim = [0 8*1e-14];
cfg.colorbar = 'yes';
cfg.marker = 'off';
cfg.comment = 'xlim';
cfg.commentpos = 'lefttop';
ft_topoplotER(cfg,tl_plancmb);
saveas(gcf,'figure/topoplotER_step01_planar.png');
close all;