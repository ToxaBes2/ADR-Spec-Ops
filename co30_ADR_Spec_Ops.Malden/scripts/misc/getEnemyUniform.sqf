private ["_player", "_body", "_playerUniform", "_playerUniformObject", "_playerItems", "_playerMagazines", "_playerWeapons", "_bodyUniform", "_bodyItems", "_bodyMagazines"];

_player = player;
_body = cursorObject;

player playMove "AinvPknlMstpSnonWnonDnon";
sleep 2;

_playerUniform = uniform _player;
if (_playerUniform != "") then {
    _playerUniformObject = uniformContainer _player;
    _playerItems = itemCargo _playerUniformObject;
    _playerMagazines = magazineCargo _playerUniformObject;
    _playerWeapons = weaponCargo _playerUniformObject;
};

_bodyUniform = uniform _body;
_bodyItems = itemCargo uniformContainer _body;
_bodyMagazines = magazineCargo uniformContainer _body;
_player forceAddUniform _bodyUniform;

{
    _body addItem _x;
} forEach _bodyItems;
{
    _body addMagazine _x;
} forEach _bodyMagazines;

if (_playerUniform != "") then {
    _body forceAddUniform _playerUniform;
    {
        _player addItem _x;
    } forEach _playerItems;
    {
        _player addMagazine _x;
    } forEach _playerMagazines;
};
