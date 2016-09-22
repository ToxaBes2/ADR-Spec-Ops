/*
Author: ToxaBes
Description: endless game mission on Kavala
*/
EG_PHASE = 0; publicVariable "EG_PHASE";
_initBlufor = [3016.15,11812.8,0];
_initResistance = [3564.8,14423.8,0];
_avanpostBluforPos = [3039.23,12208.7,0];
_avanpostBluforDir = 92;
_avanpostResistancePos = [3495.25,14143.4,0];
_avanpostResistance = 0;
_pointsA = [
    [["O_MRAP_02_hmg_F",[3271.03,12453.9,0],82.3726,"target_vehicle"],["O_APC_Wheeled_02_rcws_F",[3282.68,12454.5,0],103.812,"guard_vehicle"]],
    [["I_APC_Wheeled_03_cannon_F",[3444.77,12783.3,0],216.31,"target_vehicle"],["I_MRAP_03_hmg_F",[3447.43,12797.1,0],162.233,"guard_vehicle"]],
    [["I_Truck_02_ammo_F",[3543.12,12448.4,0],51.0007,"target_vehicle"],["I_Truck_02_covered_F",[3550.19,12465.1,0],8.6425,"guard_destroyed"],["I_G_Offroad_01_armed_F",[3526.3,12445.4,0],264.652,"guard_vehicle"],["I_G_Offroad_01_armed_F",[3571.1,12490.6,0],235.833,"guard_vehicle"]]
];
_pointsB = [
    [["O_Heli_Transport_04_bench_F",[3202.63,13187.1,0],0.0918834,"target_vehicle"],["O_UGV_01_rcws_F",[3162.73,13124.7,0],98.5032,"guard_vehicle"]], 
    [["I_SDV_01_F",[3314.25,12914,-0.5],90.866,"target_sdv"],["I_Boat_Armed_01_minigun_F",[3294.78,12916.3,-0.95],75.6962,"guard_vehicle"]],
    [["I_Heli_light_03_F",[3660.37,12812.6,13.5],65.3845,"target_heli_destroyed"],["O_APC_Tracked_02_cannon_F",[3651.25,12811.7,0],154.167,"guard_vehicle"]]
];
_pointsC = [
    [["B_T_UAV_03_F",[3731.24,12976.7,0],89.8967,"target"],["I_MBT_03_cannon_F",[3742.65,12996.3,0],256.024,"guard_vehicle"]],
    [["O_UAV_02_CAS_F",[3649.91,13111.4,0],315.255,"target"],["O_MRAP_02_gmg_F",[3647.82,13137.9,0],273.6,"guard_vehicle"],["O_MRAP_02_hmg_F",[3613.79,13118.6,0],189.599,"guard_vehicle"]],
    [["O_Heli_Attack_02_black_F",[3475.41,13057.5,2.5],99.349,"target"],["O_UGV_01_rcws_F",[3475.51,13069,0],0.0210689,"guard_vehicle"],["O_UGV_01_rcws_F",[3489.31,13040.1,0],172.638,"guard_vehicle"]]
];
_pointsD = [
    [["Land_Device_disassembled_F",[3792.55,13415.8,6.4],209.251,"target"]],
    [["B_Heli_Transport_03_unarmed_F",[3604.07,13470.5,0],136.871,"target_heli"],["B_GEN_Offroad_01_gen_F",[3593.5,13476.8,0],97.3622,"guard_empty"]],
    [["B_MBT_01_TUSK_F",[3502.21,13372.7,1],159.467,"target_vehicle"],["B_APC_Wheeled_01_cannon_F",[3493.57,13376.1,19.5],34.142,"guard_vehicle"]]
];
_pointsE = [
    [["Land_Wreck_Heli_Attack_01_F",[3576.46,13843.1,0],217.161,"target_sdv"],["I_Boat_Armed_01_minigun_F",[3510.24,13827.2,0],128.481,"guard_vehicle"],["I_Boat_Transport_01_F",[3547.47,13832.8,0],85.144,"guard_empty"],["I_Boat_Transport_01_F",[3545.3,13836.1,0],67.6056,"guard_empty"],["I_Boat_Transport_01_F",[3541.7,13830.1,0],101.223,"guard_empty"],["I_SDV_01_F",[3535.97,13820.9,-0.9],98.5877,"guard_empty"],["I_SDV_01_F",[3529.19,13843,-1],98.8715,"guard_empty"]],
    [["O_UGV_01_F",[3833.08,13732.8,0],0.75516,"target_vehicle"],["Land_PortableGenerator_01_F",[3834.95,13732,0],350.663,"guard_empty"],["WaterPump_01_sand_F",[3837.85,13735.6,0],146.624,"guard_empty"],["Land_EngineCrane_01_F",[3832.35,13732.8,0],268.837,"guard_empty"]],
    [["O_Truck_03_device_F",[3717.53,13853.4,0],284.927,"target_vehicle"],["O_Truck_03_medical_F",[3736.49,13862.3,0],265.829,"guard_empty"]]
];
_avanpostBluforData = [["Land_CncWall4_F",[3038.47,12210.1,0],0,""],["Land_Garbage_square5_F",[3037.08,12212.8,0.00544071],0,""],
["Land_CncShelter_F",[3034.57,12209.4,0.00232792],180,""],["Land_CncWall4_F",[3043.72,12210.1,0],0,""],
["Land_CncShelter_F",[3034.57,12210.8,0.00200844],180,""],["Land_CratesWooden_F",[3043.34,12211.9,0.00296402],90.0478,""],
["Land_WaterTank_F",[3040.31,12213.8,0.00268745],0.173473,""],["Land_LampHalogen_F",[3041.47,12203.3,-9.53674e-007],60,""],
["Land_CncWall4_F",[3043.22,12204.1,0],180,""],["Land_CratesWooden_F",[3045.19,12205.4,0.0156441],0,""],
["Land_MetalBarrel_F",[3039.29,12201.7,0.0185671],243.244,""],["Land_PowerGenerator_F",[3032.12,12209,0.000901699],270.081,""],
["Land_MetalBarrel_F",[3038.36,12201.5,0.0755796],110.086,""],["Land_CncWall4_F",[3045.97,12212.4,-9.53674e-007],270,""],
["Land_MetalBarrel_F",[3039.28,12200.9,0.0593443],150.549,""],["Land_CncBarrierMedium4_F",[3040.47,12200.9,0],90,""],
["Land_CncWall4_F",[3030.97,12210.4,-4.76837e-007],0,""],["CamoNet_BLUFOR_open_F",[3031.63,12203.9,1.411],90,""],
["Land_Tyres_F",[3048.03,12213.4,-0.00536156],0,""],["Land_CncWall4_F",[3048.47,12204.1,-9.53674e-007],180,""],
["CamoNet_BLUFOR_open_F",[3031.38,12216.4,1.2408],90,""],["Land_Sacks_heap_F",[3048.76,12202.3,0.00955009],224.008,""],
["Land_CncWall4_F",[3050.72,12207.1,-9.53674e-007],270,""],["Land_CncWall4_F",[3048.97,12215.1,0],0,""],
["Land_Cargo_HQ_V1_F",[3041.22,12221.1,-9.53674e-007],0,""],["Land_Cargo_Patrol_V1_F",[3049.72,12200.6,0.194992],270,""],
["Land_CncWall4_F",[3050.72,12201.9,0],270,""],["Land_Cargo_House_V1_F",[3025.97,12206.6,0],270,""],
["Land_CncWall4_F",[3025.72,12210.4,-4.76837e-007],0,""],["Land_CncBarrierMedium4_F",[3036.22,12195.1,0],90,""],
["Land_PaperBox_open_empty_F",[3043.62,12194.9,0.0145655],239.069,""],["Land_Cargo_House_V1_F",[3025.72,12213.9,-4.76837e-007],270,""],
["Land_BarrelSand_F",[3035.06,12194.7,0.00912189],0.00192251,""],["Land_CncWall4_F",[3051.22,12217.4,-1.90735e-006],270,""],
["Land_CncBarrierMedium4_F",[3024.97,12202.9,0],0,""],["Land_Sacks_heap_F",[3041.15,12192.6,0.00941181],224.108,""],
["Land_BarrelTrash_grey_F",[3039.02,12192.5,0.0181618],359.996,""],["Land_MetalBarrel_F",[3039.77,12192.5,0.0203915],359.958,""],
["Land_Sacks_heap_F",[3042.28,12192.8,0.00941181],0,""],["Land_JunkPile_F",[3034.07,12193.3,0.0340996],0,""],
["Land_Pallet_MilBoxes_F",[3026.43,12198.5,-0.00394917],254.651,""],["Land_PaperBox_closed_F",[3044.04,12193.1,0.0132561],254.217,""],
["Land_PaperBox_open_full_F",[3045.7,12193.5,0.0280905],253.784,""],["Land_CncWall4_F",[3050.72,12196.6,0],270,""],
["Land_CncWall1_F",[3022.47,12210.4,0],0,""],["Land_CncBarrierMedium4_F",[3024.72,12217.4,0],0,""],
["Land_CncWall4_F",[3038.72,12191.6,-9.53674e-007],0,""],["Land_Cargo10_grey_F",[3032.64,12224.9,0.0336437],270.052,""],
["Land_Cargo_Patrol_V1_F",[3032.97,12192.1,0.0184431],0,""],["Land_CncWall4_F",[3043.97,12191.6,0],0,""],
["Land_CncWall1_F",[3021.47,12210.4,0],0,""],["Land_Cargo10_grey_F",[3023.28,12200.6,0.249822],181.195,""],
["Land_CncWall4_F",[3033.47,12191.6,-9.53674e-007],0,""],["Land_CncWall4_F",[3021.22,12206.9,0],90,""],
["Land_CargoBox_V1_F",[3029.12,12193.4,0.0516882],150.163,""],["Land_CncWall4_F",[3021.22,12212.1,4.76837e-007],90,""],
["Land_CncWall4_F",[3051.22,12222.6,0],270,""],["Land_CncWall4_F",[3048.72,12192.9,0],330,""],
["Land_Cargo10_light_green_F",[3028.07,12223.9,0.400532],239.2,""],["Land_PaperBox_closed_F",[3022.9,12198.7,0.00447464],0,""],
["Land_CncWall4_F",[3021.22,12201.6,-4.76837e-007],90,""],["Land_PaperBox_open_empty_F",[3026.9,12193.5,0.00457478],105.159,""],
["Land_CncWall4_F",[3039.97,12228.6,0],180,""],["Land_CncWall4_F",[3021.22,12217.4,0.462438],90,""],
["Land_Ammobox_rounds_F",[3023.83,12195.8,0.0012455],44.6416,""],["Land_PaperBox_open_full_F",[3022.9,12196.9,0.00532103],0,""],
["Land_Ammobox_rounds_F",[3024.08,12195.4,0.00125456],14.8811,""],["Land_CncWall4_F",[3028.22,12191.6,4.76837e-007],0,""],
["Land_Cargo_Patrol_V1_F",[3022.72,12221.1,-4.76837e-007],90,""],["Land_CncWall4_F",[3045.22,12228.6,-9.53674e-007],180,""],
["Land_CncWall4_F",[3049.47,12226.9,0],225,""],["Land_CncShelter_F",[3036.1,12229.4,0.00177383],0,""],
["Land_CncWall4_F",[3032.47,12228.6,-9.53674e-007],180,""],["FlexibleTank_01_forest_F",[3023.91,12194,0.0075779],0.00845861,""],
["Box_NATO_AmmoVeh_F",[3023.01,12194.9,0.0528021],59.9536,""],["Land_CncWall4_F",[3021.22,12196.4,0],90,""],
["Land_CncWall4_F",[3023.47,12192.9,0],30,""],["Land_CncShelter_F",[3036.1,12230.9,0.00177383],0,""],
["Land_CncWall4_F",[3021.22,12222.6,-4.76837e-007],90,""],["Land_Sacks_heap_F",[3022.83,12224.9,0.000292778],120.023,""],
["Land_CncWall4_F",[3027.22,12228.6,4.76837e-007],180,""],["Land_CncShelter_F",[3036.1,12232.3,0.00177383],0,""],
["B_Quadbike_01_F",[3046.36,12231.7,0.008358],89.9473,""],["Land_CncWall4_F",[3022.97,12226.9,-4.76837e-007],135,""],
["Land_CncShelter_F",[3036.17,12233.9,0.00507355],0,""],["B_Quadbike_01_F",[3046.34,12234.2,0.0135889],90.1873,""],
["Land_CncShelter_F",[3036.17,12235.4,0.00403404],180,""],["Land_CncWall1_F",[3039.47,12235.9,-9.53674e-007],0,""],
["Land_CncWall1_F",[3038.09,12235.9,0],0,""],["Land_CncWall1_F",[3040.47,12236.1,9.53674e-007],330,""],
["Land_CncWall4_F",[3032.47,12235.6,0],0,""],["Land_CncWall1_F",[3029.72,12236.1,0],45,""],
["B_Quadbike_01_F",[3046.52,12236.8,0.0152016],90.1864,""],["Land_CncWall4_F",[3040.97,12238.9,-9.53674e-007],270,""],
["Land_GarbageBags_F",[3038.3,12239.1,-0.0889912],0,""],["B_Quadbike_01_F",[3046.49,12239.4,0.0137653],90.1246,""],
["Land_CncWall4_F",[3029.22,12238.9,0],90,""],["Land_Cargo_Tower_V1_F",[3035.72,12241.6,9.53674e-007],270,""],
["B_Quadbike_01_F",[3046.5,12242.3,0.0137749],90.1929,""],["Land_CncWall4_F",[3040.97,12244.1,-9.53674e-007],270,""],
["Land_GarbageWashingMachine_F",[3032.2,12244.4,0.000455856],0,""],["Land_CncWall4_F",[3029.22,12244.1,0],90,""],
["B_Quadbike_01_F",[3046.37,12245,0.0123396],90.1109,""],["Land_CncWall1_F",[3040.47,12246.9,0],225,""],
["Land_CncWall4_F",[3037.72,12247.4,0],180,""],["Land_CncWall1_F",[3036.87,12247.5,0],181.388,""],
["Land_CncWall1_F",[3035.58,12247.5,0],181.634,""],["Land_CncWall1_F",[3034.26,12247.5,0],181.439,""],
["Land_CncWall4_F",[3032.47,12247.4,-9.53674e-007],180,""],["Land_CncWall1_F",[3029.72,12246.9,-9.53674e-007],135,""],
["O_HMG_01_high_F",[3041.33,12205.5,0.014267],63.4859,""],["O_HMG_01_high_F",[3039.58,12217.5,3.14863],181.186,""],
["O_HMG_01_high_F",[3036.64,12237.2,17.8937],178.331,""]];

_avanpostResistanceData = [["Land_HBarrierWall4_F",[3491.29,14136.2,3.05176e-005],180,""],["B_Quadbike_01_F",[3502.98,14146.4,0.00415802],268.209,""],
["Land_CncShelter_F",[3495.22,14134.7,6.29425e-005],0,""],["Land_Cargo_HQ_V3_F",[3489.28,14150.7,0],90,""],
["Land_HBarrier_Big_F",[3500.62,14135.8,0.00208092],182.759,""],["B_Quadbike_01_F",[3502.47,14150.9,0.00266457],267.943,""],
["Land_Cargo_Patrol_V3_F",[3504.73,14139.3,0],0,""],["Land_PowerGenerator_F",[3504.15,14137.9,0.000656128],0,""],
["Land_HBarrierWall4_F",[3503.2,14135.9,0.000240326],180,""],["Land_BagFence_Round_F",[3497.44,14131.7,0.326782],45,""],
["Land_HBarrierWall6_F",[3507.48,14142.1,0.0153046],89.9894,""],["Land_CratesWooden_F",[3506.3,14137.8,0.000501633],183.828,""],
["Land_BagFence_Round_F",[3499.57,14131.7,0.326805],315,""],["Land_PaperBox_open_full_F",[3483.66,14137.5,-7.62939e-006],90.001,""],
["Land_HBarrierWall6_F",[3484.41,14136.2,-0.00182915],180,""],["Land_HBarrierWall6_F",[3499.76,14156.2,-0.0102787],0,""],
["Land_HBarrierWall6_F",[3507.26,14150.3,0.00933456],89.9959,""],["Land_HBarrierWall_corner_F",[3507.69,14136.5,0.00100708],90.055,""],
["Land_PaperBox_closed_F",[3478.7,14143.3,0.194767],0,""],["Land_PaperBox_open_empty_F",[3478.69,14140.8,0.233973],165,""],
["Land_HBarrierWall_corner_F",[3506.54,14156.2,0.000326157],0,""],["Land_HBarrier_1_F",[3478.18,14139.2,0.332432],270,""],
["Land_HBarrierWall6_F",[3476.93,14141.3,0.157837],270.003,""],["Land_HBarrierWall4_F",[3481.07,14156.1,3.8147e-006],0,""],
["Land_HBarrierWall_corner_F",[3477.56,14136.2,1.33514e-005],180,""],["Land_LampHalogen_F",[3509.58,14130.8,-0.00100136],70.3531,""],
["Land_HBarrierWall6_F",[3476.68,14149.5,0.158468],270.002,""],["B_GMG_01_high_F",[3479.5,14157.2,18.0123],359.988,""],
["Land_Cargo_Tower_V3_F",[3476.18,14154.3,0.173206],180,""],["Land_HBarrierWall_corner_F",[3476.39,14156.2,3.05176e-005],269.999,""],
["Land_HBarrier_Big_F",[3472.93,14152.7,0.170441],270.006,""],["Land_LampHalogen_F",[3477.5,14160.3,-0.00166321],277.827,""],
["Land_HBarrier_Big_F",[3472.95,14154.8,0.171293],269.997,""],["Land_HBarrier_Big_F",[3470.93,14152.7,0.170204],270.003,""],
["Land_HBarrier_Big_F",[3470.93,14154.7,0.169233],269.999,""],["B_HMG_01_high_F",[3490.45,14145.2,3.09515],172.977,""],
["B_HMG_01_high_F",[3498.11,14132.3,0.0692444],180.083,""]];

_allObjs = [];
_objs1 = [_avanpostBluforPos, _avanpostBluforData] call QS_fnc_EGcreateAvanpost;
_allObjs = _allObjs + _objs1;

_objs2 = [_avanpostResistancePos, _avanpostResistanceData] call QS_fnc_EGcreateAvanpost;
_allObjs = _allObjs + _objs2;

// wait for phase #1 done (take outpost)
waitUntil {sleep 1;EG_PHASE isEqualTo 1};

// [] call QS_fnc_EGcreateTarget;

// wait for phase #2 done (find schemes)
waitUntil {sleep 1;EG_PHASE isEqualTo 2};

// wait for phase #3 done (load schemes)
waitUntil {sleep 1;EG_PHASE isEqualTo 3};



