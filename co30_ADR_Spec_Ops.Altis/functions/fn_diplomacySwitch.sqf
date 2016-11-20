/*
Author: ToxaBes
Description: change diplomation status between fractions.
*/
_value = _this select 0;
resistance setFriend [west, _value];
west setFriend [resistance, _value];
if (_value == 0) then {
    {
        _uav = _x;
        {
            _x disableAI "TARGET";
            _x disableAI "AUTOTARGET";
            _x enableAI "TARGET";
            _x enableAI "AUTOTARGET";
        } forEach (crew _uav);
    } forEach allUnitsUAV;
};