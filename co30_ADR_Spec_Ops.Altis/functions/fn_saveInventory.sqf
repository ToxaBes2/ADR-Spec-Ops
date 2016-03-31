/*
Author: Quiksilver
Date modified: 12/10/2014 ArmA 1.30
*/

if (!isNil "saving_inventory" && {saving_inventory}) exitWith {hint "Сохранение снаряжения, пожалуйста ждите ...";};
saving_inventory = true;
respawnInventory_Saved = true;
hint "Снаряжение сохранено. При следующем возрождении, будет загружено ваше текущее снаряжение.";
[player,[player,"ClassGear"]] call BIS_fnc_saveInventory;
[] spawn {
	sleep 3;
	saving_inventory = false;
};