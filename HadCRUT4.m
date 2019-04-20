%% HadCRUT4 Surface Temperature and SST dataset
%Read in the data: (all .nc files)
anomaly = double(ncread('HadCRUT.4.6.0.0.median.nc', 'temperature_anomaly'));
lat_ano = double(ncread('HadCRUT.4.6.0.0.median.nc', 'latitude'));
lon_ano = double(ncread('HadCRUT.4.6.0.0.median.nc', 'longitude'));
time_ano = double(ncread('HadCRUT.4.6.0.0.median.nc', 'time'));

absolute = double(ncread('absolute.nc', 'tem')) + 273.15;
lat_abs = double(ncread('absolute.nc', 'lat'));
lon_abs = double(ncread('absolute.nc', 'lon'));
time_abs = double(ncread('absolute.nc', 'time'));

%calculate the mean of the absolute values:
meanabs = mean(absolute, 3);

%add the anomalies to the mean to get the observed temperatures
obs = meanabs + anomaly;
%% plot the mean of the absolute values
figure(1); clf
worldmap world
load coastlines;
contourfm(lat_abs, lon_abs, meanabs','linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [K]';
plotm(coastlat, coastlon, 'Color','black');
title('Mean Temperature from 1961 to 1990');

%% plot the observed values
figure(2); clf
worldmap world
load coastlines;
contourfm(lat_ano, lon_ano, obs(:,:,2030)','linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [K]';
plotm(coastlat, coastlon, 'Color','black');
title('Present-Day Observed Temperatures');
