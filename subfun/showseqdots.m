function [onset, duration] = showseqdots(cfg, thisFixation, ~, dotsInfo)

% Set up alpha-blending for smooth (anti-aliased) lines
%      dotsInfo = dotsInfo/2;
    Screen('BlendFunction', cfg.screen.win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

    %present dots
    vbl = Screen('Flip', cfg.screen.win);
    onset = vbl;

    for v = 1:length(dotsInfo)
        nbframes = ceil(dotsInfo(v)/cfg.screen.ifi);
        if mod(v,2)==1
        for e = 1:nbframes
            Screen('DrawDots', cfg.screen.win, [cfg.screen.winWidth/2, cfg.screen.winHeight/2], cfg.dots.SizePix, cfg.dots.color, [], 2);
            vbl = Screen('Flip', cfg.screen.win, vbl + cfg.screen.ifi  * 0.5);%, vbl + cfg.screen.ifi  * 0.5
        end
        else
            for e = 1:nbframes
            vbl = Screen('Flip',cfg.screen.win, vbl + cfg.screen.ifi  * 0.5);
            end
        end
    end


     drawFixation(thisFixation);
    
     Screen('DrawingFinished', cfg.screen.win);
    
     Screen('Close');
    
     vbl = Screen('Flip', cfg.screen.win, vbl + cfg.screen.ifi * 0.5);
    
     duration = vbl - onset;
     
end