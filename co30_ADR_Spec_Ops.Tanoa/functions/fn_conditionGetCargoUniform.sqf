// Checks if cursorObjects GroundWeaponHolder has at least one CSAT or Civilian uniform

private ["_cargo", "_items", "_itemClass", "_cfgItem", "_type", "_infoType"];

scopeName "main";
_cargo = cursorObject;
if (typeOf _cargo == "GroundWeaponHolder") then {
    if (player distance _cargo <= 5) then {
        _items = everyContainer _cargo;
        {
            _itemClass = _x select 0;
            if ((_itemClass select [0, 4]) in ["U_O_", "U_C_"]) then {
                _cfgItem = configfile >> "cfgweapons" >> _itemClass;
                _type = getnumber (_cfgItem >> "type");
                if (istext (_cfgItem >> "type")) then {_type = gettext (_cfgItem >> "type") call bis_fnc_parsenumber};
                if (_type == 131072) then {
                    _infoType = getnumber (_cfgItem >> "itemInfo" >> "type");
                    if (_infoType == 801) then {
                        true breakOut "main";
                    };
                };
            };
        } forEach _items;
    };
};
false;
