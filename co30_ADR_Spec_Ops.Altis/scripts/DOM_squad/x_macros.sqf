// uncomment for debugging with __TRACE. see below
//#define __DEBUG__

#define __COMP d

#define FUNC(funcname) __COMP##_fnc_##funcname
#define GVAR(varname) __COMP##_##varname
#define QUOTE(qtext) #qtext
#define QGVAR(varname) QUOTE(GVAR(varname))
#define GV(obje,varname) (obje getVariable #varname)
#define GV2(obje,varname) (obje getVariable varname)

#define PARAMS_1(param1) param1 = _this select 0
#define PARAMS_2(param1,param2) PARAMS_1(param1); param2 = _this select 1
#define PARAMS_3(param1,param2,param3) PARAMS_2(param1,param2); param3 = _this select 2
#define PARAMS_4(param1,param2,param3,param4) PARAMS_3(param1,param2,param3); param4 = _this select 3
#define PARAMS_5(param1,param2,param3,param4,param5) PARAMS_4(param1,param2,param3,param4); param5 = _this select 4
#define PARAMS_6(param1,param2,param3,param4,param5,param6) PARAMS_5(param1,param2,param3,param4,param5); param6 = _this select 5
#define PARAMS_7(param1,param2,param3,param4,param5,param6,param7) PARAMS_6(param1,param2,param3,param4,param5,param6); param7 = _this select 6
#define PARAMS_8(param1,param2,param3,param4,param5,param6,param7,param8) PARAMS_7(param1,param2,param3,param4,param5,param6,param7); param8 = _this select 7

#define __isOpfor if (GVAR(own_side) == "OPFOR") then {
#define __isBlufor if (GVAR(own_side) == "BLUFOR") then {
#define __getMNsVar(mvarname) (missionNamespace getVariable #mvarname)
#define __getMNsVar2(mvarname) (missionNamespace getVariable mvarname)
#define __mNsSetVar missionNamespace setVariable
#define __pGetVar(pvarname) (player getVariable #pvarname)
#define __pSetVar player setVariable
#define __XJIPGetVar(jvarname) (X_JIPH getVariable #jvarname)
#define __uiGetVar(uvarname) (uiNamespace getVariable #uvarname)
#define __AIVer ("AI" in GVAR(version))
#define __ACEVer ("ACE" in GVAR(version))
#define __TTVer ("TT" in GVAR(version))
#define __A3Ver ("A3" in GVAR(version))
#define __RankedVer ("RANKED" in GVAR(version))
#define __WoundsVer ("WOUNDS" in GVAR(version))
#define __AddToExtraVec(ddvec) GVAR(x_sm_vec_rem_ar) set [count GVAR(x_sm_vec_rem_ar), ddvec];
#define __GetEGrp(grpnamexx) grpnamexx = [GVAR(side_enemy)] call FUNC(creategroup);
#define __TargetInfo _target_array2 = GVAR(target_names) select (X_JIPH getVariable QGVAR(current_target_index));_current_target_name = _target_array2 select 1;
#define __addDead(xunitx) GVAR(allunits_add) set [count GVAR(allunits_add), xunitx];
#define __Poss _poss = GVAR(x_sm_pos) select 0;
#define __PossAndOther _poss = GVAR(x_sm_pos) select 0;_pos_other = GVAR(x_sm_pos) select 1;
#define __ccppfln(xfile1) call compile preprocessFileLineNumbers #xfile1
#define __cppfln(xdfunc,xfile2) xdfunc = compile preprocessFileLineNumbers #xfile2
#define __INC(vari) vari = vari + 1
#define __DEC(vard) vard = vard - 1
#define __MPCheck if (X_MP) then { \
	if ((call FUNC(PlayersNumber)) == 0 && {!GVAR(all_simulation_stoped)}) then { \
		GVAR(all_simulation_stoped) = true; \
		{_x enableSimulation false} forEach allUnits; \
	}; \
	waitUntil {sleep (1.012 + random 1);(call FUNC(PlayersNumber)) > 0}; \
	if (GVAR(all_simulation_stoped)) then { \
		{_x enableSimulation true} forEach allUnits; \
		GVAR(all_simulation_stoped) = false; \
	}; \
};

#ifdef THIS_FILE
#define THIS_FILE_ 'THIS_FILE'
scriptName THIS_FILE;
#else
#define THIS_FILE_ __FILE__
#endif

#ifdef __DEBUG__
#define __TRACE(tmsg) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7'", time, diag_tickTime, diag_frameno, diag_fps, THIS_FILE_, __LINE__, tmsg];
#define __TRACE_1(tmsg,parame1) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7',%8: %9", time, diag_tickTime, diag_frameno, diag_fps, THIS_FILE_, __LINE__, tmsg, parame1, call compile format ["%1", parame1]];
#define __TRACE_2(tmsg,parame1,parame2) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7',%8: %9,%10: %11", time, diag_tickTime, diag_frameno, diag_fps, THIS_FILE_, __LINE__, tmsg, parame1, call compile format ["%1", parame1], parame2, call compile format ["%1", parame2]];
#define __TRACE_3(tmsg,parame1,parame2,parame3) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7',%8: %9,%10: %11,%12: %13", time, diag_tickTime, diag_frameno, diag_fps, THIS_FILE_, __LINE__, tmsg, parame1, call compile format ["%1", parame1], parame2, call compile format ["%1", parame2], parame3, call compile format ["%1", parame3]];
#else
#define __TRACE(tmsg)
#define __TRACE_1(tmsg,parame1)
#define __TRACE_2(tmsg,parame1,parame2)
#define __TRACE_3(tmsg,parame1,parame2,parame3)
#endif
