function [onset, duration] = playSounds(cfg, ~, thisSound, thisFixation)

    %% Get parameters

    drawFixation(thisFixation);
    Screen('Flip', cfg.screen.win);

    
    % Start the sound presentation
    PsychPortAudio('FillBuffer', cfg.audio.pahandle, thisSound);
    PsychPortAudio('Start', cfg.audio.pahandle); %cfg.audio.pahandle

    % Get the end time
    waitForEndOfPlayback = 1; % hard coding that will need to be moved out
    [onset, ~, ~, estStopTime] = PsychPortAudio('Stop', cfg.audio.pahandle, ...
                                                waitForEndOfPlayback);

    duration = estStopTime - onset;
