/*
Author: Zerty
Description: restrict UAV connection distance
*/
_distance = 4000; // 4 km
if !((getConnectedUAV player) isKindOf "UAV_01_base_F") exitWith {};
if ((getConnectedUAV player) isKindOf "B_UAV_06_F") exitWith {};
if ((getConnectedUAV player) isKindOf "I_UAV_06_F") exitWith {};
if (([player,(getConnectedUAV player)] call BIS_fnc_distance2D) > _distance) exitWith {
	player connectTerminalToUAV objNull;
	hintSilent parseText format ["<t size='1.3' color='#ef4123'>Информация</t><br /><br />Потеряна связь с дартером. Максимальная дальность - <t color='#ccffaf'>%1 м</t>",_distance];
	0 spawn {sleep 5;hintSilent ""; };
};