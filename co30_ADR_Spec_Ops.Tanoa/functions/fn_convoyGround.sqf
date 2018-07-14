/*
Author: ToxaBes
Description: blufor ammo supply ground convoy
*/
waitUntil {!isNil "CURRENT_AO_POSITION"};
_s = 120 + random 60;
sleep _s;
_basePos = getMarkerPos "respawn_west";
_name = worldName;
_truck = "B_Truck_01_box_F";
_coords = "";
_endPos = [0,0];
_guards = [];
if (_name == "Altis") then {
	_endPos = [15266,17398];
	_coords = [
        [[16849,21867,0], [16869,21893,0], 214],
        [[14499,20520,0], [14499,20549,0], 185],
        [[10883,19022,0], [10856,19024,0], 91],
        [[10365,12443,0], [10384,12424,0], 315],
        [[9955,15962,0],  [9911,15976,0],  108],
        [[16019,11432,0], [15974,11424,0], 80],
        [[19702,15695,0], [19724,15655,0], 330],
        [[19008,13325,0], [19048,13303,0], 300],
        [[20663,16747,0], [20708,16757,0], 257],
        [[19924,19286,0], [19969,19297,0], 257],
        [[17129,19364,0], [17171,19382,0], 248],
        [[14029,12981,0], [14075,12978,0], 274]
    ];
    _guards = ["B_APC_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F","B_LSV_01_armed_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"];
};
if (_name == "Tanoa") then {
	_endPos = [6883,7382];
	_coords = [
        [[4353,8438,0],  [4318,8424,0],  66],
        [[5352,9885,0],  [5390,9883,0],  272],
        [[7562,10485,0], [7549,10518,0], 158],
        [[8588,10042,0], [8613,10066,0], 224],
        [[9870,9375,0],  [9899,9355,0],  304],
        [[11023,9735,0], [11035,9768,0], 198],
        [[9342,8534,0],  [9345,8569,0],  183],
        [[6028,9455,0],  [6061,9469,0],  246],
        [[10369,7287,0], [10396,7265,0], 309],
        [[9280,7520,0],  [9286,7485,0],  349],
        [[10242,6316,0], [10277,6322,0], 260],
        [[12269,6759,0], [12303,6769,0], 254],
        [[11172,5170,0], [11135,5168,0], 85]
    ];
    _guards = ["B_T_APC_Wheeled_01_cannon_F","B_T_AFV_Wheeled_01_up_cannon_F","B_T_LSV_01_armed_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"];
};
if (_name == "Malden") then {
	_endPos = [8107,9980];
	_coords = [
        [[5706,11164,0], [5659,11173,0], 101],
        [[4959,10251,0], [4943,10211,0], 21],
        [[5136,9066,0],  [5110,9033,0],  37],
        [[4643,6558,0],  [4617,6524,0],  37],
        [[7023,6809,0],  [7032,6769,0],  350],
        [[6091,7377,0],  [6051,7367,0],  73],
        [[4141,8006,0],  [4129,8047,0],  159],
        [[5318,9830,0],  [5281,9830,0],  90],
        [[3140,6329,0],  [3103,6338,0],  102],
        [[8491,7758,0],  [8491,7758,0],  336],
        [[5094,8631,0],  [5066,8605,0],  47],
        [[7860,6600,0],  [7896,6612,0],  251]
    ];
    _guards = ["B_APC_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F","B_LSV_01_armed_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"];
};

_data = _coords select 0;
_startPos = _data select 0;
_start2Pos = _data select 1;
_startDir = _data select 2;
if (!(isNil {CURRENT_AO_POSITION})) then {
	_dist = CURRENT_AO_POSITION distance2D _startPos;
    {
        _data = _x;
        _distTmp = CURRENT_AO_POSITION distance2D (_data select 0);
        if (_dist < _distTmp) then {
            _startPos = _data select 0;
            _start2Pos = _data select 1;
            _startDir = _data select 2;
            _dist = _distTmp;
        };
    } forEach _coords;
};

_veh1 = createVehicle [_truck, [50,50,500], [], 0, "NONE"];
_veh1 setPos _startPos;
_veh1 setDir _startDir;
createVehicleCrew _veh1;
_veh1 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
[_veh1, "QS_fnc_addActionUnloadAmmo", nil, true] spawn BIS_fnc_MP; 

_veh1 addMPEventHandler ["MPKilled", {
    hqSideChat = "Конвой с боеприпасами уничтожен!";
    publicVariable "hqSideChat"; 
    [WEST, "HQ"] sideChat hqSideChat;
    ARSENAL_ENABLED = false;
    publicVariable "ARSENAL_ENABLED";
}];

_guard = selectRandom _guards;
_veh2 = createVehicle [_guard, [40,40,400], [], 0, "NONE"];
switch (_guard) do { 
	case "B_APC_Wheeled_01_cannon_F" : {
        [
        	_veh2,
        	["Sand",1], 
        	["showBags",1,"showCamonetHull",0,"showCamonetTurret",0,"showSLATHull",1,"showSLATTurret",1]
        ] call BIS_fnc_initVehicle;
    }; 
	case "B_AFV_Wheeled_01_up_cannon_F" : {
        [
        	_veh2,
        	["Green",1], 
        	["showCamonetHull",0,"showCamonetTurret",0,"showSLATHull",1]
        ] call BIS_fnc_initVehicle;
    }; 
    case "B_APC_Tracked_01_rcws_F" : {
        [
        	_veh2,
        	["Sand",1], 
        	["showCamonetHull",0,"showBags",0]
        ] call BIS_fnc_initVehicle;
    };
    case "B_LSV_01_armed_F" : {
        [
        	_veh2,
        	["Olive",1]
        ] call BIS_fnc_initVehicle;
    };
    case "B_T_APC_Wheeled_01_cannon_F" : {
        [
        	_veh2,
        	["Olive",1], 
        	["showBags",0,"showCamonetHull",0,"showCamonetTurret",0,"showSLATHull",1,"showSLATTurret",1]
        ] call BIS_fnc_initVehicle;
    };
    case "B_T_AFV_Wheeled_01_up_cannon_F" : {
        [
        	_veh2,
        	["Green",1], 
        	["showCamonetHull",0,"showCamonetTurret",0,"showSLATHull",1]
        ] call BIS_fnc_initVehicle;
    };
    case "B_T_APC_Tracked_01_rcws_F" : {
        [
        	_veh2,
        	["Olive",1], 
        	["showCamonetHull",0,"showBags",0]
        ] call BIS_fnc_initVehicle;
    };
    case "B_T_LSV_01_armed_F" : {
        [
        	_veh2,
        	["Olive",1]
        ] call BIS_fnc_initVehicle;
    };
};

_veh2 setPos _start2Pos;
_veh2 setDir _startDir;
createVehicleCrew _veh2;
_veh2 addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];

_group1 = group _veh1;
_group2 = group _veh2;
[(units _group1)] call QS_fnc_setSkill4;
[(units _group2)] call QS_fnc_setSkill4;

{
    _x addCuratorEditableObjects [[_veh1], true];
} forEach allCurators;

_xCoord = floor ((_startPos select 0) / 100);
_yCoord = floor ((_startPos select 1) / 100);
if (_xCoord < 100) then {
    _xCoord = "0" + str _xCoord;
};
if (_yCoord < 100) then {
    _yCoord = "0" + str _yCoord;
};
_grid = format["%1%2", _xCoord, _yCoord];

_briefing = format ["<t align='center'><t size='1.5' color='#6B8E23'>Конвой с боеприпасами</t><br/>____________________<br/>Конвой в квадрате %1 запрашивает сопровождение до базы. <br/><br/>Через 10 мин конвой выдвигается самостоятельно.", _grid];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";

hqSideChat = format ["Конвой c боеприпасами а квадрате %1", _grid];
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat; 

if (!isNil "CONVOY_GROUPS") then {
    {
        _grp = _x;
        {
                deleteVehicle _x;
        } forEach units _grp;
        deleteGroup _grp;
    } forEach CONVOY_GROUPS;
};
CONVOY_GROUPS = [_group1, _group2];
publicVariable "CONVOY_GROUPS";
if (!isNil "CONVOY_VEHICLES") then {
    {
        _veh = _x;
        if !(typeOf _veh == "B_Slingload_01_Cargo_F") then {
            {
                deleteVehicle _x;
            } forEach crew _veh;
        };
        deleteVehicle _veh;
    } forEach CONVOY_VEHICLES;
};
CONVOY_VEHICLES = [_veh1, _veh2];
publicVariable "CONVOY_VEHICLES";

sleep 600; // 10 mins
_wp1 = _group1 addWaypoint [_endPos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointCompletionRadius 5;
_wp1 setWaypointFormation "COLUMN";
_wp1 setWaypointBehaviour "SAFE";
_wp1 setWaypointCombatMode "NO CHANGE";
_group1 setSpeedMode "LIMITED";
_group1 setBehaviour "SAFE";
_group1 setCombatMode "RED";
_group1 allowFleeing 0;
_group2 setSpeedMode "LIMITED";
_group2 setBehaviour "SAFE";
_group2 setCombatMode "RED";
_group2 allowFleeing 0;
while {true} do {                 
    sleep 5;
    while {(count (waypoints _group2)) > 0} do {
        deleteWaypoint ((waypoints _group2) select 0);
    };
    _wp2 = _group2 addWaypoint [position _veh1, 0];
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointCompletionRadius 5;
    _wp2 setWaypointSpeed "LIMITED";
    _wp2 setWaypointBehaviour "SAFE";                  
    if (_veh1 distance2D _basePos <= 200) exitWith {
        hqSideChat = "Боеприпасы доставлены на базу!";
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat;  

        ARSENAL_ENABLED = true;
        publicVariable "ARSENAL_ENABLED";
        ARSENAL_TIME = serverTime;
        publicVariableServer "ARSENAL_TIME";   
        try {
            {
                deleteVehicle _x;
            } forEach (units _group1);
            deleteGroup _group1;
            if !(side _veh1 == resistance) then {
                deleteVehicle _veh1;
            };
            {
                deleteVehicle _x;
            } forEach (units _group2);
            deleteGroup _group2;                    
            if !(side _veh2 == resistance) then {
                deleteVehicle _veh2;
            };                           
        } catch {};          
    };    
    if (!(canMove _veh1) || !(side _veh1 == west)) exitWith {
    	if (alive _veh1) then {
            _vehPos = getPos _veh1;
            _xCoord = floor ((_vehPos select 0) / 100);
            _yCoord = floor ((_vehPos select 1) / 100);
            if (_xCoord < 100) then {
                _xCoord = "0" + str _xCoord;
            };
            if (_yCoord < 100) then {
                _yCoord = "0" + str _yCoord;
            };
            _grid = format["%1%2", _xCoord, _yCoord];
            hqSideChat = format ["Конвой потерян в квадрате %1. Отправляйтесь на поиски!", _grid];
            publicVariable "hqSideChat"; 
            [WEST, "HQ"] sideChat hqSideChat; 
            sleep 900;
            if (alive _veh1) then {
                _fail = true;
                {
                    if (_x distance2D _veh1 < 100 && side _x == west) then {
                        _fail = false;
                    };
                } forEach AllPlayers;
                if (_fail) then {
                	hqSideChat = "Активирована система самоуничтожения груза!";
                    publicVariable "hqSideChat"; 
                    [WEST, "HQ"] sideChat hqSideChat;
                  	_veh1 setDamage 1;                	
                };     
            };  
        } else {
            try {
                {
                    deleteVehicle _x;
                } forEach (units _group1);
                deleteGroup _group1;
                {
                    deleteVehicle _x;
                } forEach (units _group2);
                deleteGroup _group2;                    
                if !(side _veh2 == resistance) then {
                    deleteVehicle _veh2;
                };                           
            } catch {};
        };          
    }; 
    if (!(alive _veh1)) exitWith {        
        try {
            {
                deleteVehicle _x;
            } forEach (units _group1);
            deleteGroup _group1;
            {
                deleteVehicle _x;
            } forEach (units _group2);
            deleteGroup _group2;                    
            if !(side _veh2 == resistance) then {
                deleteVehicle _veh2;
            };                           
        } catch {};
    };   
};

if (!(alive _veh1)) exitWith {        
    try {
        {
            deleteVehicle _x;
        } forEach (units _group1);
        deleteGroup _group1;
        {
            deleteVehicle _x;
        } forEach (units _group2);
        deleteGroup _group2;                    
        if !(side _veh2 == resistance) then {
            deleteVehicle _veh2;
        };                           
    } catch {};
};    