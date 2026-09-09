function [data, info] = preprocessing_grawac(data, info, ~)

%% ################ add metadata

if strcmp(info.nickstation, 'nya')
    %Height
    data.MSL = 11.;  

elseif strcmp(info.nickstation, 'pol')
    %Height
    data.MSL = 22.;

elseif strcmp(info.nickstation, 'joy')
    %Height
    data.MSL = 91.;

elseif strcmp(info.nickstation, 'p6') %polar aircraft P6
    %Height
    data.MSL = 0.;
elseif strcmp(info.nickstation, 'p5') %polar aircraft p5
    data.MSL = 0.;
else
    disp('unknown station')

end

% add info on software version to dataset#

if datetimeconv(2024,08,09,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2024,10,10,0,0,0) % VAMPIRE-1
    data.radarsw = '5.65';
elseif datetimeconv(2024,02,01,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2024,02,28,0,0,0) %HAMAG
    data.radarsw = '5.65';
elseif datetimeconv(2025,01,25,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2025,03,10,0,0,0) % IOP4H2O (at Ny-Alesund)
    data.radarsw = '5.65';
elseif datetimeconv(2025,07,02,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2025,09,01,0,0,0) % VAMPIRE-2
    data.radarsw = '5.65';
elseif datetimeconv(2026,03,01,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2026,04,15,0,0,0) %COMPEX
    data.radarsw = '5.65';
elseif datetimeconv(2026,05,22,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2026,08,20,0,0,0) % Vital-II
    data.radarsw = '5.65';
else    
    disp('From function preprocessing_grawac: Radar software version not defined!')
    
end % if


%% ####################### clean data from artificial spikes



%% ######## Ze corrections

%% correct for intercalibration biases
if data.time(1) >= datetimeconv(2024,08,10) && data.time(1) <= datetimeconv(2024,09,11,16,20) %vampire-1 before LN2 calibration
    dboffset = 1.11;  % in dB; this offset will be added to GRaWAC Ze [dBZ] such that Ze [dBZ] = Ze_measured [dBZ] + dboffset [dB]
    data.spec = data.spec*(10^(dboffset/10)); % apply offset to Ze measurements in linear mm^6 m^-3 units
    data.Ze_label = 'Ze corrected with 1.11 dB (for intercalibration with W-band) such that Ze [dBZ] = Ze_measured [dBZ] + Ze_corr [dB].';
    data.Ze_corr = dboffset;
    disp('Intercalibration bias...');
elseif datetimeconv(2024,09,11,16,20) < data.time(1) && data.time(1) <= datetimeconv(2024,10,08) %vampire-1 after LN2 calibration
    dboffset = -0.74; % in dB; this offset will be added to GRaWAC Ze [dBZ] such that Ze [dBZ] = Ze_measured [dBZ] + dboffset [dB]
    data.spec = data.spec*(10^(dboffset/10)); % apply offset to Ze measurements in linear mm^6 m^-3 units
    data.Ze_label = 'Ze corrected with -0.74  dB (for intercalibration with W-band) such that Ze [dBZ] = Ze_measured [dBZ] + Ze_corr [dB].';
    data.Ze_corr = dboffset;
    disp('Intercalibration bias...');
elseif data.time(1) >= datetimeconv(2025,07,02,13,47) && data.time(1) <= datetimeconv(2025,08,06,17,04) % vampire-2 before LN2 calibration
    dboffset = 1.3; % in dB; this offset will be added to GRaWAC Ze [dBZ] such that Ze [dBZ] = Ze_measured [dBZ] + dboffset [dB]
    data.spec*(10^(dboffset/10)); % apply offset to Ze measurements in linear mm^6 m^-3 units
    data.Ze_label = 'Ze corrected with 1.30dB (for intercalibration with W-band)such that Ze [dBZ] = Ze_measured [dBZ] + Ze_corr [dB].';
    data.Ze_corr = dboffset;
    disp('Intercalibration bias...');
elseif data.time(1) > datetimeconv(2025,08,06,19,02) && data.time(1) <= datetimeconv(2025,08,30) % vampire-2 after LN2 calibration
    dboffset = 2.29; % in dB; this offset will be added to GRaWAC Ze [dBZ] such that Ze [dBZ] = Ze_measured [dBZ] + dboffset [dB]
    data.spec*(10^(dboffset/10)); %apply offset to Ze measurements in linear mm^6 m^-3 units
    data.Ze_label = 'Ze corrected with 2.29dB (for intercalibration with W-band) such that Ze [dBZ] = Ze_measured [dBZ] + Ze_corr [dB].';
    data.Ze_corr = dboffset;
    disp('Intercalibration bias...');
else
    disp('no intercalibration bias was applied to measurements.')
end %if
disp('Intercalibration bias...done!')

    
