// http://forums.bistudio.com/showthread.php?176691-Making-placed-units-be-editable-for-every-Zeus
_curator = _this select 0;
_placed = _this select 1;

{
	_x addCuratorEditableObjects [(units _placed), true]
} forEach (allCurators - [_curator]);

nil