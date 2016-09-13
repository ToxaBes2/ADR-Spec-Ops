/*
Author: ToxaBes
Description: endless game mission on Kavala
*/
_initBlufor = [3016.15,11812.8,0];
_initResistance = [3564.8,14423.8,0];
_avanpostBluforPos = [3039.23,12208.7,0];
_avanpostBluforDir = 92;
_avanpostResistancePos = [3495.25,14143.4,0];
_avanpostResistance = 0;
_pointsA = [
    [["O_MRAP_02_hmg_F",[3271.03,12453.9,0],82.3726,"target_vehicle"],["O_APC_Wheeled_02_rcws_F",[3282.68,12454.5,0],103.812,"guard_vehicle"]],
    [["I_APC_Wheeled_03_cannon_F",[3444.77,12783.3,0],216.31,"target_vehicle"],["I_MRAP_03_hmg_F",[3447.43,12797.1,0],162.233,"guard_vehicle"]],
    [["I_Truck_02_ammo_F",[3543.12,12448.4,0],51.0007,"target_vehicle"],["I_Truck_02_covered_F",[3550.19,12465.1,0],8.6425,"guard_destroyed"],     ["I_G_Offroad_01_armed_F",[3526.3,12445.4,0],264.652,"guard_vehicle"],["I_G_Offroad_01_armed_F",[3571.1,12490.6,0],235.833,"guard_vehicle"]]
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
_avanpostBluforData = [["Land_CncWall4_F",[-0.540771,1.22363,0.00683689],0],["O_HMG_01_high_F",[2.10327,-3.1582,0.0705309],63.4771],
["Land_Garbage_square5_F",[-2.104,4.14258,0.0105715],0],["Land_CncShelter_F",[-4.58398,0.769531,0.00232601],180],
["Land_CncWall4_F",[4.70923,1.22363,0.00683689],0],["Land_CncShelter_F",[-4.58398,2.125,0.00200844],180],
["Land_CratesWooden_F",[4.18384,3.25195,0.00296211],90.0478],["Land_WaterTank_F",[1.08472,5.14844,0.0188293],359.944],
["Land_LampHalogen_F",[2.22339,-5.43848,0],60],["Land_CncWall4_F",[4.24731,-4.24707,0.0247545],180],
["Land_MetalBarrel_F",[-0.800293,-6.0791,-0.145186],344.725],["Land_CratesWooden_F",[6.10986,-3.29785,0.0156221],0],
["Land_PowerGenerator_F",[-7.06982,0.369141,0.000901222],270.081],["Land_MetalBarrel_F",[-2.05859,-7.00195,-0.147711],348.533],
["Land_CncWall4_F",[7.28711,3.74316,0.0658627],270],["Land_MetalBarrel_F",[0.0651855,-7.81641,0.0426598],150.677],
["Land_CncBarrierMedium4_F",[1.39502,-7.89063,0.018424],90],["Land_CncWall4_F",[-8.11108,1.43359,0.00496578],0],
["O_HMG_01_high_F",[0.350586,8.8125,-0.112123],181.189],["CamoNet_BLUFOR_open_F",[-8.1626,-4.8623,-0.0239391],89.9905],
["Land_Tyres_F",[8.78687,4.79688,0.175659],0],["Land_CncWall4_F",[9.56494,-4.35059,0.0208874],180],
["CamoNet_BLUFOR_open_F",[-8.35864,7.62402,-0.0522604],90.1365],["Land_Sacks_heap_F",[9.61206,-6.44531,0.00948811],224.008],
["Land_CncWall4_F",[12.0361,-1.66211,0.0683546],270],["Land_CncWall4_F",[9.98315,6.12305,0.0256453],0],["Land_Cargo_HQ_V1_F",[2.78467,13.2197,0],0],
["Land_Cargo_Patrol_V1_F",[11.7366,-8.05664,0.194992],270],["Land_CncWall4_F",[12.1077,-6.92383,0.0937939],270],
["Land_Cargo_House_V1_F",[-14.2388,-2.05371,4.76837e-007],270],["Land_CncWall4_F",[-13.1699,1.57324,0.0162373],0],
["Land_CncBarrierMedium4_F",[-2.87109,-13.5107,0.0120983],90],["Land_PaperBox_open_empty_F",[4.51929,-13.7979,0.0145445],239.069],
["Land_Cargo_House_V1_F",[-14.4888,5.19629,0],270],["Land_BarrelSand_F",[-4.16406,-14.0313,0.00907135],359.919],
["Land_CncWall4_F",[12.47,8.67578,0.0451469],270],["Land_CncBarrierMedium4_F",[-14.1306,-5.78223,0.00968552],0],
["Land_Sacks_heap_F",[2.00903,-16.0605,0.00939751],224.108],["Land_BarrelTrash_grey_F",[-0.202637,-16.1699,0.0180941],359.981],
["Land_MetalBarrel_F",[0.542725,-16.1699,0.0200033],359.873],["Land_Sacks_heap_F",[3.13403,-15.9355,0.00939655],0],
["Land_JunkPile_F",[-4.89648,-15.4072,0.0340605],0],["Land_Pallet_MilBoxes_F",[-12.7664,-10.0459,-0.00395203],254.651],
["Land_PaperBox_closed_F",[4.94458,-15.6484,0.0132351],254.217],["Land_PaperBox_open_full_F",[6.65527,-15.1836,0.0280533],253.784],
["Land_CncWall4_F",[12.0347,-12.25,0.0756817],270],["Land_CncWall1_F",[-16.7659,1.57129,-0.0180731],0],
["Land_CncBarrierMedium4_F",[-14.4531,8.71777,0.00164795],0],["Land_CncWall4_F",[-0.116211,-17.4033,0.0587988],0],
["Land_Cargo10_grey_F",[-6.58789,16.2266,0.0340052],270.053],["Land_Cargo_Patrol_V1_F",[-6.26318,-17.8008,0.0184441],0],
["Land_CncWall4_F",[5.14746,-17.3896,0.0592232],0],["Land_CncWall1_F",[-17.7898,1.54785,-0.016016],0],
["Land_Cargo10_grey_F",[-15.9404,-8.06348,0.197618],181.623],["Land_CncWall4_F",[-5.47705,-17.4043,0.0370998],0],
["Land_CncWall4_F",[-18.2424,-1.82813,-0.00546646],90],["Land_CargoBox_V1_F",[-10.104,-15.2969,0.050622],150.159],
["Land_CncWall4_F",[-18.219,3.56348,-0.00470734],90],["Land_CncWall4_F",[12.4038,13.916,0.028183],270],
["Land_CncWall4_F",[9.92285,-16.3164,0.110318],330],["Land_PaperBox_closed_F",[-16.2537,-10.0449,0.00446796],0],
["Land_CncWall4_F",[-18.1975,-7.15332,-0.00809669],90],["Land_Cargo10_light_green_F",[-11.4082,15.6514,0.239881],238.274],
["Land_PaperBox_open_empty_F",[-12.2512,-15.1641,0.00458145],105.159],["Land_CncWall4_F",[0.911377,20.2188,0.00843906],180],
["Land_CncWall4_F",[-18.28,8.66406,-1.51396],90],["Land_Ammobox_rounds_F",[-15.3965,-12.9258,0.0012331],44.734],
["Land_PaperBox_open_full_F",[-16.2515,-11.8174,0.00531435],0],["Land_Ammobox_rounds_F",[-15.1465,-13.3008,0.00124168],14.951],
["Land_CncWall4_F",[-10.7637,-17.3096,0.0149345],0],["Land_Cargo_Patrol_V1_F",[-17.7571,12.4492,0],90],
["Land_CncWall4_F",[6.10303,20.2393,0.00710106],180],["Land_CncWall4_F",[10.5522,18.4346,0.0228224],225],
["Land_CncShelter_F",[-3.05688,20.6895,0.00177383],0],["Land_CncWall4_F",[-6.68188,20.2441,0.00598526],180],
["FlexibleTank_01_forest_F",[-15.3157,-14.6621,0.00749493],359.955],["Box_NATO_AmmoVeh_F",[-16.2126,-13.7588,0.0539222],59.9625],
["Land_CncWall4_F",[-18.1975,-12.4033,-0.00809574],90],["Land_CncWall4_F",[-15.7339,-16.1201,0.00787354],30],
["Land_CncShelter_F",[-3.05688,22.1895,0.00177383],0],["Land_CncWall4_F",[-18.1882,14.0205,-0.010334],90],
["Land_Sacks_heap_F",[-16.3784,16.1699,0.000293732],120.023],["Land_CncWall4_F",[-11.9905,20.2441,0.00436306],180],
["Land_CncShelter_F",[-3.05688,23.624,0.00177383],0],["B_Quadbike_01_F",[7.14185,22.999,-0.00110817],89.9588],
["Land_CncWall4_F",[-16.4053,18.4092,-0.00209618],135],["Land_CncShelter_F",[-2.95801,25.2422,0.00506687],0],
["B_Quadbike_01_F",[7.12402,25.4883,0.00377178],90.1801],["Land_CncShelter_F",[-2.97607,26.75,0.00402927],180],
["Land_CncWall1_F",[0.174316,28.2969,0.206157],0],["Land_CncWall1_F",[-1.20093,28.2969,0.0311384],0],
["Land_CncWall1_F",[1.54224,27.2539,0.0138311],330],["Land_CncWall4_F",[-6.64355,26.707,-0.000844002],0],
["O_HMG_01_high_F",[-2.58447,28.5586,-0.11211],178.329],["Land_CncWall1_F",[-9.67188,27.3291,-0.0114212],45],
["B_Quadbike_01_F",[7.29663,28.1289,0.00230503],90.1781],["Land_CncWall4_F",[2.18823,30.2617,0.0377531],270],
["Land_GarbageBags_F",[-1.28223,29.5781,-0.0889454],0],["B_Quadbike_01_F",[7.27173,30.7568,-0.000332832],90.1206],
["Land_CncWall4_F",[-10.2,30.1963,-0.0106916],90],["Land_Cargo_Tower_V1_F",[-5.11523,33.2686,0],270],
["B_Quadbike_01_F",[7.28174,33.5957,0.000751495],90.1825],["Land_CncWall4_F",[2.09375,35.5166,0.0161295],270],
["Land_GarbageWashingMachine_F",[-7.0332,35.707,-0.00171757],0],["Land_CncWall4_F",[-10.0679,35.4014,-0.0192642],90],
["B_Quadbike_01_F",[7.15234,36.3398,0.000344276],90.1019],["Land_CncWall1_F",[1.56592,38.3838,0.0173998],225],
["Land_CncWall4_F",[-1.45776,39.0059,0.00705242],180],["Land_CncWall4_F",[-8.06958,38.9658,0.0616016],180],
["Land_CncWall1_F",[-9.44458,38.4248,-0.00669861],135]];

_avanpostResistanceData = [["B_HMG_01_high_F",[-4.79614,1.76855,-0.112118],172.978],["Land_HBarrierWall4_F",[-3.95605,-7.1748,3.24249e-005],180],
["B_Quadbike_01_F",[7.72949,2.99023,-0.00972939],268.209],["Land_CncShelter_F",[-0.0236816,-8.7168,6.29425e-005],0],
["Land_HBarrier_Big_F",[5.53027,-7.54297,-1.19848],182.759],["Land_Cargo_HQ_V3_F",[-5.19678,6.45898,0],90],
["Land_Cargo_Patrol_V3_F",[9.48096,-5.31836,0],0],["B_Quadbike_01_F",[7.21875,7.45508,-0.0101089],267.943],
["Land_PowerGenerator_F",[8.92334,-5.5,0.000656128],0],["Land_HBarrierWall4_F",[7.96509,-7.49805,0.000240326],180],
["B_HMG_01_high_F",[2.85693,-11.1338,-0.163212],180.049],["Land_BagFence_Round_F",[1.94409,-11.9443,0.31889],45],
["Land_HBarrierWall6_F",[13.4104,-0.811523,0.0153065],89.9894],["Land_CratesWooden_F",[11.072,-5.65918,0.000501633],183.828],
["Land_BagFence_Round_F",[4.52319,-11.9902,0.327749],315],["Land_PaperBox_open_full_F",[-11.5957,-5.86719,-9.53674e-006],90.001],
["Land_HBarrierWall6_F",[-10.3628,-8.35449,-0.00183868],180],["Land_HBarrierWall6_F",[4.03564,13.958,-0.0102806],0],
["Land_HBarrierWall6_F",[13.1836,7.36914,0.00933456],89.9959],["Land_HBarrierWall_corner_F",[12.4697,-6.9082,0.00100708],90.055],
["Land_PaperBox_closed_F",[-16.55,-0.152344,0.194769],0],["Land_PaperBox_open_empty_F",[-16.5603,-2.64551,0.233974],165],
["Land_HBarrierWall_corner_F",[11.2793,12.751,0.000326157],0],["Land_HBarrier_1_F",[-17.0608,-4.1748,0.332443],270],
["Land_HBarrierWall6_F",[-19.48,-2.63184,0.157841],270.003],["Land_HBarrierWall4_F",[-14.1814,12.6465,3.8147e-006],0],
["Land_LampHalogen_F",[14.3088,-12.6094,-0.00100136],70.3531],["Land_HBarrierWall_corner_F",[-17.6853,-7.17969,1.33514e-005],180],
["Land_HBarrierWall6_F",[-19.7383,5.60938,-0.45487],270.002],["B_GMG_01_high_F",[-15.7522,13.7969,-0.111816],359.987],
["Land_Cargo_Tower_V3_F",[-19.3921,9.2334,-1.07354],180],["Land_HBarrierWall_corner_F",[-18.854,12.7217,3.05176e-005],269.999],
["Land_HBarrier_Big_F",[-22.2344,9.30273,0.0247555],270.006],["Land_LampHalogen_F",[-17.7344,16.8643,-0.00166321],277.827],
["Land_HBarrier_Big_F",[-22.2107,11.2891,-0.00229836],269.997],["Land_HBarrier_Big_F",[-24.2375,9.30273,0.170204],270.003],
["Land_HBarrier_Big_F",[-24.2603,11.2803,0.169233],269.999]];

_allObjs = [];
_objs1 = [_avanpostBluforPos, _avanpostBluforData] call QS_fnc_EGcreateAvanpost;
_allObjs = _allObjs + _objs1;

_objs2 = [_avanpostResistancePos, _avanpostResistanceData] call QS_fnc_EGcreateAvanpost;
_allObjs = _allObjs + _objs2;

// [] call QS_fnc_EGcreateTarget;
while {true} do {
  // code...
};