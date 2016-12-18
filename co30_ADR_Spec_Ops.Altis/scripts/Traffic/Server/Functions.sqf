if (!isNil "ENGIMA_TRAFFIC_functionsInitialized") exitWith {};

ENGIMA_TRAFFIC_FindEdgeRoads = {
	private ["_minTopLeftDistances", "_minTopRightDistances", "_minBottomRightDistances", "_minBottomLeftDistances"];
	private ["_worldTrigger", "_worldSize", "_mapTopLeftPos", "_mapTopRightPos", "_mapBottomRightPos", "_mapBottomLeftPos", "_i", "_nextStartPos", "_segmentsCount"];
	
	if (!isNil "ENGIMA_TRAFFIC_edgeRoadsInitializing") exitWith {};
	ENGIMA_TRAFFIC_edgeRoadsInitializing = true;
	
	sleep 2; // Wait for all traffic instances to be registered
	
	_worldTrigger = call BIS_fnc_worldArea;
	_worldSize = triggerArea _worldTrigger;
	_mapTopLeftPos = [0, 2 * (_worldSize select 1)];
	_mapTopRightPos = [2 * (_worldSize select 0), 2 * (_worldSize select 1)];
	_mapBottomRightPos = [2 * (_worldSize select 0), 0];
	_mapBottomLeftPos = [0, 0];
	
	_minTopLeftDistances = [];
	_minTopRightDistances = [];
	_minBottomRightDistances = [];
	_minBottomLeftDistances = [];
	for "_i" from 0 to ENGIMA_TRAFFIC_instanceIndex do {
		_minTopLeftDistances pushBack 1000000;
		_minTopRightDistances pushBack 1000000;
		_minBottomRightDistances pushBack 1000000;
		_minBottomLeftDistances pushBack 1000000;
	};
	
	ENGIMA_TRAFFIC_allRoadSegments = [0,0,0] nearRoads 1000000;
	sleep 0.01;
	_segmentsCount = count ENGIMA_TRAFFIC_allRoadSegments;
	
	// Find all edge road segments
	_i = 0;
	_nextStartPos = 1;
	while { _i < _segmentsCount } do {
		private ["_index", "_road", "_roadPos", "_markerName", "_insideMarker", "_roads"];
		
		_road = ENGIMA_TRAFFIC_allRoadSegments select _i;
		_roadPos = getPos _road;
		
		_index = 0;
	
		// Top left
		while { _index <= ENGIMA_TRAFFIC_instanceIndex } do {
			_markerName = ENGIMA_TRAFFIC_areaMarkerNames select _index; // Get the marker name for the current instance
			
			_insideMarker = true;
			if (_markerName != "") then {
				_insideMarker = [_roadPos, _markerName] call ENGIMA_TRAFFIC_PositionIsInsideMarker;
			};
			
			if (_insideMarker) then {
				_roads = ENGIMA_TRAFFIC_roadSegments select _index;
				_roads pushBack _road;
			
				// Top left
				if (_roadPos distance _mapTopLeftPos < (_minTopLeftDistances select _index)) then {
					_minTopLeftDistances set [_index, _roadPos distance _mapTopLeftPos];
					ENGIMA_TRAFFIC_edgeTopLeftRoads set [_index, _road];
				};
				
				// Top right
				if (_roadPos distance _mapTopRightPos < (_minTopRightDistances select _index)) then {
					_minTopRightDistances set [_index, _roadPos distance _mapTopRightPos];
					ENGIMA_TRAFFIC_edgeTopRightRoads set [_index, _road];
				};
				
				// Bottom right
				if (_roadPos distance _mapBottomRightPos < (_minBottomRightDistances select _index)) then {
					_minBottomRightDistances set [_index, _roadPos distance _mapBottomRightPos];
					ENGIMA_TRAFFIC_edgeBottomRightRoads set [_index, _road];
				};
				
				// Bottom left
				if (_roadPos distance _mapBottomLeftPos < (_minBottomLeftDistances select _index)) then {
					_minBottomLeftDistances set [_index, _roadPos distance _mapBottomLeftPos];
					ENGIMA_TRAFFIC_edgeBottomLeftRoads set [_index, _road];
				};
				
				if (!(ENGIMA_TRAFFIC_edgeRoadsUseful select _index)) then {
					ENGIMA_TRAFFIC_edgeRoadsUseful set [_index, true];
				};
				sleep 0.01;
			};
			
			_index = _index + 1;
		};
		
		sleep 0.01;
		_i = _i + 50;
		if (_i >= _segmentsCount) then {
			_i = _nextStartPos;
			_nextStartPos = _nextStartPos + 1;
			if (_nextStartPos == 50) then {
				_i = _segmentsCount;
			};
		};
	};
	
	ENGIMA_TRAFFIC_edgeRoadsInitialized = true;
};

ENGIMA_TRAFFIC_MoveVehicle = {
	private ["_currentInstanceIndex", "_vehicle", "_firstDestinationPos", "_debug"];
    private ["_speed", "_roadSegments", "_destinationSegment"];
    private ["_destinationPos"];
    private ["_waypoint", "_fuel"];
    
	_currentInstanceIndex = _this select 0;
    _vehicle = _this select 1;
    if (count _this > 2) then {_firstDestinationPos = _this select 2;} else {_firstDestinationPos = [];};
    if (count _this > 3) then {_debug = _this select 3;} else {_debug = false;};
    
    // Set fuel to something in between 0.3 and 0.9.
    _fuel = 0.3 + random (0.9 - 0.3);
    _vehicle setFuel _fuel;
    
    if (count _firstDestinationPos > 0) then {
        _destinationPos = + _firstDestinationPos;
    }
    else {
		_roadSegments = ENGIMA_TRAFFIC_roadSegments select _currentInstanceIndex;
        _destinationSegment = _roadSegments select floor random count _roadSegments;
        _destinationPos = getPos _destinationSegment;
    };
    
    _speed = "NORMAL";
    _behaviour = "CARELESS";
    if (_vehicle distance _destinationPos < 500) then {
        _speed = "LIMITED";
        _behaviour = "SAFE";
    };
    
    _waypoint = group _vehicle addWaypoint [_destinationPos, 10];
    _waypoint setWaypointBehaviour _behaviour;
    _waypoint setWaypointSpeed _speed;
    _waypoint setWaypointCompletionRadius 10;
    _waypoint setWaypointStatements ["true", "_nil = [" + str _currentInstanceIndex + ", " + vehicleVarName _vehicle + ", [], " + str _debug + "] spawn ENGIMA_TRAFFIC_MoveVehicle;"];
};

ENGIMA_TRAFFIC_StartTraffic = {
	if (!isServer) exitWith {};
	
	private ["_side", "_vehicleCount", "_minSpawnDistance", "_maxSpawnDistance", "_minSkill", "_maxSkill", "_areaMarkerName", "_hideAreaMarker", "_debug"];
	private ["_allPlayerPositions", "_allPlayerPositionsTemp", "_activeVehiclesAndGroup", "_vehiclesGroup", "_spawnSegment", "_vehicle", "_group", "_result", "_possibleVehicles", "_vehicleType", "_vehiclesCrew", "_skill", "_minDistance", "_tries", "_trafficLocation"];
	private ["_currentEntityNo", "_vehicleVarName", "_tempVehiclesAndGroup", "_deletedVehiclesCount", "_firstIteration", "_roadSegments", "_destinationSegment", "_destinationPos", "_direction"];
	private ["_roadSegmentDirection", "_testDirection", "_facingAway", "_posX", "_posY", "_pos", "_currentInstanceIndex"];
	private ["_fnc_OnSpawnVehicle", "_fnc_OnRemoveVehicle", "_fnc_FindSpawnSegment"];
	private ["_debugMarkerName"];

	_side = [_this, "SIDE", civilian] call ENGIMA_TRAFFIC_GetParamValue;
	_possibleVehicles = [_this, "VEHICLES", ["C_Offroad_01_F", "C_Offroad_01_repair_F", "C_Quadbike_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Van_01_fuel_F"]] call ENGIMA_TRAFFIC_GetParamValue;
	_vehicleCount = [_this, "VEHICLES_COUNT", 10] call ENGIMA_TRAFFIC_GetParamValue;
	_minSpawnDistance = [_this, "MIN_SPAWN_DISTANCE", 800] call ENGIMA_TRAFFIC_GetParamValue;
	_maxSpawnDistance = [_this, "MAX_SPAWN_DISTANCE", 1200] call ENGIMA_TRAFFIC_GetParamValue;
	_minSkill = [_this, "MIN_SKILL", 0.3] call ENGIMA_TRAFFIC_GetParamValue;
	_maxSkill = [_this, "MAX_SKILL", 0.7] call ENGIMA_TRAFFIC_GetParamValue;
	_areaMarkerName = [_this, "AREA_MARKER", ""] call ENGIMA_TRAFFIC_GetParamValue;
	_hideAreaMarker = [_this, "HIDE_AREA_MARKER", true] call ENGIMA_TRAFFIC_GetParamValue;
	_fnc_OnSpawnVehicle = [_this, "ON_SPAWN_CALLBACK", {}] call ENGIMA_TRAFFIC_GetParamValue;
	_fnc_OnRemoveVehicle = [_this, "ON_REMOVE_CALLBACK", {}] call ENGIMA_TRAFFIC_GetParamValue;
	_debug = [_this, "DEBUG", false] call ENGIMA_TRAFFIC_GetParamValue;
	
	if (_areaMarkerName != "" && _hideAreaMarker) then {
		_areaMarkerName setMarkerAlpha 0;
	};
	
	sleep random 1;
	ENGIMA_TRAFFIC_instanceIndex = ENGIMA_TRAFFIC_instanceIndex + 1;
	_currentInstanceIndex = ENGIMA_TRAFFIC_instanceIndex;
	
	ENGIMA_TRAFFIC_areaMarkerNames set [_currentInstanceIndex, _areaMarkerName];
	ENGIMA_TRAFFIC_edgeRoadsUseful set [_currentInstanceIndex, false];
	ENGIMA_TRAFFIC_roadSegments set [_currentInstanceIndex, []];
	
	_activeVehiclesAndGroup = [];
	
	_fnc_FindSpawnSegment = {
	    private ["_currentInstanceIndex", "_allPlayerPositions", "_minSpawnDistance", "_maxSpawnDistance", "_activeVehiclesAndGroup"];
	    private ["_insideMarker", "_areaMarkerName", "_refPlayerPos", "_roadSegments", "_roadSegment", "_isOk", "_tries", "_result", "_spawnDistanceDiff", "_refPosX", "_refPosY", "_dir", "_tooFarAwayFromAll", "_tooClose", "_tooCloseToAnotherVehicle"];
		
		_currentInstanceIndex = _this select 0;
	    _allPlayerPositions = _this select 1;
	    _minSpawnDistance = _this select 2;
	    _maxSpawnDistance = _this select 3;
	    _activeVehiclesAndGroup = _this select 4;
	    
	    _spawnDistanceDiff = _maxSpawnDistance - _minSpawnDistance;
	    _roadSegment = "NULL";
	    _refPlayerPos = (_allPlayerPositions select floor random count _allPlayerPositions);
	    _areaMarkerName = ENGIMA_TRAFFIC_areaMarkerNames select _currentInstanceIndex;
	    
	    _isOk = false;
	    _tries = 0;
	    while {!_isOk && _tries < 10} do {
	        if (count _allPlayerPositions > 0) then {
                _isOk = true;    
	            _dir = random 360;
	            _refPosX = (_refPlayerPos select 0) + (_minSpawnDistance + _spawnDistanceDiff / 2) * sin _dir;
	            _refPosY = (_refPlayerPos select 1) + (_minSpawnDistance + _spawnDistanceDiff / 2) * cos _dir;
	            
	            _roadSegments = [_refPosX, _refPosY] nearRoads (_spawnDistanceDiff / 2);
	            
	            if (count _roadSegments > 0) then {
	                _roadSegment = _roadSegments select floor random count _roadSegments;
	                
	                // Check if road segment is ok
	                _tooFarAwayFromAll = true;
	                _tooClose = false;
                    _insideMarker = true;
                    _tooCloseToAnotherVehicle = false;
                    
                    if (_areaMarkerName != "" && !([getPos _roadSegment, _areaMarkerName] call ENGIMA_TRAFFIC_PositionIsInsideMarker)) then {
                    	_insideMarker = false;
                    };
                    
                    if (_insideMarker) then {
		                {
		                    private ["_tooFarAway"];
		                    
		                    _tooFarAway = false;
		                    
		                    if (_x distance (getPos _roadSegment) < _minSpawnDistance) then {
		                        _tooClose = true;
		                    };
		                    if (_x distance (getPos _roadSegment) > _maxSpawnDistance) then {
		                        _tooFarAway = true;
		                    };
		                    if (!_tooFarAway) then {
		                        _tooFarAwayFromAll = false;
		                    };
		                    
		                    sleep 0.01;
		                } foreach _allPlayerPositions;
		    		
	                    {
	                        private ["_vehicle"];
	                        _vehicle = _x select 0;
	                        
	                        if ((getPos _roadSegment) distance _vehicle < 100) then {
	                            _tooCloseToAnotherVehicle = true;
	                        };
	                        
	                        sleep 0.01;
	                    } foreach _activeVehiclesAndGroup;
		    		};
		                    
	                _isOk = true;
	                if ((getPos _roadSegment) distance (getMarkerPos "respawn_west") < 1500) then {
		                _tooClose = true;
		            };
	                if (_tooClose || _tooFarAwayFromAll || _tooCloseToAnotherVehicle || !_insideMarker) then {
	                    _isOk = false;
	                    _tries = _tries + 1;
	                };
	            }
	            else {
	                _isOk = false;
	                _tries = _tries + 1;
	            };
	            
		    	sleep 0.1;
	        };

	    };
	
	    if (!_isOk) then {
	        _result = "NULL";
	    }
	    else {
	        _result = _roadSegment;
	    };
	
	    _result
	};
	
	_firstIteration = true;
	
	[] spawn ENGIMA_TRAFFIC_FindEdgeRoads;
	waitUntil { sleep 1; (ENGIMA_TRAFFIC_edgeRoadsUseful select _currentInstanceIndex) };
	sleep 5;
	while {true} do {
	    scopeName "mainScope";
	    private ["_sleepSeconds", "_correctedVehicleCount", "_markerSize", "_avgMarkerRadius", "_coveredShare", "_restDistance", "_coveredAreaShare"];
        _allPlayerPositions = [getMarkerPos "respawn_west"];		
	
	    // If there are few vehicles, add a vehicle	    
	    if (_areaMarkerName == "") then {
		    _correctedVehicleCount = _vehicleCount;
	    }
	    else {
	    	_markerSize = getMarkerSize _areaMarkerName;
	    	_avgMarkerRadius = ((_markerSize select 0) + (_markerSize select 1)) / 2;

			if (_avgMarkerRadius > _maxSpawnDistance) then {
			    _correctedVehicleCount = floor (_vehicleCount / 2);
		    	_coveredShare = 0;
		    	
			    {
			    	_restDistance = _maxSpawnDistance - ((_x distance getMarkerPos _areaMarkerName) - _avgMarkerRadius);
			    	_coveredAreaShare = _restDistance / (_maxSpawnDistance * 2);
				    if (_coveredAreaShare > _coveredShare) then {
					    _coveredShare = _coveredAreaShare;
				    };
				    
				    sleep 0.01;
			    } foreach (_allPlayerPositions);
			    
			    _correctedVehicleCount = floor (_vehicleCount * _coveredShare);
	    	}
	    	else {
	    		_correctedVehicleCount = _vehicleCount;
	    	};
	    };
	
	    _tries = 0;
	    while {count _activeVehiclesAndGroup < _correctedVehicleCount && _tries < 1} do {
			sleep 0.1;
			
	        // Get all spawn positions within range
	        if (_firstIteration) then {
	            _minDistance = 300;
	            
	            if (_minDistance > _maxSpawnDistance) then {
	                _minDistance = 0;
	            };
	        }
	        else {
	            _minDistance = _minSpawnDistance;
	        };
	        
	        _spawnSegment = [_currentInstanceIndex, _allPlayerPositions, _minDistance, _maxSpawnDistance, _activeVehiclesAndGroup] call _fnc_FindSpawnSegment;
	        
	        // If there were spawn positions
	        if (str _spawnSegment != """NULL""") then {
	        
	            // Get first destination
	            _trafficLocation = floor random 5;
	            switch (_trafficLocation) do {
	                case 0: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeBottomLeftRoads select _currentInstanceIndex)) nearRoads 100; };
	                case 1: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeTopLeftRoads select _currentInstanceIndex)) nearRoads 100; };
	                case 2: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeTopRightRoads select _currentInstanceIndex)) nearRoads 100; };
	                case 3: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeBottomRightRoads select _currentInstanceIndex)) nearRoads 100; };
	                default { _roadSegments = ENGIMA_TRAFFIC_roadSegments select _currentInstanceIndex };
	            };
	            
	            _destinationSegment = _roadSegments select floor random count _roadSegments;
	            _destinationPos = getPos _destinationSegment;

	            _direction = ((_destinationPos select 0) - (getPos _spawnSegment select 0)) atan2 ((_destinationPos select 1) - (getpos _spawnSegment select 1));
	            _roadSegmentDirection = getDir _spawnSegment;
	            
	            while {_roadSegmentDirection < 0} do {
	                _roadSegmentDirection = _roadSegmentDirection + 360;
	            };
	            while {_roadSegmentDirection > 360} do {
	                _roadSegmentDirection = _roadSegmentDirection - 360;
	            };
	            
	            while {_direction < 0} do {
	                _direction = _direction + 360;
	            };
	            while {_direction > 360} do {
	                _direction = _direction - 360;
	            };
	
	            _testDirection = _direction - _roadSegmentDirection;
	            
	            while {_testDirection < 0} do {
	                _testDirection = _testDirection + 360;
	            };
	            while {_testDirection > 360} do {
	                _testDirection = _testDirection - 360;
	            };
	            
	            _facingAway = false;
	            if (_testDirection > 90 && _testDirection < 270) then {
	                _facingAway = true;
	            };
	            
	            if (_facingAway) then {
	                _direction = _roadSegmentDirection + 180;
	            }
	            else {
	                _direction = _roadSegmentDirection;
	            };            
	            
	            _posX = (getPos _spawnSegment) select 0;
	            _posY = (getPos _spawnSegment) select 1;
	            
	            _posX = _posX + 2.5 * sin (_direction + 90);
	            _posY = _posY + 2.5 * cos (_direction + 90);
	            _pos = [_posX, _posY, 0];
	            
	            // Create vehicle
	            _vehicleType = _possibleVehicles select floor (random count _possibleVehicles);
	            _result = [_pos, _direction, _vehicleType, _side] call BIS_fnc_spawnVehicle;
	            _vehicle = _result select 0;
	            _vehiclesCrew = _result select 1;
	            _vehiclesGroup = _result select 2;
	            if (random 10 > 4) then {
	                createVehicleCrew _vehicle;
	                _vehiclesCrew = crew _vehicle;
	            };
	                            
	            {
					[_x] call randomCivilian;												
				} forEach _vehiclesCrew;	         
	            
	            // Name vehicle
	            sleep random 0.1;
	            if (isNil "dre_MilitaryTraffic_CurrentEntityNo") then {
	                dre_MilitaryTraffic_CurrentEntityNo = 0
	            };
	            
	            _currentEntityNo = dre_MilitaryTraffic_CurrentEntityNo;
	            dre_MilitaryTraffic_CurrentEntityNo = dre_MilitaryTraffic_CurrentEntityNo + 1;
	            
	            _vehicleVarName = "dre_MilitaryTraffic_Entity_" + str _currentEntityNo;
	            _vehicle setVehicleVarName _vehicleVarName;
	            _vehicle call compile format ["%1=_this;", _vehicleVarName];
	            sleep 0.01;
	            
	            // Set crew skill
	            {
	                _skill = _minSkill + random (_maxSkill - _minSkill);
	                _x setSkill _skill;	                
		            sleep 0.01;
	            } foreach _vehiclesCrew;
	            
	            _debugMarkerName = "dre_MilitaryTraffic_DebugMarker" + str _currentEntityNo;
	            
	            // Start vehicle
	            [_currentInstanceIndex, _vehicle, _destinationPos, _debug] spawn ENGIMA_TRAFFIC_MoveVehicle;
	            _activeVehiclesAndGroup pushBack [_vehicle, _vehiclesGroup, _vehiclesCrew, _debugMarkerName];
	            sleep 0.01;
	            
	            // Run spawn script and attach handle to vehicle
	            _vehicle setVariable ["dre_scriptHandle", _result spawn _fnc_OnSpawnVehicle];
	            _vehicle lock 0;	            
	        };
	        
            _tries = _tries + 1;
	    };
	    
	    _firstIteration = false;
	
		// If any vehicle is too far away, delete it
	    _tempVehiclesAndGroup = [];
	    _deletedVehiclesCount = 0;
		{
	        private ["_closestUnitDistance", "_distance", "_crewUnits"];
	        private ["_scriptHandle"];
	        
	        _vehicle = _x select 0;
	        _group = _x select 1;
	        _crewUnits = _x select 2;
	        _debugMarkerName = _x select 3;
  
            _keep = true;
            if !(alive _vehicle) then {
                _keep = false;
            } else {
                _people = _vehicle nearEntities ["Man", 1000];
                if (count _people == 0) then {
                    _keep = false;
                };
            };

            if (_keep) then {
                _tempVehiclesAndGroup pushBack _x;
            } else {

                // Run callback before deleting
	            _vehicle call _fnc_OnRemoveVehicle;
	            
	            // Delete crew
	            {
	                deleteVehicle _x;
	            } foreach _crewUnits;
	
	            // Terminate script before deleting the vehicle
	            _scriptHandle = _vehicle getVariable "dre_scriptHandle";
	            if (!(scriptDone _scriptHandle)) then {
	                terminate _scriptHandle;
	            };
	            
	            deleteVehicle _vehicle;
	            deleteGroup _group;
	
	            [_debugMarkerName] call ENGIMA_TRAFFIC_DeleteDebugMarkerAllClients;
	            _deletedVehiclesCount = _deletedVehiclesCount + 1;
            };
		} forEach _activeVehiclesAndGroup;
	    
	    _activeVehiclesAndGroup = _tempVehiclesAndGroup;
	    
	    // Do nothing but update debug markers for X seconds
	    _sleepSeconds = 180;
	    if (_debug) then {
		    for "_i" from 1 to _sleepSeconds do {
		        {
		            private ["_debugMarkerColor"];
		            
		            _vehicle = _x select 0;
		            _group = _x select 1;
		            _debugMarkerName = _x select 3;
		            _side = side _group;
		            
		            _debugMarkerColor = "Default";
		            if (_side == west) then {
		                _debugMarkerColor = "ColorBlue";
		            };
		            if (_side == east) then {
		                _debugMarkerColor = "ColorRed";
		            };
		            if (_side == civilian) then {
		                _debugMarkerColor = "ColorYellow";
		            };
		            if (_side == resistance) then {
		                _debugMarkerColor = "ColorGreen";
		            };
		            
		            [_debugMarkerName, getPos (_vehicle), "mil_dot", _debugMarkerColor, "Traffic"] call ENGIMA_TRAFFIC_SetDebugMarkerAllClients;
		            
		        } foreach _activeVehiclesAndGroup;
		    
		    	sleep 1;
		    };
    	} else {
    		sleep _sleepSeconds;
    	};
	};
};

ENGIMA_TRAFFIC_functionsInitialized = true;
