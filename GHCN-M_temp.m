%% GHCN v3 Temperature
%Import Raw Data:
rawTempData = readtable('ghcnm.tavg.v3.3.0.20181219.qcu.dat.csv');

%Turn relevant data into an array and set columns to appropriate variables
TempData = table2array(rawTempData(:,:));
ID = TempData(:,1);
year = TempData(:,2);
TempData(:,3:14) = TempData(:,3:14)/1000; %convert everything from m°C (milli-degrees Centigrade) to degrees Centigrade

%Replace -9999 data with NaN values in TempData
for j = 1:14;
    for i = 1:length(TempData);
        if TempData(i,j) < -9000;
            TempData(i,j) = NaN;
        end
    end
end

%Set up a 3D array to organize data
IDgrid = unique(ID); %All of the stations represented in the data set
yeargrid = unique(year); %All of the years represented in the data set (1701-2018)

%Initialize a 3D array made up of NaN values (rows = ID, columns =
%years, stacks = 12 months represented.
TempMatrix = NaN*zeros(length(IDgrid), length(yeargrid)), length(TempData(1,3:14)');

%Fill in 3D array with data
for i = 1:length(TempData);
    IDindex = find(IDgrid==ID(i));
    yearindex = find(yeargrid == year(i));
    for j = 1:length(TempData(1,3:14)');
        TempMatrix(IDindex, yearindex, j) = TempData(i,j+2);
    end
end

%Compute mean temperature over every ID's whole dataset for each month
%(i.e. the January mean for the WHOLE ID xxxx dataset, the Feb. mean, etc.,
%done for every ID at every month; so we need to take the mean along the
%second dimension; Note that this mean may need to be taken over a
%"baseline" period that we define. For now this is the whole dataset from
%1701-2018.
%MeanMonthlyTemp = nanmean(TempMatrix, 2);

%Plug in the mean monthly temperature values for every station in every NaN
%value
%for k = 1:length(TempData(1,3:14)')
   % for i = 1:length(IDgrid)
        %nanind = find(isnan(TempMatrix(i, :, k)) == 1);
       % TempMatrix(i, nanind, k) = MeanMonthlyTemp(i, 1, k);
   % end
%end

%Compute the mean annual temperature for each station
MeanAnnualTemp = mean(TempMatrix, 3);

%% Get Lat's and Lon's for each station that's in the dataset
%Import Data about all of the possible stations used in this dataset
stationData = readtable('v3.temperature.inv.csv');
stationData = table2array(stationData(:,:));

%Initialize an empty array to store station ID's and Lat's/Lon's
stations = NaN*zeros(length(IDgrid), 3);

%For loop that finds the ID's of the used ID's within the reference
%ID's, and then gets the lat's and lon's and plugs it into the "stations"
%array.
for i = 1:length(stationData(:,1))
    stationIDindex = find(IDgrid == stationData(i,1));
    stations(stationIDindex,1) = stationData(stationIDindex,1);
    stations(stationIDindex,2) = stationData(stationIDindex,2);
    stations(stationIDindex,3) = stationData(stationIDindex,3);
end
%% Now put everything together to plot it!!!
figure(1); clf
worldmap world;
geoshow('landareas.shp', 'FaceColor', 'black')
scatterm(stations(:,2), stations(:,3), 10, MeanAnnualTemp(:,201), 'filled');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside');
c.Label.String = 'Temperature Anomaly (??) [°C]';
title('GHCN-M v3 Temperature Anomaly (??) in 1901');
%%
figure(2); clf
worldmap world;
geoshow('landareas.shp', 'FaceColor', 'black')
scatterm(stations(:,2), stations(:,3), 10, MeanAnnualTemp(:,260), 'filled');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside');
c.Label.String = 'Temperature Anomaly (??) [°C]';
title('GHCN-M v3 Temperature Anomaly (??) in 1960');
%%
figure(3); clf
worldmap world;
geoshow('landareas.shp', 'FaceColor', 'black')
scatterm(stations(:,2), stations(:,3), 10, MeanAnnualTemp(:,318), 'filled');
cmocean('balance', 'pivot', 0);
c = colorbar('southoutside');
c.Label.String = 'Temperature Anomaly (??) [°C]';
title('GHCN-M v3 Temperature Anomaly (??) in 2018');

%Ok so some issues:
% - The temperature data seem to like to hover around 0°C, even when I
% remove the data filling w/the averaged monthly temperature; could this be
% temperature anomaly data??? I honestly have no clue.
% - Also what is the deal with these units what the heck???? I feel like
% we've used this dataset before, so we need to get in contact with Hilary
% about this because I could have sworn that we've used this dataset
% before.
% - But hey I did a cool thing and restructured data into a usable format
% so good on me!!
