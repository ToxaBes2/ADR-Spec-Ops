private["_handled", "_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
_ctrl = _this select 0;
_dikCode = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;  
_handled = false;
_allowedComanders = ["B_Soldier_SL_F","B_T_Soldier_SL_F","I_G_Soldier_AR_F","I_G_engineer_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_4_F"];
_player = typeOf player;
if (!_shift && !_ctrlKey && !_alt) then {
    if (_dikCode in (actionKeys "ShowMap")) then {
	      ((finddisplay 12) displayctrl 1202) ctrlSetText "media\images\icon_noplayer_ca.paa";
	      ((finddisplay 12) displayctrl 1202) ctrlEnable false;
	      ((finddisplay 12) displayctrl 1202) ctrlSetTooltip (localize "STR_Map_NoCenter");
    };
    if (_dikCode in (actionKeys "ForceCommandingMode") || _dikCode in (actionKeys "SelectAll")) then {
        if !(_player in _allowedComanders) then {
           _handled = true;
        };
    };
    _jumping = player getVariable ["is_jumping", false];
    if (_dikCode in (actionKeys "GetOver") && {alive player} && {currentWeapon player == primaryWeapon player || currentWeapon player == handgunWeapon player} 
        && {isNull objectParent player} && {speed player > 11} && {stance player == "STAND"} && {getFatigue player < 0.5} && {isTouchingGround player} 
        && {!_jumping}) then {
        player setVariable ["is_jumping", true];
        0 spawn {
            private _v = velocity player;
            private _veloH = [(_v select 0) + 0.6, (_v select 1) + 0.6, (_v select 2) + 0.1];
            private _veloL = [_v select 0, _v select 1, (_v select 2) - 1];
            private _maxHight = (getPosATL player select 2) + 1.3;            
            [player, "AovrPercMrunSrasWrflDf"] remoteExecCall ["switchMove"];
            sleep 0.05;
            while {animationState player == "AovrPercMrunSrasWrflDf"} do {
                if (getPosATL player select 2 > _maxHight) then {
                    player setVelocity _veloL;
                } else {
                    player setVelocity _veloH;
                };
                sleep 0.05;
            };
            sleep 1;
            player setVariable ["is_jumping", false];
        };
        _handled = true;
    };
};
_handled;  
