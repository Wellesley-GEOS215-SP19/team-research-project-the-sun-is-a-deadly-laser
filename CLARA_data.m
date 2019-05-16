%The Sun is a Deadly Laser: A GEOS 215 Project
%Jocelyn and Leafia
%% Read in data for the most recent year for each month
% Read the names of nc-files in the folder 
<<<<<<< HEAD
%ncfiles = dir('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/team-research-project-the-sun-is-a-deadly-laser/ORD32943/*.nc');
ncfiles = dir('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/ORD32943/*.nc');

%%
%finalfile=(ncfiles(408).name); %final data file is December 2015 data

%latfinal = ncread(finalfile,'lat');
%lonfinal= ncread(finalfile,'lon');
%SISfinal = ncread(finalfile,'SIS');
%SISCLSfinal = ncread(finalfile,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

%figure(1); clf
%worldmap world
%load coastlines;
%contourfm(latfinal, lonfinal, SISCLSfinal(:,:)','linecolor','none');
%cmocean('thermal');
%c = colorbar('southoutside'); 
%c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
%plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
%title('December 2015 Surface Downwelling Shortwave Radiation')

%file400=(ncfiles(400).name); %final data file is April 2015 data

%lat400 = ncread(file400,'lat');
%lon400= ncread(file400,'lon');
%SIS400 = ncread(file400,'SIS');
%SISCLS400 = ncread(file400,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

%figure(2); clf
%worldmap world
%load coastlines;
%contourfm(lat400, lon400, SISCLS400(:,:)','linecolor','none');
%cmocean('thermal');
%c = colorbar('southoutside'); 
%c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
%plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
%title('April 2015 Surface Downwelling Shortwave Radiation')


%%
% Read the names of nc-files in the folder 
% Loop for each nc-file

months = {'January','February','March','April','May','June','July','August','September','October','November','December'};
data = NaN*zeros(1440,720,408);
    
for i=1:408        
            file = ncfiles(i).name;
            lat = ncread(file,'lat');
            lon = ncread(file,'lon');
            SIS = ncread(file,'SIS');
            SISCLS = ncread(file,'SISCLS');
            data(:,:,i)=SISCLS;
            SISCLS_data = data(:,:,i);
end     

%%
mean_SIS = mean(data,3);

%%

figure(2); clf;
worldmap world
load coastlines;
contourfm(lat, lon, mean_SIS', 'linecolor', 'none');
cmocean('thermal');
c=colorbar('southoutside');
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','black','LineWidth',1);
title('Surface Downwelling Shortwave Radiation');

%%
           % figure(i); clf;
            %hold on
            %worldmap world
            %load coastlines;
            %contourfm(lat, lon, SISCLS_data','linecolor','none');
            %cmocean('thermal');
            %c = colorbar('southoutside'); 
            %c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
            %plotm(coastlat, coastlon, 'Color','black','LineWidth',1);
            %title('Surface Downwelling Shortwave Radiation');

    %end
%end
=======
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
for i=1:length(latJul)
    for j=1:length(lonJul)
        if SISCLSJul(j,i) == 0
            SISCLSJul(j,i)= NaN;
        end
    end
end
figure(1); clf
worldmap world
load coastlines;
contourfm(latJul, lonJul, SISCLSJul(:,:)','linecolor','none');
cmocean('solar');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}July 2015');

%% October (Northern Hemisphere Fall) Solar irradiation
latOct = ncread(Oct2013,'lat');
lonOct= ncread(Oct2013,'lon');
SISOct = ncread(Oct2013,'SIS');
SISCLSOct = ncread(Oct2013,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters
for i=1:length(latJul)
    for j=1:length(lonJul)
        if SISCLSOct(j,i) == 0
            SISCLSOct(j,i)= NaN;
        end
    end
end
figure(2); clf
worldmap world
contourfm(latOct, lonOct, SISCLSOct(:,:)','linecolor','none');
cmocean('solar');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}October 2013')

%% January 2015 (Northern Hemisphere Winter) Solar Irradiation
latJan = ncread(Jan2015,'lat');
lonJan = ncread(Jan2015,'lon');
SISJan = ncread(Jan2015,'SIS');
SISCLSJan = ncread(Jan2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters
for i=1:length(latJul)
    for j=1:length(lonJul)
        if SISCLSJan(j,i) == 0
            SISCLSJan(j,i)= NaN;
        end
    end
end
figure(3); clf
worldmap world
contourfm(latJan, lonJan, SISCLSJan(:,:)','linecolor','none');
cmocean('solar');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}January 2015')
>>>>>>> 49591446cda1452074ee68873f15735cf2b036b9

%% April 2015 (Northern Hemisphere Spring) Solar Irradiation
latApr = ncread(Apr2015,'lat');
lonApr= ncread(Apr2015,'lon');
SISApr = ncread(Apr2015,'SIS');
SISCLSApr = ncread(Apr2015,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters
for i=1:length(latJul)
    for j=1:length(lonJul)
        if SISCLSApr(j,i) == 0
            SISCLSApr(j,i)= NaN;
        end
    end
end
figure(4); clf
worldmap world
contourfm(latApr, lonApr, SISCLSApr(:,:)','linecolor','none');
cmocean('solar');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','black');
title('\fontsize{16}April 2015')

