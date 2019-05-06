%The Sun is a Deadly Laser: A GEOS 215 Project
%Jocelyn and Leafia
%% Read in data for the most recent year for each month
% Read the names of nc-files in the folder 
ncfiles = dir('/Users/jocelynreahl/Documents/GitHub/team-research-project-the-sun-is-a-deadly-laser/ORD32943/*.nc');
Oct2013 = ncfiles(length(ncfiles)-15).name;
Nov2013 = ncfiles(length(ncfiles)-14).name;
Dec2013 = ncfiles(length(ncfiles)-13).name;
Feb2014 = ncfiles(length(ncfiles)-11).name;
May2014 = ncfiles(length(ncfiles)-10).name;
Jan2015 = ncfiles(length(ncfiles)-6).name;
Mar2015 = ncfiles(length(ncfiles)-5).name;
Apr2015 = ncfiles(length(ncfiles)-4).name;
Jun2015 = ncfiles(length(ncfiles)-3).name;
Jul2015 = ncfiles(length(ncfiles)-2).name;
Aug2015 = ncfiles(length(ncfiles)-1).name;
Sep2015 = ncfiles(length(ncfiles)).name;

%% July 2015 (Northern Hemisphere Summer) Solar Irradiation
latJul = ncread(Jul2015,'lat');
lonJul = ncread(Jul2015,'lon');
SISJul = ncread(Jul2015,'SIS');
SISCLSJul = ncread(Jul2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

figure(1); clf
worldmap world
load coastlines;
contourfm(latJul, lonJul, SISCLSJul(:,:)','linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}July 2015');

%% October (Northern Hemisphere Fall) Solar irradiation
latOct = ncread(Oct2013,'lat');
lonOct= ncread(Oct2013,'lon');
SISOct = ncread(Oct2013,'SIS');
SISCLSOct = ncread(Oct2013,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

figure(2); clf
worldmap world
contourfm(latOct, lonOct, SISCLSOct(:,:)','linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}October 2013')

%% January 2015 (Northern Hemisphere Winter) Solar Irradiation
latJan = ncread(Jan2015,'lat');
lonJan = ncread(Jan2015,'lon');
SISJan = ncread(Jan2015,'SIS');
SISCLSJan = ncread(Jan2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

figure(3); clf
worldmap world
contourfm(latJan, lonJan, SISCLSJan(:,:)','linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}January 2015')

%% April 2015 (Northern Hemisphere Spring) Solar Irradiation
latApr = ncread(Apr2015,'lat');
lonApr= ncread(Apr2015,'lon');
SISApr = ncread(Apr2015,'SIS');
SISCLSApr = ncread(Apr2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

figure(4); clf
worldmap world
contourfm(latApr, lonApr, SISCLSApr(:,:)','linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}April 2015')

%% Attempt to Create a Pretty Subplot
%Was having trouble getting all four subplots to have the same colorbar
%w/the same scale
figure(5); clf
%load coastlines;
% Minimum and maximum values of the two plots
% This is useful in setting the limits of the colorbar
bottomJulOct = min(min(min(SISCLSJul(:,:))), min(min(SISCLSOct(:,:))));
bottomJanApr = min(min(min(SISCLSJan(:,:))), min(min(SISCLSApr(:,:))));
topJulOct = max(max(max(SISCLSJul(:,:))), max(max(SISCLSOct(:,:))));
topJanApr = max(max(max(SISCLSJan(:,:))), max(max(SISCLSApr(:,:))));
bottom = min(min(bottomJulOct), min(bottomJanApr));
top = max(max(bottomJulOct), max(bottomJanApr));

subplot(2,2,1);
worldmap world
load coastlines;
contourfm(latJul, lonJul, SISCLSJul(:,:)','linecolor','none');
cmocean('thermal');
c1 = caxis;
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}July 2015');

subplot(2,2,2);
worldmap world
contourfm(latOct, lonOct, SISCLSOct(:,:)','linecolor','none');
cmocean('thermal');
c2 = caxis;
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}October 2013');

subplot(2,2,3);
worldmap world
contourfm(latJan, lonJan, SISCLSJan(:,:)','linecolor','none');
cmocean('thermal');
c3 = caxis;
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}January 2015');

subplot(2,2,4);
worldmap world
contourfm(latApr, lonApr, SISCLSApr(:,:)','linecolor','none');
cmocean('thermal');
c4 = caxis;
c5 = caxis([bottom top]);
caxis(c5)
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('\fontsize{16}April 2015');

%%
% Create a common meshgrid for two plots having different z values
[x,y]=meshgrid(-1:0.05:1, -1:0.05:1);
% Two different z-data plots for the same x and y data points
z1=sin(x.^2+y.^2);
z2=cos(x+y);
% Minimum and maximum values of the two plots
% This is useful in setting the limits of the colorbar
bottom = min(min(min(z1)),min(min(z2)));
top  = max(max(max(z1)),max(max(z2)));
% Plotting the first plot
subplot(1,2,1)
h1=surf(x,y,z1);
shading interp;
% This sets the limits of the colorbar to manual for the first plot
caxis manual
caxis([bottom top]);
% Plotting the second plot
subplot(1,2,2)
h2=surf(x,y,z2);
shading interp;
% This sets the limits of the colorbar to manual for the second plot
caxis manual
caxis([bottom top]);
colorbar;
% Read the names of nc-files in the folder 
% Loop for each nc-file


%for i = 1:Nfiles
    % display the nc file 
    %SIS = ncread(ncfiles(i).name,'SIS');
    %ncdisp((ncfiles(i).name));   % call the nc file by ncfiles(i).name
    % do what you want %
    %ncid = netcdf.open(ncfiles(i).name);
    %netcdf.inq(ncid)
    %varnames = netcdf.inqVar(ncid,:);
    %varid = netcdf.inqVarID(ncid,varname);
    %data(i) = netcdf.getVar(ncid,varid);
%end

