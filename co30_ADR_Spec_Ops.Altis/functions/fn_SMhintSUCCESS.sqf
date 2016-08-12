private ["_smRewards", "_smMarkerList", "_veh", "_vehName", "_vehVarname", "_reward", "_crew", "_grp", "_completeText", "_lockTime"];

_smRewards =
[
	["То-199 «Неофрон» (штурмовик)", "O_Plane_CAS_02_F"],
	["А-164 «Вайпаут» (штурмовик)", "B_Plane_CAS_01_F"],
	["Ми-48 «Кайман»", "O_Heli_Attack_02_black_F"],
	["AH-99 «Блэкфут»", "B_Heli_Attack_01_F"],
	["ПО-30 «Касатка»", "O_Heli_Light_02_F"],
	["AFV-4 «Горгона»", "I_APC_Wheeled_03_cannon_F"],
	["БТР-К «Камыш»", "O_APC_Tracked_02_cannon_F"],
	["ЗСУ-39 «Тигр»", "O_APC_Tracked_02_AA_F"],
	["IFV-6a «Гепард»", "B_APC_Tracked_01_AA_F"],
	["T-100 «Варсук»", "O_MBT_02_cannon_F"],
	["MBT-52 «Кума»", "I_MBT_03_cannon_F"],
	["M2A4 «Сламмер» UP", "B_MBT_01_TUSK_F"],
	["Страйдер с пулеметом", "I_MRAP_03_hmg_F"],
	["FV-720 «Мора»", "I_APC_tracked_03_cannon_F"],
	["MSE-3 «Марид» с НУРС", "O_APC_Wheeled_02_rcws_F"],
	["M2A1 «Сламмер»", "B_MBT_01_cannon_F"],
	["M5 РСЗО «Сэндсторм»", "B_MBT_01_mlrs_F"],
	["M4 «Скорчер»", "B_MBT_01_arty_F"],
	["MQ-12 Falcon", "B_T_UAV_03_F"],
	["KH-3A Fenghuang", "O_T_UAV_04_CAS_F"],
	["V-44 X Blackfish", "B_T_VTOL_01_armed_F"],
	["Qilin", "O_T_LSV_02_armed_F"],
	["Y-32 Xi'an", "O_T_VTOL_02_vehicle_F"]
];

_smMarkerList =
["smReward1", "smReward2", "smReward3", "smReward4", "smReward5", "smReward6", "smReward7", "smReward8", "smReward9", "smReward10", "smReward11", "smReward12", "smReward13", "smReward14", "smReward15", "smReward16", "smReward17", "smReward18", "smReward19", "smReward20", "smReward21", "smReward22", "smReward23", "smReward24", "smReward25", "smReward26", "smReward27"];

_veh = selectRandom _smRewards;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1", _smMarkerList, 0, "NONE"];

waitUntil {!isNull _reward};

if (_vehVarname in ["B_T_UAV_03_F", "O_T_UAV_04_CAS_F"]) then {
	createVehicleCrew _reward;
	_crew = crew _reward;
	_grp = createGroup WEST;
	_crew joinSilent _grp;
	_grp addVehicle _reward;
	{
	    _x setName "[AI]";
	} forEach units _grp;
};

[_reward] call QS_fnc_killerCatcher;
_reward setDir 135;
_reward setVariable ["IS_REWARD", true];

if (count sideMarkerText == 2) then {
    sideMarkerText = sideMarkerText select 0;
};

if (_this select 0) then {
	_completeText = format["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#C6FF00'>Выполнена</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t><br/><br/>Ожидайте дальнейших указаний.</t>", _vehName];
	showNotification = ["CompletedSpecMission", sideMarkerText, west];
} else {
	_completeText = format["<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#C6FF00'>Выполнено</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t><br/><br/>Ожидайте дальнейших указаний.</t>", _vehName];
	showNotification = ["CompletedSideMission", sideMarkerText, west];
};

GlobalSideHint = [west, _completeText]; publicVariable "GlobalSideHint"; (parseText _completeText) remoteExec ["hint", west];
publicVariable "showNotification"; 
showNotification = ["Reward", _vehName, west]; publicVariable "showNotification";

// Add stuff to custom reward vehicles
call {
	if (_reward isKindOf "I_APC_Wheeled_03_cannon_F") exitWith {
		_reward setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"];
		_reward setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"];
		_reward setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"];
		_reward setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
	};

	if (_reward isKindOf "O_APC_Wheeled_02_rcws_F") exitWith {
		_reward addWeapon ("Rocket_04_AP_Plane_CAS_01_F");
		_reward addMagazine ("7Rnd_Rocket_04_AP_F");
		_reward addWeapon ("Rocket_04_HE_Plane_CAS_01_F");
		_reward addMagazine ("7Rnd_Rocket_04_HE_F");
	};

	if (_reward isKindOf "B_MBT_01_arty_F") exitWith {
		_reward removeMagazine ("6Rnd_155mm_Mo_AT_mine");
		_reward removeMagazine ("6Rnd_155mm_Mo_mine");
	};
};

// Setting reward vehicle timmer.
_lockTime = 300;

// Spawn vehicle lock, timer and Draw3D EH in different thread.
[_reward, _lockTime] spawn {
	_reward = _this select 0;
	_lockTime = _this select 1;

	_reward lock 3;
	sleep _lockTime;
	_reward lock 0;
};
