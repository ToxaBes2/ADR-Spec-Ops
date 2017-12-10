/*
Author: ToxaBes
Description: create bunker in AO.
Format: [_centerPos] call QS_fnc_createSmallBunkers;
*/
if (!isServer) exitWith {};
_centerPos = _this select 0;
_compositions = [
    [
    	["Land_DuctTape_F",[-1.40234,-2.73242,2.38419e-007],33.5598,1,0,[-0.000790343,-0.000646716],"","",true,false], 
    	["Land_Canteen_F",[-1.73047,-2.69727,4.22001e-005],73.2517,1,0,[0.0792239,0.0278278],"","",true,false], 
    	["Land_Ammobox_rounds_F",[-1.66406,-3.05273,-0.000163317],36.7604,1,0,[-0.00276711,-0.058259],"","",true,false], 
    	["Land_TentA_F",[-0.160156,-3.43555,0],42.6576,1,0,[0,0],"","",true,false], 
    	["Land_Ammobox_rounds_F",[-2.05664,-3.00586,-0.000164032],80.3274,1,0,[-0.00255427,-0.058389],"","",true,false], 
    	["Land_PainKillers_F",[-3.66602,-3.29492,-0.0124378],5.04288,1,0,[0.000567296,0.000157558],"","",true,false], 
    	["Land_TentA_F",[-4.53125,-1.93164,0],357.658,1,0,[0,0],"","",true,false], 
    	["Land_Canteen_F",[-3.53906,-3.55273,-0.0134845],42.9375,1,0,[0.0882785,0.0261477],"","",true,false], 
    	["Land_Cargo_Patrol_V3_F",[1.08789,2.44336,0],180,1,0,[0,0],"","",true,false], 
    	["Land_TentA_F",[2.21094,-6.3125,0],57.6576,1,0,[0,0],"","",true,false], 
    	["FirePlace_burning_F",[-3.53906,-6.92773,-9.53674e-007],311.909,1,0,[0,0],"","",true,false], 
    	["Land_PaperBox_open_full_F",[-9.99609,-0.0253906,0],77.926,1,0,[0,0],"","",true,false], 
    	["Land_Sacks_heap_F",[-10.0391,1.44727,0],38.971,1,0,[0,0],"","",true,false], 
    	["CamoNet_OPFOR_F",[-9.98828,-2.45117,0],270,1,0,[0,0],"","",true,false], 
    	["Land_CanisterFuel_F",[-9.19141,-4.92188,5.34058e-005],329.982,1,0,[0.0486788,0.00304139],"","",true,false], 
    	["Land_CanisterFuel_F",[-9.51367,-4.64063,5.14984e-005],359.928,1,0,[0.0464155,0.00347303],"","",true,false], 
    	["Land_Pallet_F",[-8.71484,-6.41797,0],142.008,1,0,[1.76601e-007,-3.3092e-006],"","",true,false], 
    	["Land_Pallets_stack_F",[-10.5684,-5.08984,0],145.232,1,0,[-0.000267888,0.000246785],"","",true,false], 
    	["Land_PaperBox_closed_F",[-10.5391,-7.41406,0],15,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_BagBunker_Tower_F",[0.615234,1.03125,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-0.261719,-2.50977,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[3.07227,-2.37305,0],90,1,0,[0,-0],"","",true,false], 
    	["O_HMG_01_high_F",[2.23242,1.07227,2.8],98.8457,1,0,[-0.000638739,0.000450781],"","",true,false], 
    	["Land_TTowerSmall_1_F",[-1.19727,-2.27148,0],0,1,0,[0,0],"","",true,false]
    ],
    [
    	["Land_WoodenTable_large_F",[2.08789,-0.865234,-1.19209e-006],149.998,1,0,[-0.000248454,-0.00019081],"","",true,false], 
    	["Land_CampingChair_V2_F",[1.70313,-1.77148,2.12193e-005],210.002,1,0,[0.0018457,-0.00227903],"","",true,false], 
    	["Land_CampingChair_V2_F",[2.50195,-0.15625,2.0504e-005],75.0017,1,0,[0.00224206,-0.00293259],"","",true,false], 
    	["CamoNet_OPFOR_open_F",[1.84961,-0.589844,-0.864586],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagBunker_Tower_F",[-4.23828,-0.451172,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[-2.03711,4.87695,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[-5.4043,-0.615234,0],275,1,0,[0,0],"","",true,false], 
    	["Land_WaterBarrel_F",[4.42383,3.42969,1.52588e-005],0.000413845,1,0,[0.00142867,0.00170851],"","",true,false], 
    	["O_static_AT_F",[-4.26758,0.757813,2.8],0.00170229,1,0,[0.000257401,-0.000972304],"","",true,false], 
    	["Land_HBarrier_5_F",[5.95898,4.38281,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_End_F",[2.27734,6.16016,-0.00100017],355,1,0,[0,0],"","",true,false], 
    	["O_GMG_01_high_F",[-0.0273438,6.33594,-0.0868106],359.999,1,0,[0.000294497,-0.00024421],"","",true,false], 
    	["Land_HBarrier_5_F",[1.58984,5.25586,0],3.41509e-005,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-1.06055,-5.50195,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Long_F",[1.19727,7.00586,-0.000999928],270,1,0,[0,0],"","",true,false], 
    	["Land_BagFence_Long_F",[-1.64648,7.01367,-0.000999928],90,1,0,[0,-0],"","",true,false], 
    	["Land_Portable_generator_F",[3.83984,-6.24023,-0.0258002],359.971,1,0,[0.00116807,0.218066],"","",true,false], 
    	["Land_HBarrier_5_F",[0.214844,-7.49414,0],0,1,0,[0,0],"","",true,false], 
    	["Land_PortableLight_double_F",[4.88281,-6.375,0],150,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_5_F",[6.01172,-3.11719,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagFence_Long_F",[-0.291016,8.40039,-0.000999928],0,1,0,[0,0],"","",true,false]
    ],
    [
    	["CamoNet_OPFOR_open_F",[0.0722656,-0.337891,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-0.566406,1.93164,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[1.48047,-1.45117,0],330,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[-1.57813,1.94727,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-4.06641,-1.19336,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[1.93359,-1.06836,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[-1.83398,-2.72656,0],0,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_1_F",[1.58984,-2.86523,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_BagBunker_Small_F",[-4.3457,1.72266,0],135,1,0,[0,-0],"","",true,false], 
    	["Land_BagBunker_Small_F",[4.56445,1.84766,0],225,1,0,[0,0],"","",true,false], 
    	["O_HMG_01_high_F",[-4.13867,1.76758,-0.0871181],309.834,1,0,[-0.000305831,0.0005312],"","",true,false], 
    	["O_HMG_01_high_F",[4.6875,1.84375,-0.0871172],40.567,1,0,[-9.30288e-005,-0.000542392],"","",true,false]
    ],
    [
    	["CamoNet_OPFOR_open_F",[-0.308594,-0.00976563,0],0,1,0,[0,0],"","",true,false], 
    	["Land_BagBunker_Small_F",[0.0507813,2.64844,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[2.40234,0.957031,0],90,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-3.2207,-1.08594,0],315,1,0,[0,0],"","",true,false], 
    	["O_HMG_01_high_F",[0.462891,2.46875,-0.0871124],356.646,1,0,[-0.000150071,-0.000914952],"","",true,false], 
    	["Land_HBarrier_3_F",[2.19727,-1.72656,0],135,1,0,[0,-0],"","",true,false], 
    	["Land_HBarrier_3_F",[-2.76367,-3.47656,0],255,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[5.66406,-1.13281,0],180,1,0,[0,0],"","",true,false], 
    	["Land_HBarrier_3_F",[-4.33594,-1.50781,0],180,1,0,[0,0],"","",true,false]
    ]
];

_compositionsMedic = [
    [
        ["Land_CncWall1_F",[0.274902,2.35059,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-0.196289,2.86475,0],88.0495,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[1.53467,2.41064,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-3.59131,-0.638184,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-0.852051,3.33423,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[2.79297,2.45581,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-4.84277,-0.677979,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-6.06689,-0.708008,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[-6.61523,-1.69092,0],87.7966,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[6.03906,2.58594,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-7.36377,0.850586,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[8.61963,-1.02759,0],267.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[8.48535,2.07007,0],267.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-8.55664,0.825684,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall1_F",[-8.97607,1.4187,0],88.0495,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[1.33154,-9.09692,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[-6.41357,-6.93701,0],87.7966,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[-3.83984,-9.27393,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[8.82178,-6.27393,0],267.797,1,0,[0,0],"","",true,false],
        ["Land_CncWall4_F",[6.50049,-8.89844,0],357.797,1,0,[0,0],"","",true,false],
        ["Land_TTowerSmall_1_F",[7.69922,-7.59351,0],87.7966,1,0,[0,0],"","",true,false],
        ["Land_PowerGenerator_F",[5.59619,-7.47266,0],85.1977,1,0,[0,0],"","",true,false],
        ["Land_Cargo_Patrol_V3_F",[-6.84912,-3.76416,0],87.5777,1,0,[0,0],"","",true,false],
        ["Land_Medevac_house_V1_F",[4.51172,-3.41797,0],88.1376,1,0,[0,0],"","",true,false],
        ["Land_BagBunker_Small_F",[-6.22217,3.21631,0],178.913,1,0,[0,0],"","",true,false],
        ["O_HMG_01_high_F",[-5.92334,3.03271,-0.0871177],356.578,1,0,[0,0],"","",true,false],
        ["O_Truck_03_medical_F",[4.96289,6.7478,-0.000307083],89.6723,1,0,[0,0],"","",true,false]
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
_staticGroup = createGroup east;
_cnt = selectRandom [1,2,3];
if (isNil "CLEAR_POSITIONS") then {
    CLEAR_POSITIONS = [];
};
_medicBunkerSpawned = false;
for "_i" from 0 to _cnt do {
    _pos = [_centerPos, 0, 1000, 12, 0, 10] call QS_fnc_findSafePos;    
    if (format ["%1", _pos] != "[0,0,0]") then {
        CLEAR_POSITIONS pushBack [_pos, 20];
        _azi = [_centerPos, _pos] call BIS_fnc_dirTo;
        _objs = selectRandom _compositions;
        if !(_medicBunkerSpawned) then {
            if (random 10 > 5) then {
               _objs = selectRandom _compositionsMedic;  
            };
        };    
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
    		if (!isNil "_varName") then 
    		{
    			if (_varName != "") then 
    			{
    				_newObj setVehicleVarName _varName;
    				call (compile (_varName + " = _newObj;"));
    			};
    		};
    		if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));};
    		if (!isNil "_simulation") then {_newObj enableSimulation _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};
    	
            if (typeOf _newObj in ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AT_F"]) then {
                _newObj addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
                "O_support_MG_F" createUnit [[0,0,0], _staticGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
                currentGunner assignAsGunner _newObj;
                currentGunner moveInGunner _newObj;
            };
    		_newObjs pushBack _newObj;
        } forEach _objs;    
        _bunkerGroup = [_pos, 30, 5, east] call QS_fnc_FillBots;
        _cargoPostGroups = [_pos, 30, east] call QS_fnc_FillCargoPatrol;            
        _unitGroup = createGroup east;
        if (random 10 > 5) then {
            _pos1 = [_pos, 0, 30, 1, 0, 10] call QS_fnc_findSafePos;
            "O_engineer_F" createUnit [_pos1, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        };
        if (random 10 > 5) then {
            _pos2 = [_pos, 0, 30, 1, 0, 10] call QS_fnc_findSafePos;
            "O_Soldier_AA_F" createUnit [_pos2, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        };
        if (random 10 > 5) then {
            _pos3 = [_pos, 0, 30, 1, 0, 10] call QS_fnc_findSafePos;
            "O_Soldier_AT_F" createUnit [_pos3, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        };
        _unitGroup setBehaviour "COMBAT";
        _unitGroup setCombatMode "RED";
        [(units _unitGroup)] call QS_fnc_setSkill4;
    };
};
publicVariable "CLEAR_POSITIONS";
_staticGroup setBehaviour "COMBAT";
_staticGroup setCombatMode "RED";
[(units _staticGroup)] call QS_fnc_setSkill4;

_newObjs