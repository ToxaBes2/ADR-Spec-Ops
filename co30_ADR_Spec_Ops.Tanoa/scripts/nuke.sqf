/*
Author: ToxaBes
Based on script made by MOERDERHOSCHI
*/
_epicenter = _this select 0;

// we don't want to show it for all players
//if (player distance _epicenter > 5000) exitWith {};

// make fake object for attaching effects
_object = createVehicle ["Land_HelipadEmpty_F", _epicenter, [], 0, "NONE"];

// smoke conus
_cone = "#particlesource" createVehicleLocal _epicenter;
_cone setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48],"","Billboard",1,10,[0, 0, 0],
                    [0, 0, 0],0,1.275,1,0,[40,80],
                    [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5],[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], 
				    [0.25],0.1,1,"","",_object];
_cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
_cone setParticleCircle [10, [-10, -10, 20]];
_cone setDropInterval 0.005;

// top of conus
_top = "#particlesource" createVehicleLocal _epicenter;
_top setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 20, [0, 0, 0],
				[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _object];
_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top setDropInterval 0.002;
_top2 = "#particlesource" createVehicleLocal _epicenter;
_top2 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 112, 0], "", "Billboard", 1, 20, [0, 0, 0],
				[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", _object];
_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top2 setDropInterval 0.002;
_smoke = "#particlesource" createVehicleLocal _epicenter;
_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
				[0, 0, 60], 0, 1.7, 1, 0, [40,15,120], 
				[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
				, [0.5, 0.1], 1, 1, "", "", _object];
_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_smoke setDropInterval 0.002;

// wave
_wave = "#particlesource" createVehicleLocal _epicenter;
_wave setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
				[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
				[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", _object];
_wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_wave setParticleCircle [50, [-80, -80, 2.5]];
_wave setDropInterval 0.0002;

// light
_light = "#lightpoint" createVehicleLocal [(_epicenter select 0),(_epicenter select 1),((_epicenter select 2) + 500)];
_light setLightAmbient[1500, 1200, 1000];
_light setLightColor[1500, 1200, 1000];
_light setLightBrightness 100000.0;

// flash
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [1];
"dynamicBlur" ppEffectCommit 1;
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [0.8, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.0, 0.6, 2],[0.3, 0.3, 0.3, 0.1]];
"colorCorrections" ppEffectCommit 0.4;
"dynamicBlur" ppEffectAdjust [0.5];
"dynamicBlur" ppEffectCommit 3;
_xHandle = []spawn
{
	Sleep 1;
	"colorCorrections" ppEffectAdjust [1.0, 0.5, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
	"colorCorrections" ppEffectCommit 2;
};
"dynamicBlur" ppEffectAdjust [2];
"dynamicBlur" ppEffectCommit 1;
"dynamicBlur" ppEffectAdjust [0.5];
"dynamicBlur" ppEffectCommit 4;
_light setLightBrightness 100000.0;
sleep 3.5;
"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
"colorCorrections" ppEffectCommit 1; 
"colorCorrections" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 1;

// earthquake
player spawn {
	[ceil(random 4)] spawn BIS_fnc_earthQuake;
};

// last fog
_wave setDropInterval 0.001;
deletevehicle _top;
deletevehicle _top2;
sleep 4.5;
_i = 0;
while {_i < 100} do
{
	_light setLightBrightness 100.0 - _i;
	_i = _i + 1;
	sleep 0.1;
};
deleteVehicle _light;
sleep 2;
_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
				[0, 0, 45], 0, 1.7, 1, 0, [40,25,80], 
				[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
				, [0.5, 0.1], 1, 1, "", "", _object];

_cone setDropInterval 0.01;
_smoke setDropInterval 0.006;
_wave setDropInterval 0.001;
sleep 2;
_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
				[0, 0, 30], 0, 1.7, 1, 0, [40,25,80], 
				[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
				, [0.5, 0.1], 1, 1, "", "", _object];
_smoke setDropInterval 0.012;
_cone setDropInterval 0.02;
_wave setDropInterval 0.01;
sleep 15;
deleteVehicle _wave;
deleteVehicle _cone;
deleteVehicle _smoke;
sleep 6;
"colorCorrections" ppEffectEnable false;
sleep 2;
"dynamicBlur" ppEffectEnable false;