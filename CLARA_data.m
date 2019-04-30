%The Sun is a Deadly Laser: A GEOS 215 Project
%Jocelyn and Leafia
%%
% Read the names of nc-files in the folder 
ncfiles = dir('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/team-research-project-the-sun-is-a-deadly-laser/ORD32943/*.nc');
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
h = figure;
            
            figure(i); clf;
            %hold on
            %for j = 1:4; % NOTE: You CANNOT use 'j' for both the variable and the loop. Change one of them
            %    subplot(3,4,j) % Creates a row of four plots per figure
            worldmap world
            load coastlines;
            contourfm(lat, lon, SISCLS_data','linecolor','none');
            cmocean('thermal');
            c = colorbar('southoutside'); 
            c.Label.String = '\it Surface Downwelling Shortwave Radiation [W/m^{2}]';
            plotm(coastlat, coastlon, 'Color','black','LineWidth',1);
            saveas(h,sprintf('FIG%d.png',i)); % will create FIG1, FIG2,...
            % title(sprintf('%s 2015 Surface Downwelling Shortwave Radiation',months{i}));

%end
%end
%end

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

