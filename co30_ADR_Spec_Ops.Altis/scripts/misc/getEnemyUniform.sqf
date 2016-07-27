private ["_player", "_body", "_playerUniform", "_playerItems", "_playerMagazines", "_bodyUniform", "_bodyItems", "_bodyMagazines"];

_player = player;
_body = cursorTarget;

player playMove "AinvPknlMstpSnonWnonDnon";
sleep 2;

_playerUniform = uniform _player;
_playerItems = itemCargo uniformContainer _player;
_playerMagazines = magazineCargo uniformContainer _player;
_bodyUniform = uniform _body;
_bodyItems = itemCargo uniformContainer _body;
_bodyMagazines = magazineCargo uniformContainer _body;
_player forceAddUniform _bodyUniform;
_body forceAddUniform _playerUniform;
{
    _player addItem _x;
} forEach _playerItems;
{
    _player addMagazine _x;
} forEach _playerMagazines;
{
    _body addItem _x;
} forEach _bodyItems;
{
    _body addMagazine _x;
} forEach _bodyMagazines;
