/*
Author: ALIAS
Description: script for vanilla assets, which provides a way to customize brightness and range for flares
*/
private ["_al_shooter","_al_color_flare","_al_flare_light","_flare_brig","_inter_flare","_int_mic","_al_flare","_type_flares"];

if (!hasInterface) exitWith {};
_al_flare                  = _this select 0;
_al_flare_intensity        = 30;
_al_flare_range            = 150;
_al_mortar_flare_intensity = 100;
_al_mortar_flare_range     = 300;
_mortar_flare_on           = false;
_type_flares               = ["F_40mm_White","F_40mm_Red","F_40mm_Yellow","F_40mm_Green","Flare_82mm_AMOS_White"];
if ((typeOf _al_flare) in _type_flares) then {	
    switch (typeOf _al_flare) do {
        case "F_40mm_White": {
            _al_color_flare = [0.7,0.7,0.8];
        };
        case "F_40mm_Red": {
            _al_color_flare = [0.7,0.15,0.1];
        };
        case "F_40mm_Yellow": {
            _al_color_flare = [0.7,0.7,0];
        };
        case "F_40mm_Green": {
            _al_color_flare = [0.2,0.7,0.2];
        };
        case "Flare_82mm_AMOS_White": {
            _al_color_flare = [1,1,1];
            _mortar_flare_on = true;
        };
    };
	sleep 3;	
	_al_flare_light = "#lightpoint" createVehicle getPosATL _al_flare;
	_al_flare_light setLightAmbient _al_color_flare;  
	_al_flare_light setLightColor _al_color_flare;
	_al_flare_light setLightIntensity _al_flare_intensity;
	if (_mortar_flare_on) then {
		_al_flare_light setLightIntensity _al_mortar_flare_intensity;
	};
	_al_flare_light setLightUseFlare true;
	_al_flare_light setLightFlareSize 10;
	_al_flare_light setLightFlareMaxDistance 2000;
	_al_flare_light setLightAttenuation [_al_flare_range,1,1000,50,_al_flare_range-10]; 
	if (_mortar_flare_on) then {
		_al_flare_light setLightAttenuation [_al_mortar_flare_range,1,1000,50,_al_mortar_flare_range-10];
		_mortar_flare_on = false;
	};
	_al_flare_light setLightDayLight true;
	_inter_flare = 0;	
	_type_flare = _al_flare_intensity;
	if (_mortar_flare_on) then {
		_type_flare = _al_mortar_flare_intensity;
	};
	while {!isNull _al_flare} do {
		_int_mic = 0.05 + random 0.01;
		sleep _int_mic;
		_flare_brig = _type_flare + random 10;
		_al_flare_light setLightIntensity _flare_brig;
		_inter_flare = _inter_flare + _int_mic;
		_al_flare_light setpos (getPosATL _al_flare);
	};
};