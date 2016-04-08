/*
  Author: ToxaBes
  Description: disable all electronic devices wile EW is alive
*/
if (!hasInterface || isDedicated) exitWith {};
_launchers = ["launch_B_Titan_F","launch_I_Titan_F","launch_O_Titan_F","launch_Titan_F","launch_B_Titan_short_F", "launch_I_Titan_short_F", "launch_O_Titan_short_F","launch_Titan_short_F","launch_NLAW_F"];
_static    = ["B_static_AA_F","O_static_AA_F","I_static_AA_F","B_static_AT_F","O_static_AT_F","I_static_AT_F"];
_vehicles  = [];
while {EW_ATTACK} do {

    // Remove personal AT
    if (currentWeapon player in _launchers) then {
		hint "Оборудование не работает!";
		player action ["WeaponOnBack", player];
		sleep 3;
		hint "";
	};

    // Remove from static AT
	if(vehicle player != player) then {
		_veh = vehicle player;		
		if({typeOf _veh == _x} count _static > 0) then {
			player action ["getOut", _veh];
			hint "Отказ системы наведения!";			
		};
		if !(_veh in _vehicles) then {
		    _veh disableTIEquipment true;
		    _vehicles set [count _vehicles, _veh];
	    };
	    sleep 3;
		hint "";
	};
    
    // disable UAV usage
	if !(isNull (getConnectedUAV player)) then {
		hint "Сбой свзи с БПЛА/БПА!";
		getConnectedUAV player action ["BackFromUAV", player];
		getConnectedUAV player action ["UAVTerminalReleaseConnection", player];		
		sleep 3;
		hint "";
	};

    // Disable thermal and night vision
	if (currentVisionMode player != 0 ) then {   
		cutText ["Оборудование вышло из строя, нажмите N для перезагрузки.", "BLACK", -1];
		waituntil {currentVisionMode player == 0};
		0 cutFadeOut 0;		
	};

    sleep 1;
};

// return all things back
{
    _x disableTIEquipment false;
} forEach _vehicles;
