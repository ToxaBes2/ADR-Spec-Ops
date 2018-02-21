/*
Author: ToxaBes
Description: apply changes to RESISTANCE base depends of score
*/
_level = _this select 0;

// Base #1
if (_level > 0) then {
    _n = 0;
    {
        if (side _x == resistance) then {
            _n = _n + 1;
        };
    } forEach AllPlayers;
    if (_n > 0) then {
        _items = itemCargo partizan_ammo;
        if !("U_I_Wetsuit" in _items) then {
            partizan_ammo addItemCargoGlobal ["U_I_Wetsuit", (1 * _n)];
        };
        if !("V_RebreatherIA" in _items) then {
            partizan_ammo addItemCargoGlobal ["V_RebreatherIA", (1 * _n)];
        };
        if !("G_I_Diving" in _items) then {
            partizan_ammo addItemCargoGlobal ["G_I_Diving", (1 * _n)];
        };
        if !("arifle_SDAR_F" in _items) then {
            partizan_ammo addWeaponCargoGlobal ["arifle_SDAR_F", (1 * _n)];
        };
        if !("20Rnd_556x45_UW_mag" in _items) then {
            partizan_ammo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", (5 * _n)];
        };
    };
};