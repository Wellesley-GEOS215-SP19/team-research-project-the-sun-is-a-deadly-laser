%% Read in Relevant Data and Set Constants: HadCRUT4 Temperature Data
anomaly = double(ncread('HadCRUT.4.6.0.0.median.nc', 'temperature_anomaly'));
lat_ano = double(ncread('HadCRUT.4.6.0.0.median.nc', 'latitude'));
lon_ano = double(ncread('HadCRUT.4.6.0.0.median.nc', 'longitude'));
time_ano = double(ncread('HadCRUT.4.6.0.0.median.nc', 'time'));

absolute = double(ncread('absolute.nc', 'tem')) + 273.15; %convert from Celsius to Kelvin
lat_abs = double(ncread('absolute.nc', 'lat'));
lon_abs = double(ncread('absolute.nc', 'lon'));
time_abs = double(ncread('absolute.nc', 'time'));

%calculate the mean of the absolute values:
meanabs = mean(absolute, 3);

%add the anomalies to the mean to get the observed temperatures
obs = meanabs + anomaly;
%% Read in Relevant Data and Set Constants: ERBE Albedo
lon_alb = double(ncread('albedo.nc','X'));
lat_alb = double(ncread('albedo.nc','Y'));
time_alb = double(ncread('albedo.nc','T'));
alb = double(ncread('albedo.nc','albedo'));

%Make the data pretty (i.e. get rid of the white line!)
lon_alb_new=[lon_alb;lon_alb(1)+360];
alb(145,:,:)=alb(1,:,:); %to get rid of that annoying white line

%Replace missing values (999.9900) with NaN values 
for i=1:length(time_alb)
    for j=1:length(lon_alb_new)
        for k=1:length(lat_alb)
            if alb(j,k,i)>900
                alb(j,k,i)= NaN;
            end
        end
    end 
end

%Compute the mean albedo over the whole timeseries (November 1986 - January
%1987)
alb_mean = mean(alb,3);

%% Read in Relevant Data and Set Constants: Solar Irradiance from CLARA
% Read the names of nc-files in the folder 
ncfiles = dir('/Users/jocelynreahl/Documents/GitHub/team-research-project-the-sun-is-a-deadly-laser/ORD32943/*.nc');
Oct2013 = ncfiles(length(ncfiles)-15).name;
%Nov2013 = ncfiles(length(ncfiles)-14).name;
%Dec2013 = ncfiles(length(ncfiles)-13).name;
%Feb2014 = ncfiles(length(ncfiles)-11).name;
%May2014 = ncfiles(length(ncfiles)-10).name;
Jan2015 = ncfiles(length(ncfiles)-6).name;
%Mar2015 = ncfiles(length(ncfiles)-5).name;
Apr2015 = ncfiles(length(ncfiles)-4).name;
%Jun2015 = ncfiles(length(ncfiles)-3).name;
Jul2015 = ncfiles(length(ncfiles)-2).name;
Aug2015 = ncfiles(length(ncfiles)-1).name;
%Sep2015 = ncfiles(length(ncfiles)).name;

% Define a pretty new function to convert longitudes to 0-360 instead of
% -180 to +180:

% July 2015 (Northern Hemisphere Summer) Solar Irradiation
latJul = ncread(Jul2015,'lat');
lonJul = ncread(Jul2015,'lon');
SISJul = ncread(Jul2015,'SIS');
SISCLSJul = ncread(Jul2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

% October (Northern Hemisphere Fall) Solar irradiation
latOct = ncread(Oct2013,'lat');
lonOct= ncread(Oct2013,'lon');
SISOct = ncread(Oct2013,'SIS');
SISCLSOct = ncread(Oct2013,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

% January 2015 (Northern Hemisphere Winter) Solar Irradiation
latJan = ncread(Jan2015,'lat');
lonJan = ncread(Jan2015,'lon');
SISJan = ncread(Jan2015,'SIS');
SISCLSJan = ncread(Jan2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

% April 2015 (Northern Hemisphere Spring) Solar Irradiation
latApr = ncread(Apr2015,'lat');
lonApr= ncread(Apr2015,'lon');
SISApr = ncread(Apr2015,'SIS');
SISCLSApr = ncread(Apr2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

%Convert longitude from -180 to +180 to 0 to 360; these longitudes are the
%same for all CLARA data
for i = 1:length(lonJul)
    if lonJul(i) >= 0
        lonJul(i)= lonJul(i);
    else
        lonJul(i) = lonJul(i) + 360;
    end
end

for i=1:length(latJul)
    for j=1:length(lonJul)
        if SISCLSJul(j,i) == 0
            SISCLSJul(j,i)= NaN;
        end
        if SISCLSOct(j,i) == 0
            SISCLSOct(j,i) = NaN;
        end
        if SISCLSJan(j,i) == 0
            SISCLSJan(j,i) = NaN;
        end
        if SISCLSApr(j,i) == 0
            SISCLSApr(j,i) = NaN;
        end
    end
end
%% Read in Relevant Data and Set Constants: Constants
r_s = 695.508e6; %Radius of the Sun [m]; Brown and Christensen-Dalsgaard, 1998
R_p = 149.597e9; %Earth-Sun Distance (1 Au) [m]; IAU, 2012
sigma = 5.67e-8; %Stefan-Boltzmann Constant [W*m^-2*K^-4]; Blevin and Brown, 1971
r_p = 6.3781e6;  %Radius of the Earth [m];Mamajek et al., 2015
T_s = 5772;      %Temperature of the Sun [K]; Williams, 2013

%% Calculate new values from constants
q_s_prime = sigma*T_s^4*(r_s/R_p)^2;
q_in = (q_s_prime*(1-(alb_mean/100)))/4;
T_skin = (((q_s_prime*(1-(alb_mean/100)))/(4*sigma))).^(1/4);
T_modeled = T_skin*2^(1/4);

%% Plot T_modeled
figure(1); clf
worldmap world
load coastlines;
contourfm(lat_alb, lon_alb_new, T_modeled'-273.15,'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Modeled Temperatures');

% HadCRUT4
figure(2); clf
worldmap world;
contourfm(lat_abs, lon_abs, obs(:,:,2030)'-273.15, 'linecolor', 'none');
cmocean('thermal');
c = colorbar('southoutside');
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color', 'black');
title('Observed Temperatures');
%% Compare w/T_observed
for i = 1:length(lon_abs)
    if lon_abs(i) >= 0
        lon_abs(i)= lon_abs(i);
    else
        lon_abs(i) = lon_abs(i) + 360;
    end
end
%% Restructure data to work with each other (i.e. a 5°x5° grid)
% Restructure Constant-Solar irradiance T modeled (T_modeled) to work with
% HadCRUT4 dataset
[lat_new,lon_new] = meshgrid(lat_abs, lon_abs); % New size of data 
                                                % (modeled off of the sizing for HadCRUT4)
                                                
[lat_grid, lon_grid] = meshgrid(lat_alb, lon_alb_new); % Old size of data
T_modeled_new = griddata(lat_grid(:), lon_grid(:), T_modeled(:), lat_new, lon_new); %New Size of data!

%Restructure Albedo ERBE data
[lat_AlbOld, lon_AlbOld] = meshgrid(lat_alb, lon_alb_new);
Restruct_Alb = griddata(lat_AlbOld(:), lon_AlbOld(:), alb_mean(:), lat_new, lon_new);

%Restructure July CLARA-A2 data
[lat_CLARAOld, lon_CLARAOld] = meshgrid(latJul, lonJul);%It's the same for all CLARA data
Restruct_Jul = griddata(lat_CLARAOld(:), lon_CLARAOld(:), SISCLSJul(:), lat_new, lon_new);

%Restructure October CLARA-A2 data
Restruct_Oct = griddata(lat_CLARAOld(:), lon_CLARAOld(:), SISCLSOct(:), lat_new, lon_new);

%Restructure January CLARA-A2 data
Restruct_Jan = griddata(lat_CLARAOld(:), lon_CLARAOld(:), SISCLSJan(:), lat_new, lon_new);

%Restructure April CLARA-A2 data
Restruct_Apr = griddata(lat_CLARAOld(:), lon_CLARAOld(:), SISCLSApr(:), lat_new, lon_new);

%% Calculate T_SLGCM from CLARA and ERBE datasets
T_SLGCMJul = (2^(1/4)).*(((1-(Restruct_Alb/100)).*Restruct_Jul)/sigma).^(1/4);
T_SLGCMOct = (2^(1/4)).*(((1-(Restruct_Alb/100)).*Restruct_Oct)/sigma).^(1/4);
T_SLGCMJan = (2^(1/4)).*(((1-(Restruct_Alb/100)).*Restruct_Jan)/sigma).^(1/4);
T_SLGCMApr = (2^(1/4)).*(((1-(Restruct_Alb/100)).*Restruct_Apr)/sigma).^(1/4);

figure(3); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, T_SLGCMJul-273.15,'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Modeled Temperatures - July');

figure(4); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, T_SLGCMOct-273.15,'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Modeled Temperatures - October');

figure(5); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, T_SLGCMJan-273.15,'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Modeled Temperatures - January');

figure(6); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, T_SLGCMApr-273.15,'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Modeled Temperatures - April');
%% Create comparisons with HadCRUT4 and plot!
figure(7); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, (T_SLGCMJul-obs(:,:,2030)),'linecolor','none');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside'); 
c.Label.String = '?T [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}?T - July');

figure(8); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, (T_SLGCMOct-obs(:,:,2030)),'linecolor','none');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside'); 
c.Label.String = '?T [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}?T - October');

figure(9); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, (T_SLGCMJan-obs(:,:,2030)),'linecolor','none');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside'); 
c.Label.String = '?T [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}?T - January');

figure(10); clf
worldmap world;
load coastlines;
p = contourfm(lat_new, lon_new, (T_SLGCMApr-obs(:,:,2030)),'linecolor','none');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside'); 
c.Label.String = '?T [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}?T - April');
%%
figure(11); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, T_modeled_new-273.15,'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Modeled Temperatures - Restructured');

figure(12); clf
worldmap world;
load coastlines;
contourfm(lat_new, lon_new, (T_modeled_new - obs(:,:,2030)),'linecolor','none');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside'); 
c.Label.String = 'Temperature Difference [°C]';
plotm(coastlat, coastlon, 'Color','black');
title('Difference between Modeled Temperatures and Observed HadCRUT4 Temperatures');
