/*
Author: ToxaBes
Description: move vehicle to rewards list
*/
_player = _this select 0;
_side = side _player;     
if (_side == resistance) then {
    _boxName = "partizan_ammo";
    _holders = nearestObjects [getPos _player, ["GroundWeaponHolder","ReammoBox_F"], 30];
    {
        _box = _x;
        if (vehicleVarName _box != _boxName) then {            
            _weapon = getWeaponCargo _box;
            _mags = getMagazineCargo _box;
            _items = getItemCargo _box;
            _backpacks = getBackpackCargo _box;
            {
                _classes = _x select 0;
                _qtys = _x select 1;
                _idx = 0;
                {
                    _class = _x;
                    _qty = _qtys select _idx;
                    partizan_ammo addItemCargoGlobal [_class, _qty];    
                    _idx = _idx + 1;
                } forEach _classes;             
            } forEach [_weapon, _mags, _items, _backpacks];    
            deleteVehicle _box;
        }
    } forEach _holders;
};
["<t color='#7FDA0B' size = '.48'>Все снаряжение в радиусе 30м загружено в арсенал.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;