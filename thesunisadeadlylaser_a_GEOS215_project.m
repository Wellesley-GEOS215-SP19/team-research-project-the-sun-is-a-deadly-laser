%% The Sun is a Deadly Laser: A GEOS 215 Project
% Jocelyn and Leafia


%% Read in geotiff files from Global Solar Atlas
[GHI] = geotiffread('GHI.tif');
TEMP_file = geotiffread('TEMP.tif');

figure
mapshow(GHI);

%% Read in temp data from GISS data

GISS_temp = readtable('GISS_temp.csv');

%% Read in albedo
% X, Y, T, albedo
% X = longitude in degrees east
% Y = latitude in degrees north
% T = time in months since 1960-01-01 (data from Nov 1986, Dec 1986, and
% Jan 1987)
% albedo = in percent, missing values are replaced with 999.99
lon_alb = ncread('albedo.nc','X');
lat_alb = nc('albedo.nc','Y');
time_alb = double(ncread('albedo.nc','T'));
alb = double(ncread('albedo.nc','albedo'));

figure(1); clf
worldmap world
contourfm(lat_alb, lon_alb, alb(:,:,1)','linecolor','none');
c = colorbar('southoutside'); 
c.Label.String = 'albedo';
geoshow('landareas.shp','FaceColor','black');
title('albedo')