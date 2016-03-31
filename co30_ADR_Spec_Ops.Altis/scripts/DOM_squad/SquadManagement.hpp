// by Xeno
#include "x_setup.sqf"
#include "define.hpp"

class XD_SquadManagementDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['X_SQUADMANAGEMENT_DIALOG', _this select 0];d_squadmanagement_dialog_open = true;call d_fnc_squadmanagementfill";
	onUnLoad = "uiNamespace setVariable ['X_SQUADMANAGEMENT_DIALOG', nil];d_SQMGMT_grps = nil;d_squadmanagement_dialog_open = false";
	class controlsBackground {
		class XD_BackGround : RscBG {
			x = "SafeZoneXAbs";
			y = "SafeZoneY";
			w = "safeZoneWAbs";
			h = "SafeZoneH";
			colorBackground[] = {0.149, 0.196, 0.219, 0.9};
		};
	};
	class controls {
		class XD_MainCaption : XC_RscText {
			x = "SafeZoneX";
			y = "SafeZoneY + 0.01";
			w = "SafeZoneW";
			h = 0.13;
			sizeEx = 0.1;
			style = ST_CENTER;
			shadow = 0;
			colorBackground[] = {1, 1, 1, 0};
			XCMainCapt;
			text = "$STRD_manage";
		};
		class Dom2 : XD_MainCaption {
			x = "SafeZoneX + 0.05";
			y = "SafeZoneY + SafeZoneH - 0.1";
			XCMainCapt;
			text = "";
		};
		class GroupsControlsGroup : XD_RscControlsGroup {	
		    x = "SafeZoneX + 0.02";
			y = "SafeZoneY + 0.15";
			w = "SafeZoneW - 0.05";
			h = "SafeZoneH - 0.25";		
			__EXEC(bgidc = 1000)
			__EXEC(lbidc = 2000)
			__EXEC(buidc = 3000)
			__EXEC(txtidc = 4000)
			__EXEC(butnum = 5000)
			__EXEC(lockpicidc = 6000)
			__EXEC(lockbutidc = 7000)
			__EXEC(lockbutnum = 7000)
			__EXEC(kickbutidc = 8000)
			__EXEC(kickbutnum = 8000)
			__EXEC(invitebutidc = 9000)
			__EXEC(invitebutnum = 9000)	
			__EXEC(rankbutidc = 10000)
			__EXEC(rankbutnum = 10000)			
			class VScrollbar: ScrollBar {
				color[] = {1,1,1,1};
	        	width = 0.028;
	        	shadow = 0;	  	
	        };
	        class HScrollbar: ScrollBar {
	        	color[] = {1,1,1,1};
	        	height = 0.028;
	        	shadow = 0;
	        };
			class Controls {
				class BackGround0 : SXRscText {
					idc = __EVAL(bgidc);
					__EXEC(xposbg = 0.005)
					x = __EVAL(xposbg);
					__EXEC(yposbg = 0.005)
					y = __EVAL(yposbg);
					w = 0.4;
					h = 0.39;
					colorBackground[] = {0,0,0,0.3};
					text = "";
				};
				class GroupListBox0 : SXRscListBox {
					idc = __EVAL(lbidc);
					__EXEC(xposlb = 0.025)
					x = __EVAL(xposlb);
					__EXEC(yposlb = 0.06)
					y = __EVAL(yposlb);
					w = 0.35;
					h = 0.265;
					rowHeight = 0.03;
					shadow = 0;
					__EXEC(_numlbstr = str lbidc)
					onLBSelChanged = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlbchanged");					
					onKillFocus = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlblostfocus");
				};
				class LeaveJoinButton0 : XD_LinkButtonBase {
					idc = __EVAL(buidc);
					__EXEC(xposbu = 0.251)
					x = __EVAL(xposbu);
					__EXEC(yposbu = 0.315)
					y = __EVAL(yposbu);
					text = "$STRD_Join";
					__EXEC(_numbstr = str butnum)
					action = __EVAL(_numbstr + " call d_fnc_squadmgmtbuttonclicked");
				};
				class GroupText0 : SXRscText {
					idc = __EVAL(txtidc);
					__EXEC(xpostxt = 0.025)
					x = __EVAL(xpostxt);
					__EXEC(ypostxt = 0.017)
					y = __EVAL(ypostxt);
					w = 0.3;
					h = 0.03;
					sizeEx = 0.03;
					shadow = 0;
					text = "$STRD_namegroup";
				};
				class LockPic0: XD_RscPicture {
					idc = __EVAL(lockpicidc);
					__EXEC(xposlockpic = 0.020)
					x = __EVAL(xposlockpic);
					__EXEC(yposlockpic = 0.345)
					y = __EVAL(yposlockpic);
					w = 0.03;
					h = 0.04;
					text = "\A3\ui_f\data\gui\Rsc\RscDisplaySingleMission\mission_notowned_ca.paa";
				};
				class LockButton0 : XD_LinkButtonBase {
					idc = __EVAL(lockbutidc);
					style = ST_LEFT;
					__EXEC(xposlockbu = 0.05)
					x = __EVAL(xposlockbu);
					__EXEC(yposlockbu = 0.315)
					y = __EVAL(yposlockbu);
					text = "$STRD_locked";
					__EXEC(_locknumbstr = str lockbutnum)
					action = __EVAL(_locknumbstr + " call d_fnc_squadmgmtlockbuttonclicked");
				};		
				class KickButton0 : XD_LinkButtonBase {
					idc = __EVAL(kickbutidc);
					__EXEC(xposkickbu = 0.13)
					x = __EVAL(xposkickbu);
					__EXEC(yposkickbu = 0.315)
					y = __EVAL(yposkickbu);
					text = "$STRD_Remove";
					colorText[] = {1, 0, 0, 1};
					__EXEC(_kicknumbstr = str kickbutnum)
					action = __EVAL(_kicknumbstr + " call d_fnc_squadmgmtkickbuttonclicked");
				};
				class InviteButton0 : XD_LinkButtonBase {
					idc = __EVAL(invitebutidc);
					__EXEC(xposinvitebu = 0.13)
					x = __EVAL(xposinvitebu);
					__EXEC(yposinvitebu = 0.315)
					y = __EVAL(yposinvitebu);
					text = "$STRD_Invite";
					__EXEC(_invitenumbstr = str invitebutnum)
					action = __EVAL(_invitenumbstr + " call d_fnc_squadmgmtinvitebuttonclicked");
				};		
				class RankButton0 : XD_LinkButtonBase {
					idc = __EVAL(rankbutidc);
					__EXEC(xposrankbu = 0.13)
					x = __EVAL(xposrankbu);
					__EXEC(yposrankbu = 0.315)
					y = __EVAL(yposrankbu);
					text = "$STRD_Invite";
					__EXEC(_ranknumbstr = str rankbutnum)
					action = __EVAL(_ranknumbstr + " call d_fnc_squadmgmtrankbuttonclicked");
				};											
				#define NewControl(tname,xplus,yplus) \
				class BackGround##tname : BackGround0 { \
					__EXEC(bgidc = bgidc + 1) \
					idc = __EVAL(bgidc); \
					__EXEC(xposbg = xposbg + xplus) \
					x = __EVAL(xposbg); \
					__EXEC(yposbg = yposbg + yplus) \
					y = __EVAL(yposbg); \
				}; \
				class GroupListBox##tname : GroupListBox0 { \
					__EXEC(lbidc = lbidc + 1) \
					idc = __EVAL(lbidc); \
					__EXEC(xposlb = xposlb + xplus) \
					x = __EVAL(xposlb); \
					__EXEC(yposlb = yposlb + yplus) \
					y = __EVAL(yposlb); \
					__EXEC(_numlbstr = str lbidc) \
					onLBSelChanged = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlbchanged"); \
					onKillFocus = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlblostfocus"); \
				}; \
				class LeaveJoinButton##tname : LeaveJoinButton0 { \
					__EXEC(buidc = buidc + 1) \
					idc = __EVAL(buidc); \
					__EXEC(xposbu = xposbu + xplus) \
					x = __EVAL(xposbu); \
					__EXEC(yposbu = yposbu + yplus) \
					y = __EVAL(yposbu); \
					__EXEC(butnum = butnum + 1) \
					__EXEC(_numbstr = str butnum) \
					action = __EVAL(_numbstr + " call d_fnc_squadmgmtbuttonclicked"); \
				}; \
				class GroupText##tname : GroupText0 { \
					__EXEC(txtidc = txtidc + 1) \
					idc = __EVAL(txtidc); \
					__EXEC(xpostxt = xpostxt + xplus) \
					x = __EVAL(xpostxt); \
					__EXEC(ypostxt = ypostxt + yplus) \
					y = __EVAL(ypostxt); \
				}; \
				class LockPic##tname: LockPic0 { \
					__EXEC(lockpicidc = lockpicidc + 1) \
					idc = __EVAL(lockpicidc); \
					__EXEC(xposlockpic = xposlockpic + xplus) \
					x = __EVAL(xposlockpic); \
					__EXEC(yposlockpic = yposlockpic + yplus) \
					y = __EVAL(yposlockpic); \
				}; \
				class LockButton##tname : LockButton0 { \
					__EXEC(lockbutidc = lockbutidc + 1) \
					idc = __EVAL(lockbutidc); \
					__EXEC(xposlockbu = xposlockbu + xplus) \
					x = __EVAL(xposlockbu); \
					__EXEC(yposlockbu = yposlockbu + yplus) \
					y = __EVAL(yposlockbu); \
					__EXEC(lockbutnum = lockbutnum + 1) \
					__EXEC(_locknumbstr = str lockbutnum) \
					action = __EVAL(_locknumbstr + " call d_fnc_squadmgmtlockbuttonclicked"); \
				}; \
				class KickButton##tname : KickButton0 { \
					__EXEC(kickbutidc = kickbutidc + 1) \
					idc = __EVAL(kickbutidc); \
					__EXEC(xposkickbu = xposkickbu + xplus) \
					x = __EVAL(xposkickbu); \
					__EXEC(yposkickbu = yposkickbu + yplus) \
					y = __EVAL(yposkickbu); \
					__EXEC(kickbutnum = kickbutnum + 1) \
					__EXEC(_kicknumbstr = str kickbutnum) \
					action = __EVAL(_kicknumbstr + " call d_fnc_squadmgmtkickbuttonclicked"); \
				}; \
				class InviteButton##tname : InviteButton0 { \
					__EXEC(invitebutidc = invitebutidc + 1) \
					idc = __EVAL(invitebutidc); \
					__EXEC(xposinvitebu = xposinvitebu + xplus) \
					x = __EVAL(xposinvitebu); \
					__EXEC(yposinvitebu = yposinvitebu + yplus) \
					y = __EVAL(yposinvitebu); \
					__EXEC(invitebutnum = invitebutnum + 1) \
					__EXEC(_invitenumbstr = str invitebutnum) \
					action = __EVAL(_invitenumbstr + " call d_fnc_squadmgmtinvitebuttonclicked"); \
				}; \
				class RankButton##tname : InviteButton0 { \
					__EXEC(rankbutidc = rankbutidc + 1) \
					idc = __EVAL(rankbutidc); \
					__EXEC(xposrankbu = xposrankbu + xplus) \
					x = __EVAL(xposrankbu); \
					__EXEC(yposrankbu = yposrankbu + yplus) \
					y = __EVAL(yposrankbu); \
					__EXEC(rankbutnum = rankbutnum + 1) \
					__EXEC(_ranknumbstr = str rankbutnum) \
					action = __EVAL(_ranknumbstr + " call d_fnc_squadmgmtrankbuttonclicked"); \
				};	
				
				NewControl(1,0.47,0);
				NewControl(2,0.47,0);
				NewControl(3,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				__EXEC(xposkickbu = 0.13)
				__EXEC(xposinvitebu = 0.13)
				__EXEC(xposrankbu = 0.13)
				NewControl(4,0,0.45);
				NewControl(5,0.47,0);
				NewControl(6,0.47,0);
				NewControl(7,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				__EXEC(xposkickbu = 0.13)
				__EXEC(xposinvitebu = 0.13)
				__EXEC(xposrankbu = 0.13)
				NewControl(8,0,0.45);
				NewControl(9,0.47,0);
				NewControl(10,0.47,0);
				NewControl(11,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				__EXEC(xposkickbu = 0.13)
				__EXEC(xposinvitebu = 0.13)
				__EXEC(xposrankbu = 0.13)
				NewControl(12,0,0.45);
				NewControl(13,0.47,0);
				NewControl(14,0.47,0);
				NewControl(15,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				__EXEC(xposkickbu = 0.13)
				__EXEC(xposinvitebu = 0.13)
				__EXEC(xposrankbu = 0.13)
				NewControl(16,0,0.45);
				NewControl(17,0.47,0);
				NewControl(18,0.47,0);
				NewControl(19,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				__EXEC(xposkickbu = 0.13)
				__EXEC(xposinvitebu = 0.13)
				__EXEC(xposrankbu = 0.13)
				NewControl(20,0,0.45);
				NewControl(21,0.47,0);
				NewControl(22,0.47,0);
				NewControl(23,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				__EXEC(xposkickbu = 0.13)
				__EXEC(xposinvitebu = 0.13)
				__EXEC(xposrankbu = 0.13)
				NewControl(24,0,0.45);
				NewControl(25,0.47,0);
				NewControl(26,0.47,0);
				NewControl(27,0.47,0);
			};
		};
		class XD_CloseButton: XD_ButtonBase {
			idc = 9999;
			text = "$STRD_Quit"; 
			action = "closeDialog 0";
			default = true;
			x = "SafeZoneX + SafeZoneW - 0.3";
			y = "SafeZoneY + SafeZoneH - 0.07";
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class XD_HintText : SXRscText {
			idc = 11000;
			x = "SafeZoneX";
			y = "SafeZoneY + SafeZoneH - 0.07";
			w = "SafeZoneW";
			h = 0.04;
			sizeEx = 0.03;
			style = ST_CENTER;
			shadow = 0;
			XCMainCapt;
			text = "$STRD_Hint";
		};		
	};
};
