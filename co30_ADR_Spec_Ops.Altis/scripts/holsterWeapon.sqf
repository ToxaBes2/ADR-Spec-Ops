/*
Author: Phantom Wolf
Description: weapon holster.
*/
while {alive player} do {
    waitUntil {primaryWeapon player != "" or handgunWeapon player != ""};
    _unitholsteraction = player addAction ["Убрать оружие", {player action ["SWITCHWEAPON", player, player, -1];}, nil, -900, false, true];
    waitUntil {currentWeapon player == "" or {primaryWeapon player == "" && handgunWeapon player == ""}};
    if (primaryWeapon player == "" && handgunWeapon player == "") exitWith {
        player removeAction _unitholsteraction;
    };
    player removeAction _unitholsteraction;
    _unitequipprimaryactiontext = "Достать " + getText (configfile >> "CfgWeapons" >> primaryWeapon player >> "displayName");
    _unitequipprimaryaction = player addAction [_unitequipprimaryactiontext, {player action ["SWITCHWEAPON", player, player, 0];}, nil, 6, false, true];
    waitUntil {currentWeapon player != "" or primaryWeapon player == ""};
    player removeAction _unitequipprimaryaction;
};