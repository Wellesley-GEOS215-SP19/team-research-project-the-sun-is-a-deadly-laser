%tabular datastore for all the stations
station_ttds = tabularTextDatastore('/Users/leafiasheradencox/Desktop/GEOS 215/GitHub/midas_stations_by_area');
%station_ttds.ReadVariableNames = 1
station_ttds.NumHeaderLines = 1;
station_ttds.VariableNames = {'X','Y','Name','description','snippet','end_date','start_date','src_id','Area','Postcode'};
station_ttds.TextscanFormats = {'%f','%f','%q','%*q','%*q','%*q','%q','%f','%*q','%*q'};
station_ttds.SelectedVariableNames = {'X', 'Y','src_id'};

%%
station_ids = station_ttds.readall;

%stationdata = readall(station_ttds)
%%
save('station_ids.mat','station_ids');