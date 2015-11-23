%% find trigger, run it separately
clear all

trigger_cfg = [];
trigger_cfg.dataset = 'D:\MEG\aud_vis_test\data\aud_2015_10_30\VEP001_HuanLuoPKU_20151030_04.ds'; 
trigger_cfg.trialdef.eventtype = '?';
ft_definetrial(trigger_cfg);