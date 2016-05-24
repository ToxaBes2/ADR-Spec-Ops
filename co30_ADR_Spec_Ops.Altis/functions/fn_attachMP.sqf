/*
Author: ToxaBes
Description: attach one object to another
*/
_explosive = _this select 0;
_obj = _this select 1;
_newPos = _this select 2;
_objVectorUp = _this select 3;
if !(isNull _explosive || isNull _obj) then {
    _explosive attachTo [_obj, _newPos];    
    _explosive setVectorUp _objVectorUp;
};