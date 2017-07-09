_justPlayers = allPlayers - entities "HeadlessClient_F";
pmenu = [["Переместить к себе", true]];
_n = 0;
pselect = "";
{
	if ((_x != player) && (getPlayerUID _x != "")) then {
		_arr = [format['%1', name _x], [12],  "", -5, [["expression", format ['pselect = "%1";', name _x]]], "1", "1"]; 
		_n = _n + 1;
        pmenu set [_n, _arr];
	};
} forEach _justPlayers;
pmenu set [(_n + 1), ["(separator)", [3], "", -1, [["expression", ""]], "1", "1"]];
pmenu set [(_n + 2), ["Выход", [1], "", -3, [["expression", ""]], "1", "1"]];

showCommandingMenu "#USER:pmenu";

waitUntil {pselect != ""};
if (pselect != "exit") then {
	_name = pselect;
	{
		if(name _x == _name) then
		{
			hint format ["Перемещаем %1", _name];
			_x action ["eject", vehicle _x];
			_x attachTo [vehicle player, [2, 2, 0]];
			["%1 перемещён", _name] call BIS_fnc_log;
			sleep 0.25;
			detach _x;
		};
	} forEach _justPlayers;
};