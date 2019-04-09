%% The Sun is a Deadly Laser: A GEOS 215 Project
% Jocelyn and Leafia
%%
%MIDAS dataset from hell

%% Read in global radiation data from MIDAS

%observed years (1947 - 2019)
obs_years = NaN*zeros(72,1); 
for i=1:length(obs_years)
    obs_years(i) = 1946 + (i);
end

%%
%load in station ids
load station_ids.mat

station_data=cell2mat(table2cell(station_ids));
%%
load radiation_data.mat

%rad_data = table2cell(radiation_data);
%%
station_grid = unique(radiation_data.SRC_ID);
month_grid = unique(month(radiation_data.OB_END_TIME));
stations = NaN*zeros((length(station_grid)),3);
%%
for i = 1:length(station_data)
    stationIDindex = find(station_grid==station_data(i,3));
    stations(stationIDindex,1) = station_data(stationIDindex,3);%station ids
    stations(stationIDindex,2) = station_data(stationIDindex,2);%lat
    stations(stationIDindex,3) = station_data(stationIDindex,1);%lon
end

stat_lat = stations(:,2);
stat_lon = stations(:,3);
%%

%%

global_rad = NaN*zeros(length(stations(:,1)),length(stations(:,2)),length(month_grid));

for i= 1:length(radiation_data.SRC_ID)
           stat_index = find(stations(i,1)==radiation_data.SRC_ID(i));
           if stations(i,1)==radiation_data.SRC_ID(i);
               radiation_data.LAT(i)= stations(i,2);
               radiation_data.LON(i) = stations(i,3);
           else
               %do nothing
           end
           global_rad(lonindex,latindex,)=CO2data.PCO2_SW(i);
end%<--
           %global_rad(,latindex,CO2data.MONTH(i))=CO2data.PCO2_SW(i);
           %SST(lonindex,latindex,CO2data.MONTH(i))=CO2data.SST(i);
end%<--