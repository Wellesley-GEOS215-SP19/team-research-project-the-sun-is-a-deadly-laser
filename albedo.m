%% The Sun is a Deadly Laser: A GEOS 215 Project
% Jocelyn and Leafia
%%
%Albedo maps and data
%% Read in albedo
% X, Y, T, albedo
% X = longitude in degrees east
% Y = latitude in degrees north
% T = time in months since 1960-01-01 (data from Nov 1986, Dec 1986, and
% Jan 1987)
% albedo = in percent, missing values are replaced with 999.99
lon_alb = double(ncread('albedo.nc','X'));
lat_alb = double(ncread('albedo.nc','Y'));
time_alb = double(ncread('albedo.nc','T'));
alb = double(ncread('albedo.nc','albedo'));
%%
lon_alb_new=[lon_alb;lon_alb(1)+360];
alb(145,:,:)=alb(1,:,:); %to get rid of that annoying white line
%%
%trying to replace 999.9900 with global mean albedo 
for i=1:length(time_alb)
    for j=1:length(lon_alb_new)
        for k=1:length(lat_alb)
            if alb(j,k,i)>900;
                alb(j,k,i)= NaN ;
            end
        end
    end 
end

%%
alb_mean = mean(alb,3);


figure(1); clf
worldmap world
load coastlines;
contourfm(lat_alb, lon_alb_new, alb_mean','linecolor','none');
cmocean('ice');
c = colorbar('southoutside'); 
c.Label.String = 'albedo in percent';
plotm(coastlat, coastlon, 'Color',[ 0.9100 0.4100 0.1700],'LineWidth',1);
%geoshow('landareas.shp','FaceColor','black');
title('Mean albedo between Nov 1986 and Jan 1987')
