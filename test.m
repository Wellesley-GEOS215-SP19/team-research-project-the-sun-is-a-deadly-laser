rad_ttds = tabularTextDatastore('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/Global Radiation data');
rad_ttds.VariableNames = {'ID','ID_TYPE','OB_END_TIME','OB_HOUR_COUNT','VERSION_NUM','MET_DOMAIN_NAME','SRC_ID','REC_ST_IND','GLBL_IRAD_AMT','DIFU_IRAD_AMT','GLBL_IRAD_AMT_Q','DIFU_IRAD_AMT_Q','METO_STMP_TIME','MIDAS_STMP_ETIME','DIRECT_IRAD','IRAD_BAL_AMT','GLBL_S_LAT_IRAD_AMT','GLBL_HORZ_ILMN','YEAR','MONTH','LAT','LON'};
rad_ttds.TextscanFormats = {'%q','%q','%{uuuu-MM-dd HH:mm}D','%f','%f','%q','%f','%f','%f','%f','%f','%f','%f','%f','%f','%f','%q','%f','%f','%f','%f','%f'};
rad_ttds.SelectedVariableNames = {'OB_END_TIME','SRC_ID','GLBL_IRAD_AMT','LAT','LON','MONTH','YEAR'};
%%

radiation_data = read(rad_ttds);
%%
radiation_data.MONTH = month(radiation_data.OB_END_TIME);
radiation_data.YEAR = year(radiation_data.OB_END_TIME);
%%
load station_ids.mat 
station_data=cell2mat(table2cell(station_ids));

station_dat = NaN*zeros((length(unique(radiation_data.SRC_ID))),3);

for i = 1:length(station_data)
    stationindex = find(radiation_data.SRC_ID(i)==station_data(i,3));
    station_dat(stationindex,1) = station_data(stationindex,3);%station ids
    station_dat(stationindex,2) = station_data(stationindex,2);%lat
    station_dat(stationindex,3) = station_data(stationindex,1);%lon
end
%%
stat_lat = station_dat(:,2);
stat_lon = station_dat(:,3);

for i= 1:length(radiation_data.SRC_ID)
    for j= 1:length(station_dat)
           stat_index = find(station_dat(j,1)==radiation_data.SRC_ID(i));
           if ismember(station_dat(:,1),radiation_data.SRC_ID(i));
               radiation_data.LAT(i)= stat_lat(j);
               radiation_data.LON(i) = stat_lon(j);
           else
               %do nothing
           end
    end
end
%radiation_data.LAT = stat_lon
%%
%filename_rad = 'radiation_data.mat';
%m_rad = matfile(filename_rad);

save('radiation_data.mat','radiation_data');
