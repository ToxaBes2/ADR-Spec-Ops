/*
Author: ToxaBes
Description: attach explosive charges to objects
*/
C4_Attach = {
    _unit = _this select 0;    
    if (alive _unit && {(_unit distance (getMarkerPos "safezone_marker")) > 400}) then {
        _ins = lineIntersectsSurfaces [
            AGLToASL positionCameraToWorld [0,0,0], 
            AGLToASL positionCameraToWorld [0,0,3], 
            _unit
        ];
        if (count _ins > 0) then {
            _obj = _ins select 0 select 2;
            _objPos = _ins select 0 select 0;
            _objVectorUp = _ins select 0 select 1;
            if !(_obj isKindOf "Man") then {
                _explosive = nearestObject [_unit, "DemoCharge_Remote_Ammo"];        
                _explosive setPosASL _objPos;  
                _explosive setVectorUp _objVectorUp;
                _newPos = _obj worldToModel (position _explosive);       
                [_explosive, _obj, _newPos, _objVectorUp] remoteExec ["QS_fnc_attachMP", 0, TRUE];                
              	_unit setVariable ["charges",(_unit getVariable ["charges",[]]) + [_explosive]];
            };
        };
    };
};