function [data, info] = preprocessing_miraca(data, info, ~)

%% ################ add metadata

if strcmp(info.nickstation, 'nya')
    %Height
    data.MSL = 11.;  

elseif strcmp(info.nickstation, 'pol')
    %Height
    data.MSL = 22.;
    
else
    disp('unknown station')

end

% add info on software version to dataset

if datetimeconv(2025,07,02,0,0,0) <= data.time(1) && data.time(1) < datetimeconv(2025,09,01,0,0,0) % VAMPIRE-2
    data.radarsw = '5.65';

else    
    disp('From function processing_miraca: Radar software version not defined!')
    
end % if


%% ####################### clean data from artificial spikes



%% ######## Ze corrections

% Before radar software version 5.0 need to correct for incorrectly 
% estimated receiver gain: factor of 2/adding +3 dB.



    
