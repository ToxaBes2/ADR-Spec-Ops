/*
Author: ToxaBes
Description: create avanpost near AO.
Format: [_centerAO] call QS_fnc_createAvanpost;
*/
if (!isServer) exitWith {};
_centerAO = _this select 0;
_centerAO set [2, 0];
_azi 	= random 360;
_objs = [["Land_CncBarrier_stripes_F",[0.828125,0.982422,0],272.513],["B_HMG_01_F",[1.62695,0.878906,0.00171185],184.852],
["Land_CncBarrier_stripes_F",[0.931641,3.56641,0],272.513],["Land_CampingChair_V1_F",[3.56445,1.0625,0.00312495],174.704],
["Land_CampingTable_F",[4.04297,1.63867,1.19209e-006],189.714],["Land_CampingChair_V1_F",[4.49219,0.615234,0.00312448],204.702],
["Land_CampingChair_V1_F",[3.78516,2.50391,0.00312543],354.704],["Land_CncBarrier_stripes_F",[4.38281,-1.72656,0],184.107],
["Land_CampingChair_V1_F",[4.875,2.24805,0.00312376],39.7017],["CamoNet_INDP_open_F",[-4.30664,4.14648,0],85.695],
["Land_CampingChair_V1_folded_F",[5.80078,1.29883,0],165],["Land_CncBarrier_stripes_F",[1.04102,6.16797,0],272.513],
["B_Quadbike_01_F",[-6.20117,1.38672,-0.00900412],86.0057],["Land_Cargo_House_V1_F",[-4.91797,-5.09375,0],180],
["Land_Cargo10_grey_F",[6.46484,-0.431641,1.90735e-005],5.63494],["Land_WaterTank_F",[-1.05078,-6.62695,-6.91414e-006],90.7568],
["CamoNet_INDP_open_F",[4.12695,4.75977,0],85.695],["Land_CampingChair_V1_folded_F",[6.77148,1.39648,0],300],
["Land_CncBarrier_stripes_F",[6.97266,-1.89258,0],184.107],["Land_Bucket_painted_F",[7.23828,0.904297,2.59876e-005],359.93],
["B_Quadbike_01_F",[-6.10742,4.03711,-0.00795317],90.3573],["Land_CncBarrierMedium_F",[3.89063,-6.33789,0],316.146],
["Land_PowerGenerator_F",[2.41406,7.29492,0],267.016],["Land_CncBarrierMedium_F",[5.39063,-5.75781,0],181.023],
["Land_BarrelSand_F",[7.86328,1,5.81741e-005],359.959],["Land_Cargo_Patrol_V4_F",[6.0332,-6.58203,-0.293324],0],
["Land_BarrelTrash_grey_F",[8.05078,1.57031,5.81741e-005],359.959],["Land_CncBarrierMedium_F",[3.17578,-7.77148,0],276.864],
["Land_PlasticCase_01_small_F",[4.18945,7.28711,-4.76837e-007],97.8568],["Land_MetalBarrel_F",[4.50391,-7.14258,0.0382731],242.907],
["Land_CncWall4_F",[-8.60742,1.3125,0],90],["Land_CncWall1_F",[-0.402344,-8.84375,0],0],["Land_Portable_generator_F",[5.33008,-6.74609,0.0321479],187.319],
["Land_MetalBarrel_F",[4.50195,-7.66797,9.77516e-005],281.245],["B_Quadbike_01_F",[-6.08203,6.74414,-0.00900364],96.8636],
["Land_CncWall4_F",[9.29492,-1.07031,0],270],["Land_CncWall4_F",[-8.60742,-3.9375,0],90],["Land_CncWall1_F",[2.80664,-8.77734,-0.186305],0],
["Land_CncWall1_F",[9.30078,2.08203,0],270],["Land_CncWall4_F",[-3.54688,-8.85352,0],0],["Land_CncWall1_F",[4.07813,-8.63672,0],0],
["Land_Sacks_heap_F",[6.11133,7.1543,0],1.15248],["Land_CncShelter_F",[1.58008,-9.37695,0],0],["Land_CncWall1_F",[-8.59766,4.66211,0],90],
["Oil_Spill_F",[-6.18945,7.125,0],0],["Land_CncWall1_F",[4.71875,-8.86133,0],0],["Land_CanisterFuel_F",[8.33203,5.50391,5.19753e-005],213.132],
["Land_CncBarrierMedium_F",[-0.273438,-10.0449,0],267.899],["Land_CncWall1_F",[-8.55469,5.97266,0],90],
["Land_Cargo20_military_green_F",[4.77148,9.07422,2.57492e-005],360],["Land_PaperBox_open_full_F",[7.77539,6.88867,0],0],
["Land_PortableLight_single_F",[-0.0742188,10.7988,0],41.7905],["Land_PortableLight_double_F",[3.21289,-10.0938,0],359.714],
["Land_Portable_generator_F",[1.24023,10.7148,-0.000752211],181.708],["Land_CncWall1_F",[9.30078,6.08203,0],270],["Land_CncWall1_F",[-6.88867,-8.86133,0],0],
["Land_CncWall1_F",[-8.60352,-7.07422,0],90],["Land_CncWall4_F",[9.30469,-6.30469,0],270],["B_Quadbike_01_F",[-6.14844,9.33398,-0.00900364],94.0946],
["Land_PaperBox_open_empty_F",[8.05273,-7.85742,0],0],["Land_CncWall1_F",[7.46875,-8.86133,0],0],["Land_CncWall4_F",[1.52734,11.8359,0],180],
["Land_CncWall1_F",[-8.17773,-8.85547,0],0],["Land_CncWall1_F",[-8.60352,-8.32422,0],90],["Land_CncBarrier_F",[2.88867,-11.502,0],88.9918],
["Land_CncBarrierMedium_F",[-0.234375,-11.8633,0],90],["Land_BagBunker_01_small_green_F",[6.03516,-10.8906,0],0],["O_GMG_01_high_F",[5.9707,-10.4238,-0.0868092],190.209],
["Land_CncWall4_F",[-3.69727,11.8555,0],180],["Land_CncBarrier_F",[8.30273,-9.00195,0],271.887],["Land_CncWall1_F",[8.71875,-8.86133,0],0],
["Land_CncWall4_F",[-8.5293,9.14648,0],90],["Land_Radar_Small_F",[12.9023,3.10156,0],338.494],["Land_CncWall4_F",[9.29492,9.42969,0],270],
["Land_CncBarrier_F",[4.27539,-12.6445,0],1.09006],["Land_CncWall1_F",[-6.81055,11.7832,0],180],["Land_CncWall4_F",[6.77734,11.8359,0],180],
["Land_LampHalogen_F",[-8.10938,11.291,0],228.311],["Land_CncWall1_F",[-8.01953,11.7559,0],178.135],["Land_CncBarrier_F",[8.18945,-11.5859,0],92.0736],
["Land_CncBarrier_F",[6.83398,-12.6816,0],1.09006],["Snake_random_F",[37.2871,-32.7676,0.0083878],304.769],["Land_DataTerminal_01_F",[-4.82617,-7.0918,0],168.969]];
_newObjs = [];
_pos = [_centerAO, 750, 1300, 15, 0, 0.06, 0] call QS_fnc_findSafePos;
_isFlat = !(_pos isFlatEmpty [-1, -1, 0.1, 15] isEqualTo []);
while {!_isFlat} do {
   _pos = [_centerAO, 700, 1500, 12, 0, 0.06, 0] call QS_fnc_findSafePos;
   _isFlat = !(_pos isFlatEmpty [-1, -1, 0.1, 10] isEqualTo []);
};

//debug
//_markerA = createMarker["debugmkr", _pos];
//_markerA setMarkercolor "colorRed";
//_markerA setMarkerSize [1,1];
//_markerA setMarkerType "Mil_dot";
//_markerA setMarkerText "Avanpost";

private ["_posX", "_posY"];
_posX = _pos select 0;
_posY = _pos select 1;
private ["_multiplyMatrixFunc"];
_multiplyMatrixFunc = {
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;
	_result =
	[
	(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
	(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];
	_result
};
_lamps = ["Land_LampHalogen_F","Land_PortableLight_single_F","Land_PortableLight_double_F"];
_exclude = ["Land_Cargo_Patrol_V1_F", "Land_Cargo_House_V1_F", "Land_Cargo20_military_green_F"];
for "_i" from 0 to ((count _objs) - 1) do {
	private ["_obj", "_type", "_relPos", "_azimuth", "_fuel", "_damage", "_newObj", "_vehicleinit"];
	_obj = _objs select _i;
	_type = _obj select 0;
	_relPos = _obj select 1;
	_azimuth = _obj select 2;							
	private ["_rotMatrix", "_newRelPos", "_newPos"];
	_rotMatrix =[[cos _azi, sin _azi],[-(sin _azi), cos _azi]];
	_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;
	private ["_z"];
	if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
	_newObj = _type createVehicle _newPos;
	_newObj setDir (_azi + _azimuth);
	_newObj setPos _newPos;
	switch (true) do { 
		case (_newObj isKindOf "LandVehicle"): {
            //quadbike monitoring
            _newObj setVariable ["AVANPOST_BIKE", true];
            [_newObj,60,FALSE,QS_fnc_vSetup02] spawn QS_fnc_vMonitor;
	    }; 
		case (_newObj isKindOf "StaticWeapon"): {
            //add gunner later in another place
	    }; 
	    case ((typeOf _newObj) in _lamps): {
            //do nothing
	    };
	    case ((typeOf _newObj) == "Land_DataTerminal_01_F"): {
            _pos = getPosATL _newObj;
            _pos set [2, (_pos select 2) + 0.8];
            _newObj setPosATL _pos;
            _newObj allowDamage false;                
            
            //add actions
            [_newObj,"red","red","red"] call BIS_fnc_DataTerminalColor;
            [_newObj, 1] call BIS_fnc_dataTerminalAnimate;
            [_newObj, "QS_fnc_addActionAvanpost", nil, true] spawn BIS_fnc_MP;
            {
                _x addCuratorEditableObjects [[_newObj], true];
            } forEach allCurators;
	    };
		default {
            _newObj allowDamage false;            
            _class = typeOf _newObj;
            if !(_class in _exclude) then {
                _newObj enableSimulation false;
            };                
	    }; 
	};
	_newObjs = _newObjs + [_newObj];	
};
hqSideChat ="Рядом с основной зоной замечен аванпост противника.";
publicVariable "hqSideChat"; [west, "HQ"] sideChat hqSideChat;
hqSideChat ="Захват аванпоста даст вам дополнительную точку возрождения.";
publicVariable "hqSideChat"; [west, "HQ"] sideChat hqSideChat;
missionNamespace setVariable ["AVANPOST_COORDS", _pos];
_result = [_pos, _newObjs];
_result
