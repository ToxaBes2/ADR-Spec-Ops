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
    _obj = _x;
    switch (typeName _obj) do { 
    	case "GROUP" : {
    	    {
    	        [_x] call QS_fnc_TBdeleteObjects;
            } forEach (units _obj);  
            if (_obj in allGroups) then {
                deleteGroup _obj;
            };            	    
        }; 
    	case "OBJECT" : {
            if !(_obj isKindOf "Man") then {
			    {
			        deleteVehicle _x;
			    } forEach (crew _obj);
		    };
		    deleteVehicle _obj;
        }; 
        case "ARRAY" : {
            {
                [_x] call QS_fnc_TBdeleteObjects;
            } forEach _obj;   
        };
    	default {};
    };
} forEach _objects;