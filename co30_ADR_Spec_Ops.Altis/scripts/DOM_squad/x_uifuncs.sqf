// by Xeno
#define THIS_FILE "x_uifuncs.sqf"
#include "x_setup.sqf"
#define CTRL(A) (_disp displayCtrl A)

// Show squad management and fill group list boxes
FUNC(squadmanagementfill) = {
	private ["_disp", "_units", "_i", "_helper", "_ctrl", "_ctrl2", "_sidegrppl", "_grptxtidc", "_grplbidc", "_grpbutidc", "_grpkickbutidc", "_grpinvitebutidc", "_curgrp", "_leader", "_unitsar", "_name", "_isppp", "_index", "_pic", "_diff", "_invitedPerson", "_invitedGroup", "_show", "_newInvites"];

	if (captive player) then {
        player setCaptive false;
    };
    
    _side = WEST; // should be changed to WEST in ADR: Blue Shark mission
    if (side (group player) != _side || (group player) == grpNull) then {
        _newGroup = createGroup _side;
		[player] joinSilent _newGroup;
    };

	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_units = if (isMultiplayer) then {playableUnits} else {switchableUnits};
	if (isNil QGVAR(SQMGMT_grps)) then {
		GVAR(SQMGMT_grps) = [];
	} else {
		for "_i" from 0 to (count GVAR(SQMGMT_grps) - 1) do {
			_helper = GVAR(SQMGMT_grps) select _i;
			if (isNull _helper) then {
				GVAR(SQMGMT_grps) set [_i, -1];
			} else {
				if (count (units _helper) == 0) then {
					GVAR(SQMGMT_grps) set [_i, -1];
				};
			};
		};
		GVAR(SQMGMT_grps) = GVAR(SQMGMT_grps) - [-1];
	};

    _sidegrppl = side (group player);
	{
		if (!((group _x) in GVAR(SQMGMT_grps)) && {side (group _x) getFriend _sidegrppl >= 0.6}) then {
			GVAR(SQMGMT_grps) set [count GVAR(SQMGMT_grps), group _x];
		};
	} forEach _units;

	for "_i" from 0 to 49 do {
		_ctrl = _disp displayCtrl (4000 + _i);
		_ctrl ctrlShow false;
		_ctrl = _disp displayCtrl (3000 + _i);		
		_ctrl ctrlSetText (localize "STRD_Join");
		_ctrl ctrlShow false;
        _ctrl ctrlEnable false;
		_ctrl = _disp displayCtrl (2000 + _i);
		_ctrl ctrlShow false;
		_ctrl = _disp displayCtrl (1000 + _i);
		_ctrl ctrlShow false;
		_ctrl = _disp displayCtrl (6000 + _i);
		_ctrl ctrlShow false;
		_ctrl = _disp displayCtrl (7000 + _i);
		_ctrl ctrlShow false;
		_ctrl = _disp displayCtrl (8000 + _i);
		_ctrl ctrlShow false;	
		_ctrl = _disp displayCtrl (9000 + _i);
		_ctrl ctrlShow false;	
		_ctrl = _disp displayCtrl (10000 + _i);
		_ctrl ctrlShow false;
	};
		
	_grpbgidc = 1000;	
	_grplbidc = 2000;
	_grpbutidc = 3000;
	_grptxtidc = 4000;
	_grplockidc = 6000;
	_grplockbutidc = 7000;
	_grpkickbutidc = 8000;
	_grpinvitebutidc = 9000;	
	_grprankbutidc = 10000;
	_hintidc = 11000;
	{
	    _ctrl1 = CTRL(_grpbgidc);
        _ctrl1 ctrlShow true;
		_ctrl1 = CTRL(_grplbidc);
        _ctrl1 ctrlShow true;
        _ctrl1 = CTRL(_grpbutidc);
        _ctrl1 ctrlShow true;
        _ctrl1 ctrlEnable true;
		_ctrl = CTRL(_grptxtidc);
		_ctrl ctrlSetText (str(_x));
		_ctrl ctrlShow true;
        CTRL(_hintidc) ctrlShow false;

        // set current group name in green color
		if (group player == _x) then {
			_ctrl ctrlSetTextColor [0.545, 0.765, 0.290, 1];
		} else {
            _ctrl ctrlSetTextColor [1, 1, 1, 1];
	    };
	    _curgrp = _x;
	    _lockedgr = false;
        {
            if (_curgrp == _x) exitWith {
                _lockedgr = true;
            };
        } forEach TB_Locks;
		if (_lockedgr) then {

            // show locked picture
			CTRL(_grplockidc) ctrlShow true;

            // group is locked, hide join button
            if (group player != _curgrp) then {
            	_newInvites = [];
                _show = false;
                {
                    _invitedPerson = _x select 0;
                    _invitedGroup = _x select 1;
                    if (_invitedPerson == player && _invitedGroup == _curgrp) then {
                        _show = true;
                    } else {
                        _newInvites set [count _newInvites, [_invitedPerson, _invitedGroup]];
                    };
                } forEach TB_Invites;                
                if (_show) then {
                    TB_Invites = _newInvites;
                    [[TB_Invites], QGVAR(set_invites), true, true, true] call BIS_fnc_MP;
                    CTRL(_grpbutidc) ctrlShow true;
                } else {
                    CTRL(_grpbutidc) ctrlShow false;
                };
                CTRL(_grplockbutidc) ctrlShow false;
	            CTRL(_grpkickbutidc) ctrlShow false;
	            CTRL(_grprankbutidc) ctrlShow false;
            };
		};
		if (player == leader _x) then {		
		    CTRL(_hintidc) ctrlShow true;	
			CTRL(_grplockbutidc) ctrlShow true;
			if (_lockedgr) then {
				CTRL(_grplockidc) ctrlShow true;
			    CTRL(_grplockbutidc) ctrlSetText (localize "STRD_Unlock");					
			} else {
			    CTRL(_grplockidc) ctrlShow false;
			    CTRL(_grplockbutidc) ctrlSetText (localize "STRD_Lock");
		    };
		};
				
		_leader = objNull;
		_unitsar = [];
		{
			if (_x != leader _curgrp) then {
				_unitsar set [count _unitsar, _x];
			} else {
				_leader = _x;
			};
		} forEach (units _curgrp);
		if (!isNull _leader) then {
			_unitsar = [_leader] + _unitsar;
		};
		
		_ctrl = CTRL(_grplbidc);
		lbClear _ctrl;
		_ctrl lbSetCurSel -1;
		{
			_name = name _x;
			if (!isPlayer _x) then {
				_name = _name + " (A.I.)";
			};
			_name_data = name _x;
			_isppp = false;
			if (_x == player) then {
				_isppp = true;
				_ctrl2 = CTRL(_grpbutidc);
				if (count _unitsar > 1) then {
					_ctrl2 ctrlSetText (localize "STRD_Leave");
				} else {
					_ctrl2 ctrlShow false;
				};
			};
			_index = _ctrl lbAdd _name;
			_ctrl lbSetData [_index, _name_data];
			if (_isppp) then {
				_ctrl lbSetColor [_index, [1,1,1,1]];
			};

			// set leader name in blue color
			if (_x == leader _curgrp) then {
				_ctrl lbSetColor [_index, [0.129,0.588,0.953,1]];
            };
            //_ipic = getText (configFile >> "cfgVehicles" >> (typeOf _x) >> "picture");
			_ipic = getText (configFile >> "cfgVehicles" >> (typeOf _x) >> "icon");
			if (_ipic == "") then {
				_pic = "#(argb,8,8,3)color(1,1,1,0)";
			} else {
				_pic = getText(configFile>>"CfgVehicleIcons">>_ipic);
			};
			_ctrl lbSetPicture [_index, _pic];
			_ctrl lbSetPictureColor [_index, [1, 1, 1, 0.8]];
		} forEach _unitsar;
		if (count (units _x) >= 50) then {
			_ctrl2 = CTRL(_grpbutidc);
			_ctrl2 ctrlEnable false;
		};
		__INC(_grpbgidc);
		__INC(_grptxtidc);
		__INC(_grplbidc);
		__INC(_grpbutidc);
		__INC(_grplockidc);
		__INC(_grplockbutidc);
		__INC(_grpkickbutidc);
		__INC(_grpinvitebutidc);
		__INC(_grprankbutidc);
	} forEach GVAR(SQMGMT_grps);
		
	if (_grptxtidc < 4049) then {
		_diff = 4049 - _grptxtidc;
		for "_i" from (49 - _diff) to 49 do {
			_ctrl = _disp displayCtrl (10000 + _i);
			_ctrl ctrlShow false;
            _ctrl = _disp displayCtrl (9000 + _i);
			_ctrl ctrlShow false;
            _ctrl = _disp displayCtrl (8000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (7000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (6000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (4000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (3000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (2000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (1000 + _i);
			_ctrl ctrlShow false;
		};
	};
	ctrlSetFocus CTRL(9999);
};

// Lock/Unlock group event
FUNC(squadmgmtlockbuttonclicked) = {
	private ["_grp", "_lockedgr", "_disp", "_ctrl", "_ctrl2", "_newLocked"];
	disableSerialization;
	_grp = group player;
	_lockedgr = false;
    {
        if (_grp == _x) exitWith {
            _lockedgr = true;
        };
    } forEach TB_Locks;	
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_ctrl = _disp displayCtrl _this;
	_ctrl2 = _disp displayCtrl (6000 + (_this - 7000));
	if (_lockedgr) then {
		_newLocked = [];
		{
            if (_grp != _x) then {
               _newLocked set [count _newLocked, _x];
            };
        } forEach TB_Locks;
        TB_Locks = _newLocked;
        [[TB_Locks], QGVAR(set_locks), true, true, true] call BIS_fnc_MP;
		_ctrl ctrlSetText localize "STRD_Lock";
		_ctrl2 ctrlShow false;
	} else {
		TB_Locks set [count TB_Locks, _grp];
		[[TB_Locks], QGVAR(set_locks), true, true, true] call BIS_fnc_MP;
		_ctrl ctrlSetText localize "STRD_Unlock";
		_ctrl2 ctrlShow true;
	};
	[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;
};

GVAR(sqtmgmtblocked) = false;

// Join/Leave button clicked event
FUNC(squadmgmtbuttonclicked) = {
	
	if (GVAR(sqtmgmtblocked)) exitWith {};
	private ["_diff", "_grp", "_sidep", "_newgrp", "_count", "_oldgrp", "_disp", "_lbbox", "_lbidx", "_lbname", "_newLocked"];
	if (typeName _this != typeName 1) exitWith {};
	_diff = _this - 5000;
	_grp = GVAR(SQMGMT_grps) select _diff;
	_oldgrp = group player;
	disableSerialization;

	// remove unit from group
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_lbbox = 2000 + _diff;

	_lbidx = lbCurSel CTRL(_lbbox);
	_lbname = if (_lbidx != -1) then {
		CTRL(_lbbox) lbData _lbidx
	} else {
		""
	};
	_ogrlocked = false;
    {
        if (_oldgrp == _x) exitWith {
            _ogrlocked = true;
        };
    } forEach TB_Locks;

	// set new leader if old one is gone
	if (_ogrlocked && {player == leader _oldgrp}) then {
		_newLeader = false;
        {
			if (isPlayer _x) exitWith {
				_newLeader = _x;
			};
		} forEach (units _oldgrp);
        [QGVAR(grpslead), [leader _oldgrp, _oldgrp, _newLeader]] call FUNC(NetCallEventSTO);		
	};
	if (group player == _grp && {_lbname != name player} && {_lbidx != -1} && {player == leader _grp}) exitWith {
		_unittouse = objNull;
		{
			if (name _x == _lbname) exitWith {
				_unittouse = _x;
			};
		} forEach (units _grp);
		if (isNull _unittouse) exitWith {};

		// must be AI version
		if (!isPlayer _unittouse) exitWith {
			if (vehicle _unittouse == _unittouse) then {
				deleteVehicle _unittouse;
			} else {
				moveOut _unittouse;
				_unittouse spawn {
					scriptName "spawn_d_fnc_squadmgmtbuttonclicked_vecwait";
					private "_grp";
					_grp = group _this;
					waitUntil {sleep 0.331;vehicle _this == _this};
					deleteVehicle _this;
				};
			};
			//if (dialog) then {
			//	call FUNC(squadmanagementfill);
			//};
			[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;
		};
		_newgrpp = createGroup side (group player);
		[_unittouse] joinSilent _newgrpp;
		GVAR(sqtmgmtblocked) = true;
		[_grp, _unittouse] spawn {
			scriptName "spawn_d_fnc_squadmgmtbuttonclicked_sqmgmtfill";
			waitUntil {!((_this select 1) in (units (_this select 1)))};
			//if (dialog) then {
			//	call FUNC(squadmanagementfill);
			//};
			[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;
			GVAR(sqtmgmtblocked) = false;
		};
	};
	
	// Leave = new group
	if (group player == _grp) then {
		_sidep = side (group player);
		_newgrp = createGroup _sidep;
		[player] joinSilent _newgrp;
		if (GVAR(with_ai)) then {
			_ai_only = true;
			{
				if (isPlayer _x) exitWith {
					_ai_only = false;
				};
			} forEach (units _grp);
			if (_ai_only) then {
				{
					deleteVehicle _x;
				} forEach (units _grp);
				if (count (units _grp) > 0) then {
					{
						moveOut _x;
						_x spawn {
							scriptName "spawn_d_fnc_squadmgmtbuttonclicked_waitvec2";
							private "_grp";
							_grp = group _this;
							waitUntil {sleep 0.331;vehicle _this == _this};
							deleteVehicle _this;
							deleteGroup _grp;
						};
					} forEach (units _grp)
				};
			};
		};
		if (count (units _grp) == 0) then {
			if (!isNull _grp) then {
				deleteGroup _grp;
			};
		} else {
			[QGVAR(grpswmsg), [leader _grp, name player]] call FUNC(NetCallEventSTO);
		};
		// transfer name of old group to new group ? (setgroup ID) ?
		// edit: not needed, players can't leave groups with just himself in the group
	} else {
		[QGVAR(grpjoin), [_grp, player]] call FUNC(NetCallEventSTO);
		_count = 0;
		{
			if (isPlayer _x) then {
				__INC(_count);
			};
		} forEach (units _grp);
		
		// this code part do next: if player joined to AI squad, he automatically become a leader. I comment it for now.
		//if (_count == 1) then {
		//	[QGVAR(grpslead), [leader _grp, _grp, player]] call FUNC(NetCallEventSTO);
		//};
		
		if (GVAR(with_ai)) then {
			_ai_only = true;
			{
				if (isPlayer _x) exitWith {
					_ai_only = false;
				};
			} forEach (units _oldgrp);
			if (_ai_only) then {
				{
					deleteVehicle _x;
				} forEach (units _oldgrp);
				if (count (units _oldgrp) > 0) then {
					{
						moveOut _x;
						_x spawn {
							scriptName "spawn_d_fnc_squadmgmtbuttonclicked_waitvec3";
							private "_grp";
							_grp = group _this;
							waitUntil {sleep 0.331;vehicle _this == _this};
							deleteVehicle _this;
							deleteGroup _grp;
						};
					} forEach (units _oldgrp)
				};
			};
		};
		if (count (units _oldgrp) == 0&& {!isNull _oldgrp}) then {
			deleteGroup _oldgrp;
		};
		if (!isNull _oldgrp) then {
			[QGVAR(grpswmsg), [leader _oldgrp, name player]] call FUNC(NetCallEventSTO);
		};
		[QGVAR(grpswmsgn), [leader _grp, name player]] call FUNC(NetCallEventSTO);
	};
	GVAR(sqtmgmtblocked) = true;
	
	_oldgrp spawn {
		scriptName "spawn_d_fnc_squadmgmtbuttonclicked_oldgrp";
		waitUntil {!(player in (units _this)) || {isNull _this}};
		//if (dialog) then {
		//	call FUNC(squadmanagementfill);
		//};
		[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;
		GVAR(sqtmgmtblocked) = false;
	};
};

// change selection on group list box event
FUNC(squadmgmtlbchanged) = {
	private ["_idc", "_car", "_idx", "_ctrl", "_diff", "_grp", "_disp", "_isKickVisible", "_isRankVisible", "_button", "_lbsel"];
	if (GVAR(sqtmgmtblocked)) exitWith {};
	PARAMS_2(_idc,_car);
	_idx = _car select 1;

    if (isNil "previousSelected") then {
        previousSelected = -1;
    };

	if (_idx == -1) exitWith {};	
	_diff = _idc - 2000;
    
	_grp = GVAR(SQMGMT_grps) select _diff;
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_button = 3000 + _diff;	
    _buttonKick = 8000 + _diff;	
    _buttonInvite = 9000 + _diff;
    _buttonRank = 10000 + _diff;	
    _isKickVisible = ctrlVisible _buttonKick;
    _isRankVisible = ctrlVisible _buttonRank;
    CTRL(_buttonRank) ctrlSetTextColor [1, 1, 0, 1];
    CTRL(_buttonRank) ctrlSetText localize "STRD_Rank";

	// hide kick,invite and rank buttons
    for "_i" from 0 to 49 do {
    	_ctrl = _disp displayCtrl (8000 + _i);
	    _ctrl ctrlShow false;
	    _ctrl ctrlEnable false;
        _ctrl = _disp displayCtrl (9000 + _i);
	    _ctrl ctrlShow false;
	    _ctrl ctrlEnable false;
	    _ctrl = _disp displayCtrl (10000 + _i);
	    _ctrl ctrlShow false;
	    _ctrl ctrlEnable false;
	};
    
    _ctrl = _car select 0;
	if (group player == _grp && {player == leader _grp}) then {
		_lbsel = _ctrl lbText _idx;			
		CTRL(_buttonKick) ctrlSetText localize "STRD_Remove";		
		if (name player != _lbsel) then {
            if (!_isKickVisible || {previousSelected != _idx}) then {

                // show kick button                    
                CTRL(_buttonKick) ctrlShow true;
                CTRL(_buttonKick) ctrlEnable true;
            } else {

                // show rank button
                CTRL(_buttonRank) ctrlShow true;
                CTRL(_buttonRank) ctrlEnable true;
            };			
	    };
		CTRL(_button) ctrlSetText localize "STRD_Leave";
	} else {	    	
	    if (player == leader (group player) && {group player != _grp}) then {

                // show invite button   
                CTRL(_buttonInvite) ctrlSetTextColor [0, 1, 0, 1];
                CTRL(_buttonInvite) ctrlSetText localize "STRD_Invite";
                CTRL(_buttonInvite) ctrlShow true;
                CTRL(_buttonInvite) ctrlEnable true;
        };
    }; 
	previousSelected = _idx;
};

// focus lost event on group list box
FUNC(squadmgmtlblostfocus) = {
	private ["_butidc", "_carray", "_ctrl", "_sel", "_disp", "_buctrl"];
	PARAMS_2(_butidc,_carray);
	_ctrl = _carray select 0;
	_sel = lbCurSel _ctrl;
    selectedUnit = _sel;
	if (_sel != -1) then {
		_ctrl lbSetCurSel -1;
	};
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_butidc = _butidc + 1000;
	_buctrl = CTRL(_butidc);
	if (ctrlText _buctrl == localize "STRD_Remove") then {
		_buctrl ctrlSetText localize "STRD_Leave";
	};
	_buttonKick = 8000 + _diff;	
    _buttonInvite = 9000 + _diff;
    _buttonRank = 10000 + _diff;
    CTRL(_buttonKick) ctrlShow false;
	CTRL(_buttonKick) ctrlEnable false;
	CTRL(_buttonInvite) ctrlShow false;
	CTRL(_buttonInvite) ctrlEnable false;
	CTRL(_buttonRank) ctrlShow false;
	CTRL(_buttonRank) ctrlEnable false;
};

// increase rank event
FUNC(squadmgmtrankbuttonclicked) = {
    private ["_lbidx", "_diff", "_ctrl", "_lbname", "_disp", "_grp"];
    if (GVAR(sqtmgmtblocked)) exitWith {};
    _lbidx = selectedUnit;
	if (_lbidx == -1) exitWith {};
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_diff = _this - 10000;		
	_ctrl = _disp displayCtrl (2000 + _diff);
	_lbname = _ctrl lbData _lbidx;
    _grp = GVAR(SQMGMT_grps) select _diff;
    if (group player == _grp && {player == leader _grp} && {_lbname != ""}) then {	    
		{
			if (name _x == _lbname) exitWith {
				//_grp selectLeader _x;
				[QGVAR(grpslead), [leader _grp, _grp, _x]] call FUNC(NetCallEventSTO);	
				[[player, _x], 
				 QGVAR(msg_teamlead), 
				 _grp,
				false, true] call BIS_fnc_MP;
			};
		} forEach (units _grp);
		//if (dialog) then {
		//	call FUNC(squadmanagementfill);
		//};	
		[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;
	};
};

// kick event
FUNC(squadmgmtkickbuttonclicked) = {
    private ["_lbidx", "_diff", "_ctrl", "_lbname", "_disp", "_grp"];
    if (GVAR(sqtmgmtblocked)) exitWith {};
    _lbidx = selectedUnit;
	if (_lbidx == -1) exitWith {};
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_diff = _this - 8000;		
	_ctrl = _disp displayCtrl (2000 + _diff);
	_lbname = _ctrl lbData _lbidx;
    _grp = GVAR(SQMGMT_grps) select _diff;
    if (group player == _grp && {player == leader _grp} && {_lbname != ""}) then {	    
		{
			if (name _x == _lbname) exitWith {
				[_x] joinSilent createGroup (side _x);
				[[player, _x], 
				 QGVAR(msg_kick), 
				 [(units group player) + [_x]],
				false, true] call BIS_fnc_MP;
			};
		} forEach (units _grp);
		//if (dialog) then {
		//	call FUNC(squadmanagementfill);
		//};
	};
	[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;
};

// invite event
FUNC(squadmgmtinvitebuttonclicked) = {
    private ["_lbidx", "_diff", "_ctrl", "_lbname", "_disp", "_grp"];
    if (GVAR(sqtmgmtblocked)) exitWith {};
    _lbidx = selectedUnit;
	if (_lbidx == -1) exitWith {};
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_diff = _this - 9000;		
	_ctrl = _disp displayCtrl (2000 + _diff);
	_lbname = _ctrl lbData _lbidx;
    _grp = GVAR(SQMGMT_grps) select _diff;    
	{
		if (name _x == _lbname) exitWith {		
			TB_Invites set [count TB_Invites, [_x, group player]];
            [[TB_Invites], QGVAR(set_invites), true, true, true] call BIS_fnc_MP;
			[[player, _x, str (group player)], 
			 QGVAR(msg_invite), 
			 (side (group player)),
			false, true] call BIS_fnc_MP;	
		};
	} forEach (units _grp);	
	//if (dialog) then {
	//	call FUNC(squadmanagementfill);
	//};
	[[], QGVAR(dialog_refresh), true, false, true] call BIS_fnc_MP;	
};