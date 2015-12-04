%% topoplotER
cfg = [];
cfg.layout = 'CTF275.lay';
% cfg.xlim = [-0.1:0.1:1.4]; %aef
cfg.xlim = [-0.1:0.1:0.8]; %vef
cfg.zlim = [-5*1e-14 5*1e-14];
cfg.colorbar = 'yes';
cfg.marker = 'off';
cfg.comment = 'xlim';
cfg.commentpos = 'lefttop';
ft_topoplotER(cfg,ERF);
saveas(gcf,'figure/topoplotER_step01_noscaleing.png');
close all;