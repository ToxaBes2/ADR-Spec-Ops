// Author: malashin
// Field repair add action

_v = cursorTarget;
_dmgArray = getAllHitPointsDamage _v;
_heavyDmgArray = [];

{
	if (_x > 0.64) then {
		_heavyDmgArray set [count _heavyDmgArray, [((_dmgArray select 0) select _forEachIndex), _x]];
	};
} forEach (_dmgArray select 2);

_partsAmount = count _heavyDmgArray;
_vehicle_repairing = true;

while {_vehicle_repairing} do {
	scopeName "main";
	vehicle_repaired = true;
	{
		player playAction "MedicStartRightSide";
		_t = 0;

		while {_t < ((_x select 1) * 5)} do {
			sleep 0.1;
			_t = _t + 0.1;
			if ((!(alive player)) or ((player distance _v) > 7) or (vehicle player != player) or ((speed _v) > 3) or ((speed player) > 1) or (!(alive _v))) then {
				vehicle_repaired = false;
				breakTo "main";
			};
		};

		_v setHitPointDamage[(_x select 0), 0.64];
		systemChat format["%1/%2 %3 починен.", _forEachIndex + 1, _partsAmount, _x select 0];

		if ((_forEachIndex + 1) == _partsAmount) then {
			_vehicle_repairing = false;
			vehicle_repaired = true;
			[] spawn {
				sleep 30;
				vehicle_repaired = false;
			};
			systemChat format["Полевой ремонт %1 полностью завершен.", typeOf _v];
		};
	} forEach _heavyDmgArray;

	if (!vehicle_repaired) then {
		_vehicle_repairing = false;
		systemChat format["Полевой ремонт %1 прерван.", typeOf _v];
	};
};
