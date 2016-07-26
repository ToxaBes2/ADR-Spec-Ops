private ["_deadBody", "_player", "_items", "_magazines"];
deadBody = cursorObject;
_player = player;
_items = itemCargo uniformContainer _player;
_magazines = magazineCargo uniformContainer _player;
_player forceAddUniform (uniform _deadBody);
removeUniform _deadBody;
{
    _player addItemToUniform _x;
} forEach _items;
{
    _player addMagazine _x;
} forEach _magazines;
