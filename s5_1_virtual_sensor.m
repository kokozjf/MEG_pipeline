spatialfilter=cat(1,source_avg.avg.filter{:});
virtsens=[];
virtsens.avg = spatialfilter * ERF.avg;
virtsens.time=ERF.time;
virtsens.inside = source_avg.inside;
virtsens.pos = source_avg.pos(virtsens.inside,:);
