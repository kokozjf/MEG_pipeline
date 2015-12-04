%% multiplotER
cfg = [];
cfg.showoutline = 'yes';
cfg.layout = 'CTF275.lay';
cfg.marker = 'off';
cfg.vlim = 'maxabs';
ft_multiplotER(cfg,ERF);
saveas(gcf,'figure/multiplotER.png');
close all;