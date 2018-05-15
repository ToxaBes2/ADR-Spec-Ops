disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_grpCtrl = _display displayCtrl IDC_CTAB_GROUP_BALLISTIC;
_ctrlTargetX = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_TARGET_X;
_ctrlTargetY = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_TARGET_Y;
_ctrlBatteryX = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_X;
_ctrlBatteryY = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_Y;
_ctrlVehicle = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_W;
_ctrlAmmo = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_BATTERY_A;
_ctrlMode = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_MODE;

_targetPosX = ctrlText _ctrlTargetX;
_targetPosY = ctrlText _ctrlTargetY;
_artyPosX = ctrlText _ctrlBatteryX;
_artyPosY = ctrlText _ctrlBatteryY;

_slopeX = 0;
_slopeY = 0;
_offX = 0;
_offY = 0;
_vehIdx = lbCurSel _ctrlVehicle;
_vehClass = _ctrlVehicle lbData _vehIdx;
_ammoIdx = lbCurSel _ctrlAmmo;
_ammoClass = _ctrlAmmo lbData _ammoIdx;

_modeIdx = lbCurSel _ctrlMode;
_mode = _ctrlMode lbData _modeIdx;

if (_artyPosX == "" || _artyPosY == "" || _targetPosX == "" || _targetPosY == "" || _vehClass == "" || _ammoClass == "") exitWith {
	systemChat "Укажите необходимые параметры!";
};

_targetPosX = parseNumber (_targetPosX);
_targetPosY = parseNumber (_targetPosY);
_artyPosX = parseNumber (_artyPosX);
_artyPosY = parseNumber (_artyPosY);

_artyAlt = getTerrainHeightASL [_artyPosX, _artyPosY];
_targetAlt = getTerrainHeightASL [_targetPosX, _targetPosY];

_mkrName1 = "targetMKR";
_mkrName2 = "batteryMKR";
deleteMarkerLocal _mkrName1;
deleteMarkerLocal _mkrName2;
_marker1 = createMarkerLocal [_mkrName1,  [_artyPosX, _artyPosY, 0]];
_marker1 setMarkerSize [1,1];
_marker1 setMarkerType "mil_start";
_marker1 setMarkerColor "ColorBlue";
_marker2 = createMarkerLocal [_mkrName2, [_targetPosX, _targetPosY,0]];
_marker2 setMarkerSize [1,1];
_marker2 setMarkerType "mil_end";
_marker2 setMarkerColor "ColorRed";

if (_artyPosX == _targetPosX && _artyPosY == _targetPosY) exitWith {
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ETA) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_DIR) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ELV) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ETA) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_DIR) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ELV) ctrlSetText "000.00";	
  	systemChat "Невозможно поразить цель!";
};
_dist = sqrt((_artyPosX-_targetPosX)^2+(_artyPosY-_targetPosY)^2);
_dir = acos((_targetPosY-_artyPosY)/sqrt((_targetPosX-_artyPosX)^2+(_targetPosY-_artyPosY)^2));
if (_artyPosX >= _targetPosX) then {
	_dir = 360 - _dir;
};
_g = 9.80665;
_alt = _targetAlt-_artyAlt;
_weapon = getArray(configfile >> "CfgVehicles" >> _vehClass >> "Turrets" >> "MainTurret" >> "weapons") select 0;
_magazine = getArray(configfile >> "CfgWeapons" >> _weapon >> "magazines") select _ammoIdx;
_ammoSpeed = getNumber(configfile >> "CfgMagazines" >> _magazine >> "initSpeed");
_v = _ammoSpeed * getNumber(configfile >> "CfgWeapons" >> _weapon >> _mode >> "artilleryCharge");
if (_v^4-_g*(_g*_dist^2+2*_alt*_v^2) < 0) exitWith {
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ETA) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_DIR) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ELV) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ETA) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_DIR) ctrlSetText "000.00";
  	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ELV) ctrlSetText "000.00";	
  	systemChat "Невозможно поразить цель!";
};
_highAngle = atan((_v^2+sqrt(_v^4-_g*(_g*_dist^2+2*_alt*_v^2)))/(_g*_dist));
_highETA = _dist/(_v*cos(_highAngle));
_lowAngle = atan((_v^2-sqrt(_v^4-_g*(_g*_dist^2+2*_alt*_v^2)))/(_g*_dist));
_lowETA = _dist/(_v*cos(_lowAngle));

_vectorUp = [rad(_slopeX), rad(_slopeY), 1-(rad(_slopeX)+rad(_slopeY))];
_vectorUp = vectorNormalized _vectorUp;
_vectorHigh = [sin(_dir), cos(_dir), 1*sin(_highAngle)/sin(90-_highAngle)];
_vectorLow = [sin(_dir), cos(_dir), 1*sin(_lowAngle)/sin(90-_lowAngle)];
_highAngleRel = 90 - acos(_vectorUp vectorCos _vectorHigh);
_lowAngleRel = 90 - acos(_vectorUp vectorCos _vectorLow);
_a = (_vectorHigh select 2)/(_vectorUp select 2);
_x = (_vectorHigh select 0) - _a*(_vectorUp select 0);
_y = (_vectorHigh select 1) - _a*(_vectorUp select 1);
_highDirRel = acos([0,1,0] vectorCos [_x, _y, 0]);
if (_x < 0) then {
	_highDirRel = 360 - _highDirRel;
};
_a = (_vectorLow select 2)/(_vectorUp select 2);
_x = (_vectorLow select 0) - _a*(_vectorUp select 0);
_y = (_vectorLow select 1) - _a*(_vectorUp select 1);
_lowDirRel = acos([0,1,0] vectorCos [_x, _y, 0]);
if (_x < 0) then {
	_lowDirRel = 360 - _lowDirRel;
};

_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ELV ctrlSetText str(round(_lowAngleRel*100)/100);
_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_DIR ctrlSetText str(round(_lowDirRel*100)/100);
_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ETA ctrlSetText str(round(_lowETA));
_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ELV ctrlSetText str(round(_highAngleRel*100)/100);
_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_DIR ctrlSetText str(round(_highDirRel*100)/100);
_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ETA ctrlSetText str(round(_highETA));

_minAngle = getNumber(configfile >> "CfgVehicles" >> _vehClass >> "Turrets" >> "MainTurret" >> "minElev");
_maxAngle = getNumber(configfile >> "CfgVehicles" >> _vehClass >> "Turrets" >> "MainTurret" >> "maxElev");
if (_vehClass == "B_Mortar_01_F") then { //mortar fix
	_minAngle = 45;
	_maxAngle = 88;
};
if (_lowAngleRel < _minAngle || _lowAngleRel > _maxAngle) then {
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_DIR) ctrlSetTextColor [1, 0, 0, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ELV) ctrlSetTextColor [1, 0, 0, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ETA) ctrlSetTextColor [1, 0, 0, 1];
} else {
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_DIR) ctrlSetTextColor [1, 1, 1, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ELV) ctrlSetTextColor [1, 1, 1, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ETA) ctrlSetTextColor [1, 1, 1, 1];
};
if (_highAngleRel < _minAngle || _highAngleRel > _maxAngle) then {
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_DIR) ctrlSetTextColor [1, 0, 0, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ELV) ctrlSetTextColor [1, 0, 0, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ETA) ctrlSetTextColor [1, 0, 0, 1];
} else {
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_DIR) ctrlSetTextColor [1, 1, 1, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ELV) ctrlSetTextColor [1, 1, 1, 1];
	(_grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ETA) ctrlSetTextColor [1, 1, 1, 1];
};