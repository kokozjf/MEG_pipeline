%% forward model 

% reslice and align
fw_cfg = [];
raw_mri = ft_read_mri(MRI_dataset{MEG_num});
mri = ft_volumereslice(fw_cfg,raw_mri);
% mri = ft_volumerealign(fw_cfg, mri);
ft_sourceplot(fw_cfg, mri);
saveas(gcf,'figure/anatomy.png','png');
close all;

fw_cfg = [];
fw_cfg.output = {'brain','skull','scalp'};
[segmentedmri] = ft_volumesegment(fw_cfg, mri);
segmentedmri.anatomy   = mri.anatomy; 
 
fw_cfg                    = [];
fw_cfg.funparameter       = 'brain';
ft_sourceplot(fw_cfg, segmentedmri);
saveas(gcf,'figure/segment.png','png');
close all;

fw_cfg = [];
fw_cfg.method = 'singleshell';
vol = ft_prepare_headmodel(fw_cfg, segmentedmri);
vol = ft_convert_units(vol, 'cm');

% create the subject specific grid
hdr                 = ft_read_header(MEG_dataset{MEG_num});
fw_cfg                 = [];
fw_cfg.grad            = hdr.grad;
fw_cfg.vol             = vol;
fw_cfg.grid.resolution = 1;
fw_cfg.grid.unit       = 'cm';
% fw_cfg.inwardshift     = -1.5;
grid                = ft_prepare_sourcemodel(fw_cfg);


% create leadfield
hdr                  = ft_read_header(MEG_dataset{MEG_num});
fw_cfg                  = [];
fw_cfg.grad             = hdr.grad;  % gradiometer distances
fw_cfg.vol              = vol;   % volume conduction headmodel
fw_cfg.grid             = grid;  % normalized grid positions
fw_cfg.channel          = {'MEG'};
fw_cfg.normalize        = 'yes'; % to remove depth bias (Q in eq. 27 of van Veen et al, 1997)
lf                   = ft_prepare_leadfield(fw_cfg);

save('forward_model.mat','lf','vol','mri');