%The Sun is a Deadly Laser: A GEOS 215 Project
%Jocelyn and Leafia
%%
% Read the names of nc-files in the folder 
ncfiles = dir('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/ORD32943/*.nc');
Nfiles = length(ncfiles);     % Total number of nc files 

finalfile=(ncfiles(408).name); %final data file is December 2015 data

%ncdisp(finalfile);

lat = ncread(finalfile,'lat');
lon = ncread(finalfile,'lon');
SIS = ncread(finalfile,'SIS');
SISCLS = ncread(finalfile,'SISCLS'); %SISCLS is surface downwelling shortwave radiation assuming clear sky conditions
%SISCLS is in Watts/square meters

%imagesc(SISCLS(:,:)');
%%
figure(1); clf
worldmap world
load coastlines;
contourfm(lat, lon, SISCLS(:,:),'linecolor','none');
cmocean('thermal');
c = colorbar('southoutside'); 
c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
plotm(coastlat, coastlon, 'Color','white','LineWidth',1);
title('December 2015 Surface Downwelling Shortwave Radiation')


%%
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

