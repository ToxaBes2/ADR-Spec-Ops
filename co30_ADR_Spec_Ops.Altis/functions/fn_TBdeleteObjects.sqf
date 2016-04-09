/*
Author: ToxaBes (Based on logic from EOS_Bastion by BangaBob)
Description: delete unites, vehicles, groups
Format: [objects] call QS_fnc_TBdeleteObjects;
*/
_objects = _this select 0;
if (typeName _objects != "ARRAY") then {
    _objects = [_objects];
};
{
    switch (typeName _x) do { 
    	case "GROUP" : {
    	    {
    	        [_x] call QS_fnc_TBdeleteObjects;
            } forEach (units _x);    
            deleteGroup _x;	    
        }; 
    	case "OBJECT" : {
            if !(_x isKindOf "Man") then {
			    {
			        deleteVehicle _x;
			    } forEach (crew _x);
		    };
		    deleteVehicle _x;
        }; 
        case "ARRAY" : {
            [_x] call QS_fnc_TBdeleteObjects;
        };
    	default {};
    };
} forEach _objects;