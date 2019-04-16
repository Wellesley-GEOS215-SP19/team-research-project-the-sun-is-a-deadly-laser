%The Sun is a Deadly Laser: A GEOS 215 Project
%Jocelyn and Leafia

%Working on averaging everything first
%%
%load radiation_data.mat
%avgd_rad_ttds = tabularTextDatastore('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/team-research-project-the-sun-is-a-deadly-laser/MIDAS Global Solar Data');
avgd_rad_ttds = tabularTextDatastore('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/team-research-project-the-sun-is-a-deadly-laser/MIDAS Global Solar Data/midas_radtob_201801-201812.txt');
avgd_rad_ttds.VariableNames = {'ID','ID_TYPE','OB_END_TIME','OB_HOUR_COUNT','VERSION_NUM','MET_DOMAIN_NAME','SRC_ID','REC_ST_IND','GLBL_IRAD_AMT','DIFU_IRAD_AMT','GLBL_IRAD_AMT_Q','DIFU_IRAD_AMT_Q','METO_STMP_TIME','MIDAS_STMP_ETIME','DIRECT_IRAD','IRAD_BAL_AMT','GLBL_S_LAT_IRAD_AMT','GLBL_HORZ_ILMN','YEAR','MONTH','LAT','LON'};%,DIRECT_IRAD_Q, IRAD_BAL_AMT_Q, GLBL_S_LAT_IRAD_AMT_Q, GLBL_HORZ_ILMN_Q 
avgd_rad_ttds.TextscanFormats = {'%q','%q','%{uuuu-MM-dd HH:mm}D','%f','%f','%q','%f','%f','%f','%f','%f','%f','%f','%f','%f','%f','%q','%f','%f','%f','%f','%f'};
avgd_rad_ttds.SelectedVariableNames = {'OB_END_TIME','SRC_ID','GLBL_IRAD_AMT','LAT','LON','MONTH','YEAR'};
avgd_rad_ttds.ReadSize = 'file';

%avgd_radiation_data = readall(avgd_rad_ttds); %this takes forever
avgd_radiation_data = read(avgd_rad_ttds); %this only reads a bit of the entire set

avgd_radiation_data.MONTH = month(avgd_radiation_data.OB_END_TIME);
avgd_radiation_data.YEAR = year(avgd_radiation_data.OB_END_TIME);
%%
load station_ids.mat

station_data=cell2mat(table2cell(station_ids));
%%

%for i= 1:length(avgd_radiation_data.SRC_ID)
 %          stat_index = find(station_data(:,3)==avgd_radiation_data.SRC_ID(i));
  %         avgd_radiation_data.LAT(i)= station_data(stat_index,2);
   %        avgd_radiation_data.LON(i) = station_data(stat_index,1);
%end

%%

%save('avgd_radiation_data.mat','avgd_radiation_data');
%%

station_grid = unique(avgd_radiation_data.SRC_ID); %all the unique station in radiation_data
month_grid = unique(avgd_radiation_data.MONTH);
%year_grid = unique(avgd_radiation_data.YEAR);

%%
%for i=1:length(avgd_radiation_data.SRC_ID)
%    for j=1:length(station_grid)
%                stat_index = find(station_data(:,3)==avgd_radiation_data.SRC_ID(i));
%                avgd_radiation_data.LAT= station_data(stat_index,2);
%                avgd_radiation_data.LON=station_data(stat_index,1);
%    end
%end

%%
%monthly_radiation_data = NaN*zeros(length(station_grid),(2+length(month_grid)),length(year_grid));
%%
month_rad_data = NaN*zeros(length(station_grid),length(month_grid)+3);

%%
for j=1:length(station_grid)
    for k=1:length(month_grid)
        stat_index = find(station_data(:,3)==station_grid(j));
        if length(stat_index)>0
        month_rad_data(j,1)= station_data(stat_index,3); %src_id
        month_rad_data(j,2)= station_data(stat_index,2); %lat
        month_rad_data(j,3)= station_data(stat_index,1); %lon
        mont_avg_idx = find(avgd_radiation_data.MONTH == k+3);
        stat_idx = find(avgd_radiation_data.SRC_ID == station_grid(j));
        joined_idx = intersect(mont_avg_idx,stat_idx);
        month_rad_data(j,k+3) = mean(avgd_radiation_data.GLBL_IRAD_AMT(joined_idx));
        end
    end
end
%%
mean_data = array2table(month_rad_data);
mean_data.Properties.VariableNames = {'SRC_ID','LAT','LON','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'};

%%
figure(3); clf;
plot(month_rad_data(1,4:end));
%%
figure(4); clf;
imagesc(month_rad_data(:,4:end));
%%
figure(2); clf;
worldmap 'United Kingdom'
load coastlines;
contourfm(month_rad_data(:,2),month_rad_data(:,3), mean_data.Jan,'linecolor','none');
cmocean('ice');
c = colorbar('southoutside'); 
c.Label.String = 'kjoules/m^2';
plotm(coastlat, coastlon, 'Color',[ 0.9100 0.4100 0.1700],'LineWidth',1);
%geoshow('landareas.shp','FaceColor','black');
title('Mean global solar irradiation amount Jan 1994')
%%
figure(1); clf
worldmap('United Kingdom')
load coastlines
plotm(coastlat,coastlon)
plotm(mean_data.LAT,mean_data.LON, mean_data.Jan,'m.','markersize',15)
title('Locations of stations with observational irradiation data')
hold off


