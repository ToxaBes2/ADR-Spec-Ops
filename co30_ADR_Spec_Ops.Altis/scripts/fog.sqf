/*
Author: ToxaBes
Description: yellow fog
*/
_epicenter = _this select 0;
_time = _this select 1;
_ps = "#particlesource" createVehicleLocal _epicenter;   
_ps setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], 
    "", 
    "Billboard", 
    1, 
    40, 
    [0, 0, 0], 
    [0, 0, 0.05], 
    0.1, 1, 0.8, 0.05, 
    [1, 3, 3], 
    [[1, 0.8, 0, 0.15],[1, 0.8, 0, 0.1]],
    [0.015], 
    1, 
    0, 
    "", 
    "", 
    "",
    0,
    true,
    0.4,
    [[0, 0, 0, 0]]
];
_ps setParticleCircle [0.8, [0.3, 0.3, 0]];
_ps setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_ps setDropInterval 0.05;
sleep _time;
deleteVehicle _ps;