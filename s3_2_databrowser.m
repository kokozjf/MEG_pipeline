%% databrowser
cfg = [];
cfg.viewmode = 'butterfly';
cfg.colorgroups = 'allblack';
ft_databrowser(cfg, ERF);
saveas(gcf,'figure/databrowser.png');
close all;