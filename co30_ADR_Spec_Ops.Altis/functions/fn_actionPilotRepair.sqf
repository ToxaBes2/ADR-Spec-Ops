// Author: malashin
// Field repair add action

_v = cursorTarget;
_dmgArray = getAllHitPointsDamage _v;
_heavyDmgArray = [0];

{
	if (_x > 0.64) then {
		if ((_dmgArray select 0) select _forEachIndex == "HitFuel") then {
			_heavyDmgArray set [0, [((_dmgArray select 0) select _forEachIndex), _x]];
		};
		if !((_dmgArray select 0) select _forEachIndex in ["HitFuel","Glass_1_hitpoint","Glass_2_hitpoint","Glass_3_hitpoint","Glass_4_hitpoint","Glass_5_hitpoint","Glass_6_hitpoint","Glass_7_hitpoint","Glass_8_hitpoint","Glass_9_hitpoint","Glass_10_hitpoint","Glass_11_hitpoint","Glass_12_hitpoint","Glass_13_hitpoint","Glass_14_hitpoint","Glass_15_hitpoint","Glass_16_hitpoint","Glass_17_hitpoint","Glass_18_hitpoint","Glass_19_hitpoint","Glass_20_hitpoint","Glass_Pod_01_hitpoint","Glass_Pod_02_hitpoint","Glass_Pod_03_hitpoint","Glass_Pod_04_hitpoint","Glass_Pod_05_hitpoint","Glass_Pod_06_hitpoint","Glass_Pod_07_hitpoint","Glass_Pod_08_hitpoint","Glass_Pod_09_hitpoint","HitGlass1","HitGlass2","HitGlass3","HitGlass4","HitGlass5","HitGlass6","HitGlass7","HitGlass8","HitGlass9","HitGlass10","HitGlass11","HitGlass12","HitGlass13","HitGlass14","HitGlass15","HitLGlass","HitRGlass"]) then {
			_heavyDmgArray set [count _heavyDmgArray, [((_dmgArray select 0) select _forEachIndex), _x]];
		};
	};
} forEach (_dmgArray select 2);

if ((_heavyDmgArray select 0) isEqualTo 0) then {
	_heavyDmgArray = _heavyDmgArray - [0];
};

systemChat str(_heavyDmgArray);
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
