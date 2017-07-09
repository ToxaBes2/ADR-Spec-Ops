/*
Author: ToxaBes
Description: get classnames, qty and type for all items from cargo box include items in vests, backpacks etc.
*/
getCargoData = {        
    _box = _this select 0;
    _map = _this select 1;
    _data = [];
    _pistolMags = ["6Rnd_45ACP_Cylinder","9Rnd_45ACP_Mag","10Rnd_9x21_Mag","11Rnd_45ACP_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag",
    "16Rnd_9x21_green_Mag","16Rnd_9x21_yellow_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","30Rnd_9x21_Green_Mag",
    "30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_tracer_green","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
    "30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Mag_SMG_02_Tracer_Green"];
    _baseCfg = (configFile >> "cfgWeapons");
    _weaponsItems = weaponsItemsCargo _box;
    {
        _row = _x;
        //_cfg = _baseCfg >> (_row select 0);
        //while {isClass (_cfg >> "LinkedItems") } do {
        //    _parent = configName (inheritsFrom (_cfg));
        //    _cfg = _baseCfg >> _parent;
        //};
        //_cfg = configName _cfg;
        //_class = format ['"%1"', _cfg]; 
        //_data pushBack [_map,_class,1,'"weapon"']; 
        _save = true;
        if ((_row select 0) isKindOf "Pistol" || (_row select 0) isKindOf "Rifle_Short_Base_F") then {
            _save = false;
        };
        if (_save) then {                 
            _class = format ['"%1"', _row select 0];
            _data pushBack [_map,_class,1,'"weapon"'];
            if !((_row select 1) isEqualTo "") then {
                _class = format ['"%1"', _row select 1];
                _data pushBack [_map,_class,1,'"item"'];
            };
            if !((_row select 2) isEqualTo "") then {
                _class = format ['"%1"', _row select 2];
                _data pushBack [_map,_class,1,'"item"'];
            };
            if !((_row select 3) isEqualTo "") then {
                _class = format ['"%1"', _row select 3];
               _data pushBack [_map,_class,1,'"item"'];
            };
            if !((_row select 4) isEqualTo []) then {
                _mag = _row select 4;
                _class = format ['"%1"', _mag select 0];
                _data pushBack [_map,_class,1,'"magazine"'];                  
            };
            if !((_row select 5) isEqualTo "") then {
                _class = format ['"%1"',_row select 5];
                _data pushBack [_map,_class,1,'"item"'];
            }; 
        };
    } forEach _weaponsItems;
    _magazineItems = getMagazineCargo _box;
    _magazines = _magazineItems select 0;
    _magazineQty = _magazineItems select 1;     
    if (count _magazines > 0) then {
        _i = 0;
        {
            if !(_x in _pistolMags) then {
                _class = format ['"%1"', _x];
                _qty = _magazineQty select _i;
                _data pushBack [_map,_class,_qty,'"magazine"'];
            };
            _i = _i + 1;
        } forEach _magazines;
    };          
    _items = getItemCargo _box;
    _itemObjs = _items select 0;
    _itemQty = _items select 1;     
    if (count _itemObjs > 0) then {
        _i = 0;
        {
            _class = format ['"%1"', _x];
            _qty = _itemQty select _i;
            _type = "";
            if (isClass (configFile >> "CfgWeapons" >> _x)) then {
                if (configName (inheritsFrom (configFile >> "CfgWeapons" >> _x)) isEqualTo "ItemCore") then {
                    _type = '"item"';
                };
                if (_type isEqualTo "" && {configName (inheritsFrom (inheritsFrom (inheritsFrom (configFile >> "CfgWeapons" >> _x)))) isEqualTo "HelmetBase"}) then {
                     _type = '"headgear"';
                };
            };                
            if (_type isEqualTo "" && {isClass (configFile >> "CfgGlasses" >> _x)}) then {
                _type = '"glassess"';
            };         
            if !(_type isEqualTo "") then {
                _data pushBack [_map,_class,_qty,_type];
            };                      
            _i = _i + 1;
        } forEach _itemObjs;
    };
    _data
};

_cargo = _this select 0;
_map = _this select 1;
_result = [_cargo, _map] call getCargoData;
_containers = everyContainer _cargo;        
{
    _internalData = [];
    _qty = 1;
    _class = format ['"%1"', _x select 0];
    _obj = _x select 1;    
    _type = '"vest"';
    if (configName (inheritsFrom (configFile >> "CfgWeapons" >> _x select 0)) isEqualTo "Uniform_Base") then {
        _type = '"uniform"';
    };
    //if (_type isEqualTo "" && {configName (inheritsFrom(inheritsFrom (configFile >> "CfgWeapons" >> _x select 0))) isEqualTo "Vest_Camo_Base"}) then {
    //    _type = '"vest"';
    //};
    if (_type isEqualTo "" && {configName (inheritsFrom(inheritsFrom (configFile >> "CfgVehicles" >> _x select 0))) isEqualTo "Bag_Base"}) then {
        _type = '"backpack"';
    };
    _result pushBack [_map,_class,_qty,_type];
    _internalData = [_obj, _map] call getCargoData;
    if (count _internalData > 0) then {
        {
            _result pushBack _x;
        } forEach _internalData;
    };          
} forEach _containers; 
_result
