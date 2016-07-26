private ["_deadBody", "_player", "_items", "_magazines"];
_deadBody = cursorObject;
_player = player;
_items = itemCargo uniformContainer _player;
_magazines = magazineCargo uniformContainer _player;
_uniform = format ["%1", uniform _deadBody];
_player forceAddUniform _uniform;
removeUniform _deadBody;
if (count _items > 0) then {
    {
        _player addItemToUniform _x;
    } forEach _items;
};
if (count _magazines > 0) then {
    {
        _player addMagazine _x;
    } forEach _magazines;
};