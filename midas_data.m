%% The Sun is a Deadly Laser: A GEOS 215 Project
% Jocelyn and Leafia
%%
%MIDAS dataset from hell

%% Read in global radiation data from MIDAS
load radiation_data.mat

%rad_data = table2cell(radiation_data); %I had to do this to make the
%station data work when I was making the stations array but when I ran this
%it took so long because the dataset was so large
%%
%load in station ids
load station_ids.mat

station_data=cell2mat(table2cell(station_ids));
%%
station_grid = unique(radiation_data.SRC_ID); %all the unique station in radiation_data
month_grid = unique(month(radiation_data.OB_END_TIME));
year_grid = unique(year(radiation_data.OB_END_TIME)); 
%%
stations = NaN*zeros((length(station_grid)),3);
%3 columns, one for src_id, lat, and lon
%%
%making an array with all the lats and lons of the unique stations in radiaion data
for i = 1:length(station_data) 
    stationIDindex = find(station_grid==station_data(i,3));
    stations(stationIDindex,1) = station_data(stationIDindex,3);%station ids
    stations(stationIDindex,2) = station_data(stationIDindex,2);%lat
    stations(stationIDindex,3) = station_data(stationIDindex,1);%lon
end

stat_lat = stations(:,2); %one column array with just lats
stat_lon = stations(:,3); %one column array with just lons
%%
global_rad = NaN*zeros(length(stations(:,1)),length(stations(:,2)),length(month_grid));

%%

%for each row in radiation_data, search through all of the rows in
%stations to find the one that matches the one in the SRC_ID field of
%radiation_data and append the lat and lon to that row of radiation_data
for i= 1:length(radiation_data.SRC_ID)
           stat_index = find(station_data(:,3)==radiation_data.SRC_ID(i));
           %if station_data(:,3)==radiation_data.SRC_ID(i); 
           radiation_data.LAT(i)= station_data(stat_index,2);
           radiation_data.LON(i) = station_data(stat_index,1);
           %else
               %do nothing
           %end
           %global_rad(lonindex,latindex,)=CO2data.PCO2_SW(i);
end %<--
           %global_rad(,latindex,CO2data.MONTH(i))=CO2data.PCO2_SW(i);
           %SST(lonindex,latindex,CO2data.MONTH(i))=CO2data.SST(i);
           
%also tried the following which also didn't work
%for i= 1:length(radiation_data.SRC_ID)
 %   for j= 1:length(station_dat)
  %         stat_index = find(stations(j,1)==radiation_data.SRC_ID(i));
   %        if ismember(stations(:,1),radiation_data.SRC_ID(i));
    %           radiation_data.LAT(i)= stat_lat;
     %          radiation_data.LON(i) = stat_lon;
      %     else
       %        %do nothing
        %   end
    %end
%end

%after the lat, lon, src_id, ob_start_data, glbl_irad_amt, month, and year
%have been added together into one large array I think I need to do something 
%similar to what we did in the CO2 lab and make a 3d array? I also need to 
%average the months and then I guess the years?

%monthly averages
%save lat and lon addition until later
%make a second .mat file to average each month for each station
%constrained set of data