_deadBody = _this select 0;
_player = _this select 1;
_actionId = _this select 2;
_items = itemCargo uniformContainer _player;
_magazines = magazineCargo uniformContainer _player;
_deadBody removeAction _actionId;
_player forceAddUniform (uniform _deadBody);
removeUniform _deadBody;
{
    _player addItemToUniform _x;
} forEach _items;
{
	_player addMagazine _x;
} forEach _magazines;