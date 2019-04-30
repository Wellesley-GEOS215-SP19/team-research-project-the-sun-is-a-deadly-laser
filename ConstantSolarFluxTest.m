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

%% Read in Relevant Data and Set Constants: Constants
r_s = 695.508e6; %Radius of the Sun [m]; Brown and Christensen-Dalsgaard, 1998
R_p = 149.597e9; %Earth-Sun Distance (1 Au) [m]; IAU, 2012
sigma = 6.57e-8; %Stefan-Boltzmann Constant [W*m^-2*K^-4]; Blevin and Brown, 1971
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
worldmap world
contourfm(lat_abs, lon_abs, obs(:,:,2030)'-273.15, 'linecolor', 'none');
cmocean('thermal');
c = colorbar('southoutside');
c.Label.String = 'Temperature [°C]';
plotm(coastlat, coastlon, 'Color', 'black');
title('Observed Temperatures');
%% Compare w/T_observed