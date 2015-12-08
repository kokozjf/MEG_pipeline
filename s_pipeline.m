clear all;
MEG_dataset = '/media/jianfeng/data/MEG/aud_vis_test/data/aud_2015_10_30/VEP001_HuanLuoPKU_20151030_04.ds';
MRI_dataset = '/media/jianfeng/data/MEG/aud_vis_test/data/zhangjianfeng.mri';
trigger_value = 10;
addpath('/media/jianfeng/data/MEG/pipeline/MEG_pipeline');

% for MEG_num = 1:length(MEG_dataset)
    MEG_num = 1;
    cd(MEG_dataset);
%     
%     header = ft_read_header(MEG_dataset);
%     header.orig.infods(5)
    
    
    mkdir('figure');
    s1_preprocessing;
    s2_ERF;
    s3_1_multiplotER;
    s3_2_databrowser;
    s3_3_topoplotER;
    s4_forward_model;
    s5_inverse_model;
% end