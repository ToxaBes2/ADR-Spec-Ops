/*
Author: ToxaBes
Description: Change thermal vision with night vision on targeting pods during the day.
*/
private ["_player", "_vehicle"];
_player = _this select 0;
_vehicle = _this select 1;
if ((_vehicle isKindOf "Air") && (_vehicle getCargoIndex _player == -1)) then {
	while {vehicle _player == _vehicle} do {		
        if (daytime <= 20 && daytime > 4 && BLUFOR_BASE_SCORE < 32) then {
            _vehicle disableTIEquipment true;
            _vehicle disableNVGEquipment true;
        } else {
            _vehicle disableTIEquipment false;
            _vehicle disableNVGEquipment false;
        };		
        sleep 60;
	};
};
