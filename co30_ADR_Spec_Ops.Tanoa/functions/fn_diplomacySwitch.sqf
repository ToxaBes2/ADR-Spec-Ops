/*
Author: ToxaBes
Description: change diplomation status between fractions.
*/
_value = _this select 0;
resistance setFriend [west, _value];
west setFriend [resistance, _value];
