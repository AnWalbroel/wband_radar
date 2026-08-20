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

% Before radar software version 5.0 need to correct for incorrectly 
% estimated receiver gain: factor of 2/adding +3 dB.



    
