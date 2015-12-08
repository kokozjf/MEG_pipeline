
%% combine planar
cfg                 = [];
cfg.feedback        = 'yes';
cfg.method          = 'template';
cfg.neighbours      = ft_prepare_neighbours(cfg, redefine_data);

cfg.planarmethod    = 'sincos';
rawdata_planar      = ft_megplanar(cfg, redefine_data);

cfg                 = [];
planar_comb         = ft_combineplanar(cfg, rawdata_planar);

cfg                 = [];
cfg.demean          = 'yes';
ERF_planar          = ft_timelockanalysis(cfg, planar_comb);

%% multiplotER planar
cfg = [];
cfg.showoutline = 'yes';
cfg.layout = 'CTF275.lay';
cfg.marker = 'off';
cfg.vlim = 'maxabs';
ft_multiplotER(cfg,ERF_planar);
saveas(gcf,'figure/multiplotER_planar.png');
close all;

%% databrowser
cfg = [];
cfg.viewmode = 'butterfly';
cfg.colorgroups = 'allblack';
ft_databrowser(cfg, ERF_planar);
saveas(gcf,'figure/databrowser_planar.png');
close all;

%% topoplotER
cfg = [];
cfg.layout = 'CTF275.lay';
% cfg.xlim = [-0.1:0.1:1.4]; %aef
cfg.xlim = [-0.1:0.1:0.8]; %vef
% cfg.zlim = [-5*1e-14 5*1e-14];
cfg.colorbar = 'yes';
cfg.marker = 'off';
cfg.comment = 'xlim';
cfg.commentpos = 'lefttop';
ft_topoplotER(cfg,ERF_planar);
saveas(gcf,'figure/topoplotER_planar.png');
close all;