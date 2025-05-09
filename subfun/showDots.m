% (C) Copyright 2018 Mohamed Rezk
% (C) Copyright 2020 CPP visual motion localizer developpers

function [onset, duration] = showDots(cfg, ~, thisFixation, thisImage)
    % show dots arrays
    %% Get parameters
    nbFrames = ceil(cfg.timing.eventDuration / cfg.screen.ifi);

    %% Start the dots presentation
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', cfg.screen.win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    %load image
    imageTexture = Screen('MakeTexture', cfg.screen.win, thisImage);

    vbl = Screen('Flip', cfg.screen.win);
    
    for iFrame = 1:nbFrames

        Screen('DrawTexture', cfg.screen.win, imageTexture, [], [], 0);
         drawFixation(thisFixation);

        vbl = Screen('Flip', cfg.screen.win ,vbl + cfg.screen.ifi * 0.5);
        if iFrame == 1
            onset = vbl;
        end

    end

    %% Clear word and keep fixation

    drawFixation(thisFixation);


    vbl = Screen('Flip', cfg.screen.win, vbl + cfg.screen.ifi* 0.5);

    duration = vbl - onset;

end
