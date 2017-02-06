/*
Author: ToxaBes
Description: create road blocks
Format: [_centerPos, _distance] call QS_fnc_createRoadBlocks;
*/
if (!isServer) exitWith {};
_centerPos = _this select 0;
_distance = _this select 1;
_compositions = [
[
        ["Land_BarGate_F",[3.13086,-1.07813,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[-5.57227,-3.45703,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[6.97656,2.21289,0],270,1,0,[0,0],"","",true,false], 
        ["Land_PortableLight_double_F",[-6.26367,-4.0332,0],330.571,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[-6.29688,-4.83008,-0.0010004],180,1,0,[0,0],"","",true,false], 
        ["Land_LampShabby_F",[7.36719,-5.02539,-2.41369],315,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-7.70508,-5.08984,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-9.88867,3.58203,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[7.48633,-8.16797,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_Cargo_House_V3_F",[11.1582,-0.210938,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[-7.18359,-8.71289,-0.0010004],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[5.75977,-8.09961,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_PaperBox_open_empty_F",[-11.4316,-1.57813,0],90,1,0,[0,-0],"","",true,false], 
        ["CamoNet_OPFOR_open_F",[12.0117,0.441406,0.457188],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-6.16211,-8.04492,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[-8.55273,-9.59375,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[12.1465,4.44727,0],1.36604e-005,1,0,[0,0],"","",true,false], 
        ["CamoNet_OPFOR_open_F",[-11.1914,-5.85352,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-11.7949,8.27344,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Pallet_vertical_F",[-13.5664,-1.05664,0.000250816],0.000395129,1,0,[-0.119279,0.00428207],"","",true,false], 
        ["Land_Sacks_heap_F",[12.6934,-5.57813,0],285,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-14.8965,0.378906,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-13.0684,-5.42969,0],180,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Patrol_V3_F",[-14.0566,3.17578,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Patrol_V3_F",[11.8164,-10.0742,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagBunker_Small_F",[-11.5547,-11.0078,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[16,-0.957031,0],270,1,0,[0,0],"","",true,false], 
        ["Land_PaperBox_open_full_F",[13.8184,-8.08789,0],0,1,0,[0,0],"","",true,false], 
        ["O_HMG_01_high_F",[-11.8066,-11.2031,-0.0871162],180,1,0,[-3.89538e-005,-0.000566959],"","",true,false], 
        ["Land_HBarrier_Big_F",[11.1035,-12.8711,0],180,1,0,[0,0],"","",true,false], 
        ["Land_LampShabby_F",[-17.2578,-0.888672,0],120.013,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[-14.6855,-9.5625,-0.000999928],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-16.4082,-7.44141,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-17.0117,8.21875,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-10.0938,-13.6465,-0.500003],180,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[-16.0586,-8.83789,-0.0010004],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[16.1816,-9.55273,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[13.5469,-15.0215,-2.86102e-006],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-18.5137,5.08203,0],90,1,0,[0,-0],"","",true,false]
    ],
    [
        ["Land_BarGate_F",[3.35938,-1.0625,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_8m_F",[-6,0.205078,0],270,1,0,[0,0],"","",true,false], 
        ["Land_PortableLight_double_F",[-6.50195,-1.8457,0],337.147,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_4m_F",[7.23242,-1.05273,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[6.67383,2.32422,0],270,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_8m_F",[5.5,-5.16992,0],270,1,0,[0,0],"","",true,false], 
        ["O_MRAP_02_hmg_F",[-8.6875,0.8125,0.00744581],175.289,1,0,[0.0271943,0.00618028],"","",true,false], 
        ["Land_Razorwire_F",[6.92383,-7.64258,-2.86102e-006],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_5_F",[-11.2578,-3.04297,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-8.53125,-4.60547,-2.86102e-006],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[10.1758,6.37109,0],180,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_4m_F",[5.50391,-11.1699,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-12.9277,0.300781,0],270,1,0,[0,0],"","",true,false], 
        ["Land_BagBunker_Large_F",[12.3613,-5.86523,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-11.9883,6.73438,0],112.044,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[15.5703,3.24219,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_LampShabby_F",[15.8164,-1.19531,-2.06135],277.404,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[13.7188,-11.3574,-2.86102e-006],180,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[17.4336,-4.31055,-2.86102e-006],90,1,0,[0,-0],"","",true,false]
    ],
    [
        ["Land_BarGate_F",[3.28711,-1.20703,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[5.36523,-2.70313,-0.000999928],90,1,0,[0,-0],"","",true,false], 
        ["Land_CncShelter_F",[-6.6543,0.0332031,0],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[3.72461,-5.70703,8.10623e-006],135.002,1,0.00993254,[0.00199058,0.00392395],"","",true,false], 
        ["RoadCone_F",[3.97461,5.54297,7.62939e-006],270.007,1,0.00989781,[0.00088702,0.00250983],"","",true,false], 
        ["RoadCone_F",[-4.52539,5.41797,8.10623e-006],60.0085,1,0.00992696,[0.00197614,0.00383753],"","",true,false], 
        ["Land_CncBarrierMedium_F",[-6.75781,-2.08203,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_CncBarrierMedium_F",[-6.88281,2.04297,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_PortableLight_double_F",[5.44727,-4.83984,0],29.6037,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.77539,-5.83203,8.82149e-006],359.999,1,0.009933,[0.00215512,0.00384164],"","",true,false], 
        ["Land_CncBarrierMedium_F",[-6.75781,-3.95703,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_MetalBarrel_F",[-7.80273,-1.83398,-0.0123165],164.309,1,0.00747152,[1.10573,2.62576],"","",true,false], 
        ["Land_BagFence_Long_F",[6.85352,-4.22266,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_MetalBarrel_F",[-7.82422,-2.58203,0.0100005],359.991,1,0.00890098,[-0.049955,-2.05544],"","",true,false], 
        ["RoadCone_F",[3.97461,7.79297,8.34465e-006],90.0064,1,0.00993528,[0.00205179,0.00385029],"","",true,false], 
        ["RoadCone_F",[-4.52539,7.66797,8.10623e-006],225.002,1,0.00992746,[0.00202001,0.0039472],"","",true,false], 
        ["RoadCone_F",[3.84961,-8.33203,8.34465e-006],90.0064,1,0.00993528,[0.00205179,0.00385029],"","",true,false], 
        ["Land_Razorwire_F",[5.29102,9.27148,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[-5.95898,8.77148,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[-4.65039,-8.45703,8.10623e-006],225.002,1,0.00993569,[0.00200228,0.0039168],"","",true,false], 
        ["Land_BagFence_Short_F",[8.35156,-4.94727,-0.0010004],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[5.16602,-6.85352,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_Pallet_MilBoxes_F",[-10.0273,1.42773,0],180,1,0,[0,0],"","",true,false], 
        ["CamoNet_OPFOR_open_F",[-10.7637,-1.05664,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_WoodenBox_F",[10.6855,0.482422,0.0100131],192.7,1,0,[-7.26071,-0.0102761],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[-10.5488,2.93555,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-6.08398,-7.35352,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[3.84961,10.418,8.10623e-006],135.002,1,0.00990262,[0.000992786,0.00276508],"","",true,false], 
        ["RoadCone_F",[3.84961,-10.582,8.58307e-006],270.006,1,0.00993525,[0.00203093,0.0038358],"","",true,false], 
        ["RoadCone_F",[-4.65039,10.293,8.82149e-006],359.999,1,0.0099353,[0.00215824,0.00383753],"","",true,false], 
        ["CamoNet_OPFOR_F",[11.2012,-0.257813,0],0,1,0,[0,0],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[11.3262,1.68555,0],0,1,0,[0,0],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[-10.377,-4.97461,0],180,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.65039,-10.707,8.10623e-006],60.0085,1,0.00993546,[0.00196073,0.00382614],"","",true,false], 
        ["Land_Razorwire_F",[9.49609,3.48438,-2.86102e-006],0,1,0,[0,0],"","",true,false], 
        ["Land_WaterTank_F",[-11.5254,-3.60938,0.012183],0.00805413,1,0,[-1.20833,0.0019631],"","",true,false], 
        ["Land_BagBunker_Small_F",[10.2246,-7.01172,0],0,1,0,[0,0],"","",true,false], 
        ["O_GMG_01_high_F",[9.97266,-7.17188,-0.0868192],179.808,1,0,[0.00616441,-0.00117892],"","",true,false], 
        ["Land_PaperBox_open_empty_F",[12.6348,0.0742188,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Short_F",[12.1016,-5.07227,-0.0010004],90,1,0,[0,-0],"","",true,false], 
        ["Land_BarrelTrash_grey_F",[13.9199,0.480469,5.81741e-005],359.967,1,0,[-0.0128459,-0.013693],"","",true,false], 
        ["Land_BagFence_Long_F",[13.6035,-4.22266,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[-14.5078,-0.933594,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[15.084,0.0390625,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[15.084,-2.83594,-0.000999928],270,1,0,[0,0],"","",true,false]
    ],
    [
        ["Land_BarGate_F",[3.54688,-0.335938,0],0,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.14063,-2.46094,8.10623e-006],135.002,1,0.00993567,[0.00200232,0.00391667],"","",true,false], 
        ["RoadCone_F",[-4.26563,2.28906,8.10623e-006],135.002,1,0.00993567,[0.00200232,0.00391667],"","",true,false], 
        ["Land_BagFence_Short_F",[4.35742,-2.4707,-0.0010004],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[5.24414,1.53711,-0.0010004],180,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[5.09961,-3.33398,-0.0010004],1.36604e-005,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.26563,4.66406,8.10623e-006],135.002,1,0.00993565,[0.00200232,0.00391667],"","",true,false], 
        ["RoadCone_F",[-4.14063,-5.08594,8.10623e-006],135.002,1,0.00993567,[0.00200235,0.00391669],"","",true,false], 
        ["Land_BagFence_Long_F",[5.96875,3.03516,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[5.96875,-4.71484,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-6.58203,2.43555,-2.86102e-006],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-6.58203,-6.18945,-2.86102e-006],270,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.14063,7.28906,8.10623e-006],135.002,1,0.00992593,[0.0019915,0.00391338],"","",true,false], 
        ["Land_BagFence_Long_F",[7.36328,4.39844,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.14063,-7.58594,8.10623e-006],135.002,1,0.00993567,[0.00200235,0.00391669],"","",true,false], 
        ["CamoNet_OPFOR_F",[9.43359,-1.8125,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[6,-7.45703,-0.000999928],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[10.1055,4.42969,-0.000999928],0,1,0,[0,0],"","",true,false], 
        ["Land_PaperBox_open_empty_F",[10.9844,-2.71094,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Pallet_MilBoxes_F",[11.5898,-0.908203,0],30,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[7.36328,-8.97656,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[11.5,3.04297,-0.000999928],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Short_F",[9.59961,-8.95898,-0.0010004],1.36604e-005,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[13.291,-3.68945,-2.86102e-006],270,1,0,[0,0],"","",true,false]
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
_dir = 0;
_selRoads = [];
while {_dir < 360} do {
    _relPos = [_centerPos, _distance, _dir] call BIS_fnc_relPos;
    _roads = _relPos nearRoads 150;
    {
        if ((getPos _x) isFlatEmpty [25, -1, -1, -1, -1] isEqualTo []) then {
            _selRoads pushBack _x;
        };
    } forEach _roads;
    _dir = _dir + 24;
};
_roadPoses = [];
_cnt = selectRandom [2,3,4,5];
{
    if ((count _roadPoses) < _cnt) then {
        _selRoad = _x;
        _allowed = true;
        {
            if (_selRoad distance2D _x < 300) then {
                _allowed = false;
            };
        } forEach _roadPoses;
        if (_allowed) then {
            _roadPoses pushBack _selRoad;
        };
    };    
} forEach _selRoads;
{            
    _pos = getPos _x;
    if (format ["%1", _pos] != "[0,0,0]") then {
        _relAzi = [_centerPos, _pos] call BIS_fnc_dirTo;
        _roadConnectedTo = roadsConnectedTo _x;
        if (count _roadConnectedTo > 0) then {
            _connectedRoad = _roadConnectedTo select 0;
            _azi = [_x, _connectedRoad] call BIS_fnc_DirTo;
            _delta = _relAzi - _azi;
            if (_delta < -360) then {
                _delta = _delta + 360;
            };
            if (_delta < 0) then {
                _delta = -_delta;
            };
            if (_delta > 90) then {
                _azi = _azi + 180;
            };
            _objs = selectRandom _compositions;    
            _posX = _pos select 0;
            _posY = _pos select 1;
            _unitGroup = createGroup east;
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
                    "O_support_MG_F" createUnit [[0,0,0], _unitGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
                    currentGunner assignAsGunner _newObj;
                    currentGunner moveInGunner _newObj;
                };
                if (typeOf _newObj in ["O_MRAP_02_hmg_F"]) then {
                    _newObj addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
                    "O_engineer_F" createUnit [[0,0,0], _unitGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
                    currentGunner assignAsGunner _newObj;
                    currentGunner moveInGunner _newObj;            
                };
                if (typeOf _newObj in ["Land_BagBunker_Large_F"]) then {
                    _pos1 = [_newPos, 0, 6, 1, 0, 10] call QS_fnc_findSafePos;
                    "O_Soldier_AR_F" createUnit [_pos1, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
                };
        		_newObjs pushBack _newObj;
            } forEach _objs;    
            _bunkerGroup = [_pos, 30, 5, east] call QS_fnc_FillBots;
            _cargoPostGroups = [_pos, 30, east] call QS_fnc_FillCargoPatrol;                  
            _pos2 = [_pos, 0, 5, 1, 0, 10] call QS_fnc_findSafePos;
            "O_Soldier_AA_F" createUnit [_pos2, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
            _pos3 = [_pos, 0, 12, 1, 0, 10] call QS_fnc_findSafePos;
            "O_Soldier_AT_F" createUnit [_pos3, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
            _unitGroup setBehaviour "COMBAT";
            _unitGroup setCombatMode "RED";
            [(units _unitGroup)] call QS_fnc_setSkill4;
        };
    };
} forEach _roadPoses;

_newObjs