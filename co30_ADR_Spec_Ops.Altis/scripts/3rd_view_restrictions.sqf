if (hasInterface) then {
	_uavs = ["B_UAV_01_F","B_UAV_02_F","B_UAV_05_F","B_UAV_02_CAS_F","B_UGV_01_F","B_UGV_01_rcws_F","I_UAV_01_F","I_UAV_02_F","I_UAV_02_CAS_F","I_UGV_01_F","I_UGV_01_rcws_F",
	"O_UAV_01_F","O_UAV_02_F","O_UAV_02_CAS_F","O_UGV_01_F","O_UGV_01_rcws_F","B_T_UAV_03_F","O_T_UAV_04_CAS_F","B_UAV_02_dynamicLoadout_F"];
	while {true} do {
		waitUntil {cameraView == "EXTERNAL" || cameraView == "GROUP"};
		if (cameraView == "GROUP") then {
            player switchCamera "INTERNAL";
		} else {
            if (vehicle player == player && !((typeOf cameraOn) in _uavs)) then {
			    player switchCamera "INTERNAL";
		    };
	    };
	};
};
