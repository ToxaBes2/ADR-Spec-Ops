// Put first CSAT or Civilian uniform from GroundWeaponHolder on player, transfers items from one uniform to another

private ["_cargo", "_items", "_itemClass", "_cfgItem", "_type", "_infoType", "_uniform", "_player", "_playerUniform", "_playerUniformObject", "_playerItems", "_playerMagazines", "_playerWeapons", "_cargoUniformClass", "_cargoUniformObject", "_cargoUniformItems", "_cargoUniformMagazines", "_cargoUniformWeapons", "_cargoItems", "_newCargo"];

// Get the cursorObject
_cargo = cursorObject;

// Find first CSAT or Civilian uniform
if (typeOf _cargo == "GroundWeaponHolder") then {
    _items = everyContainer _cargo;
    {
        scopeName "loop";
        _itemClass = _x select 0;
        if ((_itemClass select [0, 4]) in ["U_O_", "U_C_"]) then {
            _cfgItem = configfile >> "cfgweapons" >> _itemClass;
            _type = getnumber (_cfgItem >> "type");
            if (istext (_cfgItem >> "type")) then {_type = gettext (_cfgItem >> "type") call bis_fnc_parsenumber};
            if (_type == 131072) then {
                _infoType = getnumber (_cfgItem >> "itemInfo" >> "type");
                if (_infoType == 801) then {
                    _uniform = _x;
                    breakOut "loop";
                };
            };
        };
    } forEach _items;
};

// If uniform is found
if (!isNil {_uniform}) then {
    _player = player;

    // Play animation
    _player playMove "AinvPknlMstpSnonWnonDnon";
    sleep 2;

    // Store information about players uniform and its items
    _playerUniform = uniform _player;
    if (_playerUniform != "") then {
        _playerUniformObject = uniformContainer _player;
        _playerItems = itemCargo _playerUniformObject;
        _playerMagazines = magazineCargo _playerUniformObject;
        _playerWeapons = weaponCargo _playerUniformObject;
    };

    // Store information about found uniform and its items
    _cargoUniformClass = _uniform select 0;
    _cargoUniformObject = _uniform select 1;
    _cargoUniformItems = itemCargo _cargoUniformObject;
    _cargoUniformMagazines = magazineCargo _cargoUniformObject;
    _cargoUniformWeapons = weaponCargo _cargoUniformObject;
    _cargoItems = itemCargo _cargo;
    _cargoItems deleteAt (_cargoItems find _cargoUniformClass);

    // Change players uniform
    _player forceAddUniform _cargoUniformClass;

    // Remove all items from the GroundWeaponHoler (Can't remove single item)
    clearItemCargoGlobal _cargo;

    // Create new GroundWeaponHolder to store the items (old one might get deleted if there were no weapons or magazines in it)
    _newCargo = createVehicle ["GroundWeaponHolder", getPos _player, [], 0, "CAN_COLLIDE"];

    // Add items to the new GroundWeaponHolder
    {
        _newCargo addItemCargoGlobal [_x, 1];
    } forEach _cargoItems;
    {
        _newCargo addItemCargoGlobal [_x, 1];
    } forEach _cargoUniformItems;
    {
        _newCargo addMagazineCargoGlobal [_x, 1];
    } forEach _cargoUniformMagazines;
    {
        _newCargo addWeaponCargoGlobal [_x, 1];
    } forEach _cargoUniformWeapons;


    if (_playerUniform != "") then {
        // Add players uniform to the new GroundWeaponHolder
        _newCargo addItemCargoGlobal [_playerUniform, 1];

        // Add items to the player
        {
            _player addItem _x;
        } forEach _playerItems;
        {
            _player addMagazine _x;
        } forEach _playerMagazines;
        {
            _player addWeapon _x;
        } forEach _playerWeapons;
    };
};
