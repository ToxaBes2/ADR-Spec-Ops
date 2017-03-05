/*
Author: ToxaBes
Description: create second command center in AO.
Format: [_positionAO, _addAction] call QS_fnc_createSecondCommandCenter;
*/
if (!isServer) exitWith {};
_centerPos = _this select 0;
_addAction = _this select 1;
_compositions = [
    [
        ["Land_HBarrierWall6_F",[-3.14258,4.88281,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[-8.70117,4.27344,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HelipadSquare_F",[9.07422,-1.24414,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_HQ_V4_F",[-6.45313,-7.1875,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_LampShabby_F",[-10.709,3.11914,-1.20689],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corner_F",[-2.22656,12.0996,0],270,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_House_V4_F",[-8.24805,8.85742,0],90,1,0,[0,-0],"","",true,false],        
        ["Land_HBarrierWall6_F",[3.04883,13.7734,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall4_F",[5.77344,-12.8926,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[-9.20117,13.5234,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corridor_F",[0.521484,-16.1426,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall4_F",[12.2734,12.8574,0],0,1,0,[0,0],"","",true,false], 
        ["Land_CncShelter_F",[4.5332,-17.6465,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[19.6895,-4.91797,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_5_F",[-14.2305,-10.8945,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_3_F",[-13.3398,-15.166,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[-20.3926,-3.61719,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corridor_F",[8.52344,17.6094,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrierWall6_F",[19.4395,7.58203,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrierWall4_F",[-15.4766,12.3574,-0.437613],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[6.85547,-18.6777,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall4_F",[15.5234,-12.6426,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[-20.6426,4.63281,-0.437616],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corner_F",[-0.226563,-20.3848,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrierWall4_F",[-4.72656,-20.8926,0],180,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Patrol_V4_F",[11.2715,-19.1387,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corner_F",[17.6641,13.0078,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[-20.1426,-11.8672,0],270,1,0,[0,0],"","",true,false],         
        ["Land_HBarrierWall_corner_F",[18.7734,-12.1348,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_LampShabby_F",[18.9473,-12.8398,-1.23911],315,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corner_F",[-19.7266,11.8496,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall6_F",[-11.002,-22.3086,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[15.1914,-18.6074,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_Cargo_Patrol_V4_F",[25.0195,0.605469,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[24.3086,-3.56055,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-23.1445,8.32227,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[24.2383,4.77539,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[11.9883,-21.9746,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall4_F",[-18.7266,-16.8926,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-23.1445,10.3223,0],270,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Tower_V4_F",[-20.2988,8.25195,-1.24274],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-25.1445,8.32227,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-25.1445,10.3223,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[27.6055,1.57227,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrierWall_corner_F",[-18.2188,-21.3926,0],180,1,0,[0,0],"","",true,false], 
        ["Land_LampShabby_F",[-19.1738,-21.8164,-1.25321],45,1,0,[0,0],"","",true,false],
        ["O_HMG_01_high_F",[3.23633,-21.9023,-0.0871181],179.999,1,0,[0.000639001,-0.000151255],"","",true,false], 
        ["O_HMG_01_high_F",[-8.97656,-13.4102,4],180.005,1,0,[-0.314765,-0.00208143],"","",true,false], 
        ["O_HMG_01_high_F",[9.02148,9.14453,-0.0871191],356.101,1,0,[-0.000506917,0.00014014],"","",true,false]
    ],
    [
        
        ["Land_Cargo_House_V4_F",[5.10352,-0.367188,-0.437613],90,1,0,[0,-0],"","",true,false], 
        ["Land_Cargo_Patrol_V4_F",[-4.80664,5.36523,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-8.46484,2.48047,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-3.28516,-9.18555,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-5.47656,8.13477,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[9.56055,2.61719,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[6.18359,7.86719,0],0,1,0,[0,0],"","",true,false], 
        ["Land_FieldToilet_F",[7.27148,-7.11133,7.62939e-006],88.722,1,0,[0.00191875,0.000955273],"","",true,false], 
        ["Land_HBarrier_Big_F",[-8.29297,-6.01367,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[5.03516,-9.14648,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[9.95703,-6.01367,0],270,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Tower_V4_F",[-1.44727,-4.70898,0],180,1,0,[0,0],"","",true,false],
        ["O_HMG_01_high_F",[0.933594,1.55664,-0.0871191],0.00238449,1,0,[-0.000433989,0.000269783],"","",true,false], 
        ["B_GMG_01_high_F",[-3.03906,5.25195,4],359.999,1,0,[0.000374051,6.23374e-005],"","",true,false]        
    ]
];

_newObjs = [];
_multiplyMatrixFunc =
{
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;
	_result = [
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];
	_result
};
if (isNil "CLEAR_POSITIONS") then {
    CLEAR_POSITIONS = [];
};
_pos = [_centerPos, 0, 600, 20, 0, 3, 0, []] call QS_fnc_findSafePos;
if (format ["%1", _pos] != "[0,0,0]") then {
    CLEAR_POSITIONS pushBack [_pos, 50];
    _staticGroup = createGroup east;
    _azi = 180; // important for furniture spawn
    _objs = selectRandom _compositions;    
    _posX = _pos select 0;
    _posY = _pos select 1;
    {		
    	_type = _x select 0;
    	_relPos = _x select 1;
    	_azimuth = _x select 2;
    	if ((count _x) > 3) then {_fuel = _x select 3};
    	if ((count _x) > 4) then {_damage = _x select 4};
    	if ((count _x) > 5) then {_orientation = _x select 5};
    	if ((count _x) > 6) then {_varName = _x select 6};
    	if ((count _x) > 7) then {_init = _x select 7};
    	if ((count _x) > 8) then {_simulation = _x select 8};
    	if ((count _x) > 9) then {_ASL = _x select 9};
    	private ["_rotMatrix", "_newRelPos", "_newPos"];
    	_rotMatrix =
    	[
    		[cos _azi, sin _azi],
    		[-(sin _azi), cos _azi]
    	];
    	_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;	
    	private ["_z"];
    	if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
    	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
    	_newObj = _type createVehicle _newPos;
    	_newObj setDir (_azi + _azimuth);
    	_newObj setPos _newPos;		
    	if (!isNil "_fuel") then {_newObj setFuel _fuel};
    	if (!isNil "_damage") then {_newObj setDamage _damage;};
    	if (!isNil "_orientation") then 
    	{
    		if ((count _orientation) > 0) then 
    		{
    			([_newObj] + _orientation) call BIS_fnc_setPitchBank;
    		};
    	};
    	if (!isNil "_varName") then {
    		if (_varName != "") then {
        		_newObj setVehicleVarName _varName;
        		call (compile (_varName + " = _newObj;"));
        	};
        };
        if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));};
        if (!isNil "_simulation") then {_newObj enableSimulation _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};    
        if (typeOf _newObj in ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AT_F"]) then {
            _newObj addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
            "O_T_Support_MG_F" createUnit [[0,0,0], _staticGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
            currentGunner assignAsGunner _newObj;
            currentGunner moveInGunner _newObj;
        };
        if (typeOf _newObj in ["Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V4_F"]) then {
        	if (_addAction) then {
        	    {
                    _x addCuratorEditableObjects [[_newObj], true];
                } forEach allCurators;  
                _newObj addMPEventHandler ["MPKilled", {MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";}];            
        	};
            _newObj allowDamage false;
            _newObj addEventHandler ["HandleDamage", {0}]; 
            _bunkerObjects = [_newObj, _addAction] call QS_fnc_addFurniture;
            _newObjs = _newObjs + _bunkerObjects;
        };
        _newObjs pushBack _newObj;
    } forEach _objs;    
    _bunkerGroup = [_pos, 30, 10, east] call QS_fnc_FillBots;
    _cargoPostGroups = [_pos, 30, east] call QS_fnc_FillCargoPatrol;          
    
    _staticGroup setBehaviour "COMBAT";
    _staticGroup setCombatMode "RED";
    [(units _staticGroup)] call QS_fnc_setSkill4;
};
publicVariable "CLEAR_POSITIONS";
_newObjs