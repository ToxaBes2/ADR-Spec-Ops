/*
Authors: Liveandletdie, 1911
Description: Add Bridge Structures. Adapted for Tanoa - ToxaBes.
*/
_pos1 = [4665, 11680];
_pos2 = [3413, 8807];
_pos3 = [7977.14, 4123.55];

_marker_b1 = createMarker ["marker_bridge1", _pos1];
_marker_b1 setMarkerShape "RECTANGLE";
_marker_b1 setMarkerBrush "SolidFull";
_marker_b1 setMarkerDir 180;
_marker_b1 setMarkerSize [470,3];
_marker_b1 setMarkerColor "ColorWhite";
_marker_b1 setMarkerAlpha 1;

_marker_b2 = createMarker ["marker_bridge2", _pos2];
_marker_b2 setMarkerShape "RECTANGLE";
_marker_b2 setMarkerBrush "SolidFull";
_marker_b2 setMarkerDir 170;
_marker_b2 setMarkerSize [1140,3];
_marker_b2 setMarkerColor "ColorWhite";
_marker_b2 setMarkerAlpha 1;

_marker_b3 = createMarker ["marker_bridge3", _pos3];
_marker_b3 setMarkerShape "RECTANGLE";
_marker_b3 setMarkerBrush "SolidFull";
_marker_b3 setMarkerDir 8.65; 
_marker_b3 setMarkerSize [810,3]; 
_marker_b3 setMarkerColor "ColorWhite";
_marker_b3 setMarkerAlpha 1;

_bridge1 = [
    ["Land_AirstripPlatform_01_F",[4206.2,11680,-0.95],180,0,13], 
    ["Land_AirstripPlatform_01_F",[4223.3,11680,1],180], 
    ["Land_AirstripPlatform_01_F",[4243.4,11680,1],180], 
    ["Land_AirstripPlatform_01_F",[4263.5,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4283.6,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4303.7,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4323.8,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4343.9,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4364,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4384,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4404,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4424,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4444,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4464,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4484,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4504,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4524,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4544,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4564,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4584,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4604,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4604,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4624,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4644,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4664,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4684,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4704,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4724,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4744,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4764,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4784,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4804,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4824,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4844,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4864,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4884,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4904,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4924,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4944,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4964,11680,1],180],
    ["Land_AirstripPlatform_01_F",[4984,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5004,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5024,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5044,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5064,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5084,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5104,11680,1],180],
    ["Land_AirstripPlatform_01_F",[5123.5,11680,0.66],180,0,-2]
];

_bridge2 = [            
    ["Land_AirstripPlatform_01_F",[2313,8611,-1.2],170,0,13],              
    ["Land_AirstripPlatform_01_F",[2329.85,8614,0.74],170],            
    ["Land_AirstripPlatform_01_F",[2349.7,8617.5,0.74],170],            
    ["Land_AirstripPlatform_01_F",[2369.5,8621,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2389.3,8624.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2409.1,8628,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2428.9,8631.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2448.7,8635,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2468.5,8638.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2488.3,8642,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2508.1,8645.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2527.9,8649,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2547.7,8652.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2567.5,8656,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2587.3,8659.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2607.1,8663,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2626.9,8666.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2646.7,8670,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2666.5,8673.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2686.3,8677,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2706.1,8680.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2725.9,8684,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2745.7,8687.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2765.5,8691,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2785.3,8694.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2805.1,8698,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2824.9,8701.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2844.7,8705,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2864.5,8708.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2884.3,8712,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2904.1,8715.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2923.9,8719,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2943.7,8722.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2963.5,8726,0.74],170],           
    ["Land_AirstripPlatform_01_F",[2983.3,8729.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3003.1,8733,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3022.9,8736.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3042.7,8740,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3062.5,8743.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3082.3,8747,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3102.1,8750.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3121.9,8754,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3141.7,8757.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3161.5,8761,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3181.3,8764.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3201.1,8768,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3220.9,8771.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3240.7,8775,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3260.5,8778.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3280.3,8782,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3300.1,8785.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3319.9,8789,0.74],170],         
    ["Land_AirstripPlatform_01_F",[3328.1,8790.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3347.9,8794,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3367.7,8797.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3387.5,8801,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3407.3,8804.5,0.74],170],          
    ["Land_AirstripPlatform_01_F",[3427.1,8808,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3446.9,8811.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3466.7,8815,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3486.5,8818.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3506.3,8822,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3526.1,8825.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3545.9,8829,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3565.7,8832.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3585.5,8836,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3605.3,8839.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3625.1,8843,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3644.9,8846.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3664.7,8850,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3684.5,8853.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3704.3,8857,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3724.1,8860.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3743.9,8864,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3763.7,8867.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3783.5,8871,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3803.3,8874.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3823.1,8878,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3842.9,8881.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3862.7,8885,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3882.5,8888.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3902.3,8892,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3922.1,8895.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3941.9,8899,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3961.7,8902.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[3981.5,8906,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4001.3,8909.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4021.1,8913,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4040.9,8916.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4060.7,8920,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4080.5,8923.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4100.3,8927,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4120.1,8930.5,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4139.9,8934,0.74],170],           
    ["Land_AirstripPlatform_01_F",[4159.7,8937.5,0.74],170],        
    ["Land_AirstripPlatform_01_F",[4179.5,8941,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4199.3,8944.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4219.1,8948,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4238.9,8951.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4258.7,8955,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4278.5,8958.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4298.3,8962,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4318.1,8965.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4337.9,8969,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4357.7,8972.5,0.74],170],    
    ["Land_AirstripPlatform_01_F",[4377.5,8976,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4397.3,8979.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4417.1,8983,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4436.9,8986.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4456.7,8990,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4476.5,8993.5,0.74],170],   
    ["Land_AirstripPlatform_01_F",[4496.3,8997,0.74],170],  
    ["Land_AirstripPlatform_01_F",[4516.1,9000.5,0.74],170], 
    ["Land_AirstripPlatform_01_F",[4534.8,9003.8,-0.1],170, 0, -5] 
];            

_bridge3 = [
    ["Land_AirstripPlatform_01_F",[7180.2,4244.6,-0.95],8.64605,0,-13],  
    ["Land_AirstripPlatform_01_F",[8787.4,4000.47,1],8.64605], 
    ["Land_AirstripPlatform_01_F",[8770.29,4002.82,1],8.64607], 
    ["Land_AirstripPlatform_01_F",[8750.38,4005.84,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8730.46,4008.87,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8710.55,4011.9,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8690.63,4014.93,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8670.72,4017.96,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8650.81,4020.99,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8630.89,4024.01,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8610.98,4027.04,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8591.06,4030.07,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8571.15,4033.1,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8551.24,4036.13,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8531.32,4039.15,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8511.41,4042.18,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8491.49,4045.21,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8471.58,4048.24,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8451.67,4051.27,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8431.75,4054.29,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8411.84,4057.32,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8391.92,4060.35,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8372.01,4063.38,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8352.09,4066.41,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8332.18,4069.43,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8312.27,4072.46,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8292.35,4075.49,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8272.44,4078.52,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8252.52,4081.55,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8232.61,4084.57,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8212.7,4087.6,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8192.78,4090.63,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8172.87,4093.66,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8152.96,4096.69,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8133.04,4099.71,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8113.13,4102.74,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8093.21,4105.77,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8073.3,4108.8,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8053.39,4111.83,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8033.47,4114.85,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[8013.56,4117.88,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7993.65,4120.91,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7973.73,4123.94,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7953.82,4126.97,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7933.91,4129.99,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7913.99,4133.02,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7894.08,4136.05,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7874.17,4139.08,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7854.25,4142.1,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7834.34,4145.13,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7814.42,4148.16,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7794.51,4151.19,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7774.6,4154.22,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7754.68,4157.24,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7734.77,4160.27,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7714.86,4163.3,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7694.94,4166.33,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7675.03,4169.35,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7655.12,4172.38,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7635.2,4175.41,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7615.29,4178.44,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7595.38,4181.47,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7575.46,4184.49,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7555.55,4187.52,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7535.63,4190.55,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7515.72,4193.58,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7495.81,4196.61,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7475.89,4199.63,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7455.98,4202.66,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7436.07,4205.69,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7416.15,4208.72,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7396.24,4211.74,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7376.33,4214.77,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7356.41,4217.8,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7336.5,4220.83,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7316.58,4223.86,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7296.67,4226.88,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7276.76,4229.91,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7256.84,4232.94,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7236.93,4235.97,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7217.02,4239,1],8.64606], 
    ["Land_AirstripPlatform_01_F",[7197.1,4242.02,1],8.64606]
];

_bridgeAdditions = [
	["Land_CrashBarrier_01_8m_F",[-6.1,-5.75,12.85],180],
	["Land_CrashBarrier_01_8m_F",[0,-5.75,12.85],180],
	["Land_CrashBarrier_01_8m_F",[6.1,-5.75,12.85],180],
	["Land_CrashBarrier_01_8m_F",[-6.1,5.75,12.85],0],
	["Land_CrashBarrier_01_8m_F",[0,5.75,12.85],0],
	["Land_CrashBarrier_01_8m_F",[6.1,5.75,12.85],0],
	["Land_LampHarbour_F",[0,-5.55,15.4],0],
	["Land_LampHarbour_F",[0,5.55,15.4],180]
];

BuildBridge = {
	{
		_object = createVehicle [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
		_object setDir (_x select 2);
		_object setPosASL (_x select 1);
		if ((count _x) > 3) then {[_object, _x select 3, _x select 4] call BIS_fnc_setPitchBank};
		_object enableSimulationGlobal false;
	} forEach _this;
};

BuildBridgeAdditions = {
    _objects = _this select 0;
    _pos = _this select 1;
    _dist = _this select 2;
	_bridgeSections = _pos nearObjects ["Land_AirstripPlatform_01_F", _dist];
	{
		_bridgeSection = _x;
		{
			_bridgeAddition = createVehicle [_x select 0, getPos _bridgeSection, [], 0, "CAN_COLLIDE"];
			_bridgeAddition attachTo [_bridgeSection,_x select 1];
			detach _bridgeAddition;
			_bridgeAddition setDir (getDir _bridgeSection + (_x select 2));
			_bridgeAddition allowDamage false;
		} forEach _objects;
	} forEach _bridgeSections;
};

(_bridge1) call BuildBridge;
[_bridgeAdditions, _pos1, 450] call BuildBridgeAdditions;
(_bridge2) call BuildBridge;
[_bridgeAdditions, _pos2, 1110] call BuildBridgeAdditions;
(_bridge3) call BuildBridge;
[_bridgeAdditions, _pos3, 800] call BuildBridgeAdditions;