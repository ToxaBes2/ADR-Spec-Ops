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
};
_handled;  
