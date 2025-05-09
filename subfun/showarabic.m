function [onset, duration] = showarabic(cfg, ~, thisFixation, currentStimIndex)

    arabicNum = currentStimIndex - 11; %!!begin from 2

    framesLeft = floor(cfg.timing.arabicDuration / cfg.screen.ifi);

    %% Start the dots presentation
    
    %randomize font size
    cfontSize = cfg.task.arabicfontSize(randi(length(cfg.task.arabicfontSize)));
    
    %randomize location
    r1 = cfg.task.arabicLocationA + (cfg.task.arabicLocationB - cfg.task.arabicLocationA)*rand(1);
    r2 = cfg.task.arabicLocationA + (cfg.task.arabicLocationB - cfg.task.arabicLocationA)*rand(1);
    
    posX = cfg.screen.winWidth/2 + r1;
    posY = cfg.screen.winHeight/2 + r2;
    
    Screen('TextSize',cfg.screen.win,cfontSize);
    vbl = Screen('Flip', cfg.screen.win);
    onset = vbl;
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', cfg.screen.win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    % Here we load in an image from file. This one is a image of rabbits that
    % is included with PTB
    
    while framesLeft
        % WORDS
        DrawFormattedText(cfg.screen.win, num2str(arabicNum), posX, posY, cfg.text.color);
         drawFixation(thisFixation);
        Screen('DrawingFinished', cfg.screen.win);
        
        vbl = Screen('Flip', cfg.screen.win, vbl + cfg.screen.ifi  * 0.5); %, + cfg.screen.ifi * 0.5

        %% Update counters
        % Check for end of loop
        framesLeft = framesLeft - 1;
    end

    %% Clear word and keep fixation

    drawFixation(thisFixation);
    
    Screen('DrawingFinished', cfg.screen.win);
    
    Screen('Close');

    vbl = Screen('Flip', cfg.screen.win, vbl + cfg.screen.ifi * 0.5);

    duration = vbl - onset;

end