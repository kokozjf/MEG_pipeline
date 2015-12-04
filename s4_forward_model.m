%% forward model 

% reslice and align
cfg = [];
raw_mri = ft_read_mri(MRI_dataset{MEG_num});
mri = ft_volumereslice(cfg,raw_mri);
% mri = ft_volumerealign(fw_cfg, mri);
ft_sourceplot(cfg, mri);
saveas(gcf,'figure/anatomy.png','png');
close all;

cfg = [];
cfg.output = {'brain','skull','scalp'};
[segmentedmri] = ft_volumesegment(cfg, mri);
segmentedmri.anatomy   = mri.anatomy; 
 
cfg                    = [];
cfg.funparameter       = 'brain';
ft_sourceplot(cfg, segmentedmri);
saveas(gcf,'figure/segment.png','png');
close all;

cfg = [];
cfg.method = 'singleshell';
vol = ft_prepare_headmodel(cfg, segmentedmri);
vol = ft_convert_units(vol, 'cm');

% create the subject specific grid
hdr                 = ft_read_header(MEG_dataset{MEG_num});
cfg                 = [];
cfg.grad            = hdr.grad;
cfg.vol             = vol;
cfg.grid.resolution = 1;
cfg.grid.unit       = 'cm';
% fw_cfg.inwardshift     = -1.5;
grid                = ft_prepare_sourcemodel(cfg);


% create leadfield
hdr                  = ft_read_header(MEG_dataset{MEG_num});
cfg                  = [];
cfg.grad             = hdr.grad;  % gradiometer distances
cfg.vol              = vol;   % volume conduction headmodel
cfg.grid             = grid;  % normalized grid positions
cfg.channel          = {'MEG'};
cfg.normalize        = 'yes'; % to remove depth bias (Q in eq. 27 of van Veen et al, 1997)
lf                   = ft_prepare_leadfield(cfg);

% save('forward_model.mat','lf','vol','mri');