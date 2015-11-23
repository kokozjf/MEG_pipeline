%% topoplotER
plot_cfg = [];
plot_cfg.layout = 'CTF275.lay';
plot_cfg.xlim = [-0.1:0.05:0.5];
plot_cfg.colorbar = 'yes';
plot_cfg.marker = 'off';
plot_cfg.comment = 'xlim';
plot_cfg.commentpos = 'lefttop';
ft_topoplotER(plot_cfg,ERF);
saveas(gcf,'figure/topoplotER.png');
close all;