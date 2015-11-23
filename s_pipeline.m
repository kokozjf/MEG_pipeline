clear all;
MEG_dataset = importdata('D:\MEG\pipeline\MEG_pipeline\MEG_path.txt');
MRI_dataset = importdata('D:\MEG\pipeline\MEG_pipeline\MRI_path.txt');
trigger_value = [3 10];
addpath('D:\MEG\pipeline\MEG_pipeline\');

for MEG_num = 1:length(MEG_dataset)
    cd(MEG_dataset{MEG_num});
%     
%     header = ft_read_header(MEG_dataset{MEG_num});
%     header.orig.infods(5)
    
    
    mkdir('figure');
    s1_preprocessing;
    s2_ERF;
    s3_1_multiplotER;
    s3_2_databrowser;
    s3_3_topoplotER;
    s4_forward_model;
    s5_inverse_model;
end