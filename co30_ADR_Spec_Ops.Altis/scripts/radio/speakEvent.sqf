/*
  Author: killzonekid (http://killzonekid.com/arma-scripting-tutorials-whos-talking/)
  Adapted by ToxaBes
  Description: catch speaking person and add psh-psh to active radio channel
*/ 
if (!isDedicated) then {
    VoN_ChannelId_fnc = {
        switch _this do {
            case localize "str_channel_global"    : {0};
            case localize "str_channel_side"      : {1};
            case localize "str_channel_command"   : {2};
            case localize "str_channel_group"     : {3};
            case localize "str_channel_vehicle"   : {4};
            case localize "str_channel_direct"    : {5};
            case localize "STR_CHANNEL_EMERGENCY" : {6};
            case localize "STR_CHANNEL_OPERATIVE" : {7};
            case localize "STR_CHANNEL_COMMANDER" : {8};            
            default {["",-1]};
        }
    };
    0 = [] spawn {
        VoN_isOn = false;
        VoN_currentTxt = "";
        VoN_channelId = -1;
        _fncDown = {            
            if (!VoN_isOn) then {
                if (!isNull findDisplay 55 && !isNull findDisplay 63) then {
                    VoN_isOn = true;
                    _ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
                    VoN_channelId = _ctrlText call VoN_ChannelId_fnc;
                    [netId player, VoN_channelId, "start"] remoteExecCall ["QS_fnc_RadioSound"];
                    findDisplay 55 displayAddEventHandler ["Unload", {
                        VoN_isOn = false;
                        [netId player, VoN_channelId, "end"] remoteExecCall ["QS_fnc_RadioSound"];                        
                    }]; 
                };
            };
            false
        };
        waitUntil {!isNull findDisplay 46};
        findDisplay 46 displayAddEventHandler ["KeyDown", _fncDown];        
        findDisplay 46 displayAddEventHandler ["MouseButtonDown", _fncDown];        
        findDisplay 46 displayAddEventHandler ["JoystickButton", _fncDown];
        //_fncUp = {
        //    if (VoN_isOn) then {
        //        _ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
        //        newVoN_channelId = _ctrlText call VoN_ChannelId_fnc;
        //        if (VoN_channelId != newVoN_channelId) then {
        //            [netId player, VoN_channelId, "end"] remoteExecCall ["QS_fnc_RadioSound"];
        //            [netId player, newVoN_channelId, "start"] remoteExecCall ["QS_fnc_RadioSound"];                    
        //        };
        //    };
        //    false
        //};
        //findDisplay 46 displayAddEventHandler ["KeyUp", _fncUp];
        //findDisplay 46 displayAddEventHandler ["MouseButtonUp", _fncUp];
    };
};