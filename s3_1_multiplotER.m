%% multiplotER
plot_cfg = [];
plot_cfg.showoutline = 'yes';
plot_cfg.layout = 'CTF275.lay';
plot_cfg.marker = 'off';
plot_cfg.vlim = 'maxabs';
ft_multiplotER(plot_cfg,ERF);
saveas(gcf,'figure/multiplotER.png');
close all;