/*
Author: ToxaBes
Description: get rewards list by side
*/
_side = _this select 0; // 0-blufor, 1-resistance
_data = [];
_rewards = [];
if (_side == 0) then {
    _rewards = BLUFOR_REWARDS_LIST;
} else {
	_rewards = PARTIZAN_REWARDS_LIST;
};
if (count _rewards > 0) then {
    {
        //if !(_x in _data) then {
            _data pushBack _x;
        //};
    } forEach _rewards;
};
_data
