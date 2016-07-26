/*
@filename: fn_vSetup02.sqf
Author:

	???

Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver

Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

private ["_u", "_t"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

_gh_huron = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F"]; 	// ghosthawk and huron
_huron = ["B_Heli_Transport_03_F"];																// huron
_taru = ["O_Heli_Transport_04_F"];																// taru
_taru_covered = ["O_Heli_Transport_04_covered_F"];												// taru covered
_strider = ["I_MRAP_03_F", "I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"];								// strider
_mh9 = ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "B_Heli_Light_01_stripped_F"];			// MH-9
_uav = ["B_UAV_02_CAS_F", "B_UAV_02_F", "B_UGV_01_F", "B_UGV_01_rcws_F"];						// UAVs
_hellcat = ["I_Heli_light_03_unarmed_F", "I_Heli_light_03_F"];									// Hellcat
_mohawk = ["I_Heli_Transport_02_F"];															// CH-49 Mohawk
_ammoTrucks = ["B_Truck_01_ammo_F", "O_Truck_02_Ammo_F", "I_Truck_02_ammo_F"];					// Ammo trucks with 10^12 ammo
_ammoTrucksTempest = ["O_Truck_03_ammo_F"];														// Ammo trucks with 30 000 ammo

if (_t in _strider) then {
	_u setObjectTextureGlobal [0, '\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
	_u setObjectTextureGlobal [1, '\A3\data_f\vehicles\turret_co.paa'];
};

if(_t in _mh9) then {
	_u addWeapon "CMFlareLauncher";
	_u addMagazine "168Rnd_CMFlare_Chaff_Magazine";
};

//if(_t in _huron) then {
//	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_03\Data\heli_transport_03_ext01_black_co.paa'];
//	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_03\Data\heli_transport_03_ext02_black_co.paa'];
//};

if(_t in _hellcat) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_epb\Heli_Light_03\Data\heli_light_03_base_co.paa'];
	_u addWeapon "Laserdesignator_mounted";
	_u addMagazine "Laserbatteries";
};

if(_t in _mohawk) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_beta\Heli_Transport_02\Data\skins\heli_transport_02_1_ion_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_beta\Heli_Transport_02\Data\skins\heli_transport_02_2_ion_co.paa'];
	_u setObjectTextureGlobal [2, 'A3\air_f_beta\Heli_Transport_02\Data\skins\heli_transport_02_3_ion_co.paa'];
};

if(_t in _taru) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa'];
};

if(_t in _taru_covered) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa'];
	_u setObjectTextureGlobal [2, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext01_black_co.paa'];
	_u setObjectTextureGlobal [3, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext02_black_co.paa'];
};

// UAV respawn fixer
if (_t in _uav) then {
	{deleteVehicle _x;} count (crew _u);
	[_u] spawn {
		_u = _this select 0;
		sleep 2;
		createVehicleCrew _u;
		_u setVariable ["uavHacker", 1];
	};
};

// Turret locking system
if (_t in _gh_huron) then {
	_u setVariable ["turrets_locked", true, true];
	[[_u, 1, "LMG_Minigun_Transport", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
	[[_u, 2, "LMG_Minigun_Transport2", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
};

// Ammo trucks
// Set ammo trucks cargo ammo to 32 562 ammo (one full AA rearm)
if ((_t in _ammoTrucks) or (_t in _ammoTrucksTempest)) then {
	while {true} do {
		call {
			if (_t in _ammoTrucks) exitWith {
				_u setAmmoCargo 0.000000032562; // 32 562 ammo
			};
			if (_t in _ammoTrucksTempest) exitWith {
				_u setAmmoCargo 1.08538;        // 32 562 ammo
			};
		};
		if (getAmmoCargo _u != 0) exitWith {}; // Due to very low values setAmmoCargo rounds to 0 on first try
	};
};

//===== Vehicle Killer monitor system
[_u] call QS_fnc_killerCatcher;
