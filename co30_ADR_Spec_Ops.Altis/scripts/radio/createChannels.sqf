/*
  Author: ToxaBes
  Description: add custom channels on server
  Channel colors:
    0 = Global    - disabled
    1 = Side      - disabled
    2 = Command   - disabled
    3 = Group     - green
    4 = Vehicle   - yellow
    5 = Direct    - white
    6 = System    - no color
    7 = Emergency - red
    8 = Operative - blue
    9 = Command   - violet
*/
if (isServer) then {

    // red - Emergency channel available for all players
    _emergencyChannel = radioChannelCreate [[0.67,0.14,0.13,1], localize "STR_CHANNEL_EMERGENCY", "HELP! [%UNIT_NAME]", []];
    //_emergencyChannel enableChannel [true, false];
    // Operative channel available for commanders and pilots
    _operativeChannel = radioChannelCreate [[0.118,0.565,1,1], localize "STR_CHANNEL_OPERATIVE", "%UNIT_NAME", []];

    // Command channel available only for squad commanders 
    _commandChannel = radioChannelCreate [[0.58,0,0.827,1], localize "STR_CHANNEL_COMMANDER", "%UNIT_NAME", []];
    RADIO_CHANNELS = [_emergencyChannel, _operativeChannel, _commandChannel];
	publicVariable "RADIO_CHANNELS";
};

if (!isDedicated) then {
    waitUntil {!isNull player};
    waitUntil {player == player};
    waitUntil {!isNil "RADIO_CHANNELS"};
    _playerType = typeOf player;

    // add all players to emergency channel
    (RADIO_CHANNELS select 0) radioChannelAdd [player];

    // commanders have access to command and operative channels
    if (_playerType == "B_Soldier_SL_F") then {        
        (RADIO_CHANNELS select 1) radioChannelAdd [player];
        (RADIO_CHANNELS select 2) radioChannelAdd [player];
    };

    // pilots have access to operative channels
    if (_playerType == "B_Helipilot_F") then {
        (RADIO_CHANNELS select 1) radioChannelAdd [player];
    };
};
