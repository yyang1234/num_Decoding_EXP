% (C) Copyright 2020 CPP visual motion localizer developpers

function varargout = preTrialSetup(varargin)
    % varargout = postInitializatinSetup(varargin)

    % generic function to prepare some structure before each trial

    [cfg, iBlock, iEvent] = deal(varargin{:});

    % trial_type is defined by the currentImgIndex: 
    % 1-8 = french, 9-16 = braille, 17 = blank
    switch cfg.design.presMatrix(iBlock,iEvent)
        case {1} 
            thisEvent.trial_type = '2vis_sim';
        case {2} 
             thisEvent.trial_type = '3vis_sim';
        case {3} 
             thisEvent.trial_type = '4vis_sim';
        case {4} 
             thisEvent.trial_type = '5vis_sim';
        case {5} 
            thisEvent.trial_type = '2vis_seq';
        case {6} 
             thisEvent.trial_type = '3vis_seq';
        case {7} 
             thisEvent.trial_type = '4vis_seq';
        case {8} 
             thisEvent.trial_type = '5vis_seq';
        case {9} 
            thisEvent.trial_type = '2aud_seq';
        case {10} 
             thisEvent.trial_type = '3aud_seq';
        case {11} 
             thisEvent.trial_type = '4aud_seq';
        case {12} 
             thisEvent.trial_type = '5aud_seq';
        case {13} 
            thisEvent.trial_type = '2vis_num';
        case {14} 
             thisEvent.trial_type = '3vis_num';
        case {15} 
             thisEvent.trial_type = '4vis_num';
        case {16} 
             thisEvent.trial_type = '5vis_num';
        case {17} 
            thisEvent.trial_type = '2aud_num';
        case {18} 
             thisEvent.trial_type = '3aud_num';
        case {19} 
             thisEvent.trial_type = '4aud_num';
        case {20} 
             thisEvent.trial_type = '5aud_num';
    end
    thisEvent.target = cfg.design.targetMatrix(iBlock, iEvent);

    thisFixation.fixation = cfg.fixation;
    thisFixation.screen = cfg.screen;


    varargout = {thisEvent, thisFixation, cfg};
end
 