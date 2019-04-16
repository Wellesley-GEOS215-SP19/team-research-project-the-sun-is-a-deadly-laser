%The sun is a deadly laser: A GEOS 215 Project

%Jocelyn and Leafia
%%
%MIDAS station data
%%
%tabular datastore for all the stations
station_ttds = tabularTextDatastore('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/team-research-project-the-sun-is-a-deadly-laser/midas_stations_by_area');
%station_ttds = tabularTextDatastore('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/midas_stations_by_area');

%station_ttds.ReadVariableNames = 1
station_ttds.NumHeaderLines = 1;
station_ttds.VariableNames = {'LON','LAT','Name','description','snippet','end_date','start_date','src_id','Area','Postcode'};
station_ttds.TextscanFormats = {'%f','%f','%q','%q','%q','%q','%q','%f','%q','%q'};
station_ttds.SelectedVariableNames = {'LON', 'LAT','src_id'};
%%
%station_ids = station_ttds.readall;
station_ids = readall(station_ttds);
%%
save('station_ids.mat','station_ids');

%I really don't know why when I run the code theres an array output to the
%command window with the entirely wrong numbers but the variable is fine
%and has the correct values so I don't know where the array is coming from

%station_contributers = unique(radiation_data.SRC_ID);



