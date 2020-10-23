/*==============================================================================


	Southclaws' Scavenge and Survive

		Copyright (C) 2016 "Southclaws" Keene

		This program is free software: you can redistribute it and/or modify it
		under the terms of the GNU General Public License as published by the
		Free Software Foundation, either version 3 of the License, or (at your
		option) any later version.

		This program is distributed in the hope that it will be useful, but
		WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along
		with this program.  If not, see <http://www.gnu.org/licenses/>.


==============================================================================*/


CMD:welcome(playerid, params[])
{
	ShowWelcomeMessage(playerid, 0);
	return 1;
}

CMD:help(playerid, params[])
{
	Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "General Information", ls(playerid, "GENCOMDHELP"), "Close", "");

	return 1;
}

CMD:rules(playerid, params[])
{
	ChatMsg(playerid, YELLOW, " >  Rules List (total: %d)", gTotalRules);

	for(new i; i < gTotalRules; i++)
		ChatMsg(playerid, BLUE, sprintf(" >  "C_ORANGE"%s", gRuleList[i]));
	
	return 1;
}

CMD:admins(playerid, params[])
{
	ChatMsg(playerid, YELLOW, " >  Staff List (total: %d)", gTotalStaff);

	for(new i; i < gTotalStaff; i++)
		ChatMsg(playerid, BLUE, sprintf(" >  "C_ORANGE"%s", gStaffList[i]));
	
	return 1;
}

CMD:credits(playerid, params[])
{
	ChatMsg(playerid, YELLOW, " >  Scavenge and Survive is developed by Southclaws (www.southcla.ws) and the following contributors:");
	ChatMsg(playerid, BLUE, " >  Y_Less - Tons of useful code, libraries and conversations");
	ChatMsg(playerid, BLUE, " >  Viruxe - Lots of anti-cheat work");
	ChatMsg(playerid, BLUE, " >  Kadaradam - Fishing, Trees and lots of bug fixes");
	ChatMsg(playerid, BLUE, " >  Eidorian - French translation");
	ChatMsg(playerid, BLUE, " >  Hiddos - Better water detection code");
	ChatMsg(playerid, BLUE, " >  YOLO - Bosnian/Croatian/Serbian Translation");
	ChatMsg(playerid, BLUE, " >  JJ - Czech Translation");
	ChatMsg(playerid, BLUE, " >  KingSergio - Russian Translation");
	ChatMsg(playerid, BLUE, " >  Blacky - Romanian Translation");
	ChatMsg(playerid, BLUE, " >  Reza - Indonesian Translation");
	ChatMsg(playerid, BLUE, " >  PrettyDiamond - Spanish Translation");

	return 1;
}

CMD:motd(playerid, params[])
{
	ChatMsg(playerid, YELLOW, " >  MoTD: "C_BLUE"%s", gMessageOfTheDay);
	return 1;
}

CMD:chatinfo(playerid, params[])
{
	Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "Information about "C_BLUE"Chat", ls(playerid, "GENCOMDCHAT"), "Close", "");

	return 1;
}

CMD:restartinfo(playerid, params[])
{
	gBigString[playerid][0] = EOS;

	strcat(gBigString[playerid], sprintf(ls(playerid, "GENCOMDRES1"), floatround(gServerMaxUptime / 3600)));
	strcat(gBigString[playerid], ls(playerid, "GENCOMDRES2"));

	Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "Information about "C_BLUE"Server Restarts", gBigString[playerid], "Close", "");

	return 1;
}

CMD:tooltips(playerid, params[])
{
	if(IsPlayerToolTipsOn(playerid))
	{
		ChatMsgLang(playerid, YELLOW, "TOOLTIPSOFF");
		SetPlayerToolTips(playerid, false);
	}
	else
	{
		ChatMsgLang(playerid, YELLOW, "TOOLTIPSON");
		SetPlayerToolTips(playerid, true);
	}

	return 1;
}

CMD:dropall(playerid, params[])
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:r;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, r);

	ApplyAnimation(playerid, "ROB_BANK", "SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 0);
	DropItems(playerid, x, y, z, r, false);

	return 1;
}

/*CMD:die(playerid, params[])
{
	if(GetTickCountDifference(GetTickCount(), GetPlayerSpawnTick(playerid)) < 60000)
		return 2;

	SetPlayerWeapon(playerid, 4, 1);
	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 1.0, 0, 0, 0, 0, 0);
	defer Suicide(playerid);

	return 1;
}
timer Suicide[3000](playerid)
{
	RemovePlayerWeapon(playerid);
	SetPlayerHP(playerid, -100.0);
}
*/
CMD:changepass(playerid,params[])
{
	new
		oldpass[32],
		newpass[32],
		buffer[MAX_PASSWORD_LEN];

	if(!IsPlayerLoggedIn(playerid))
	{
		ChatMsgLang(playerid, YELLOW, "LOGGEDINREQ");
		return 1;
	}

	if(sscanf(params, "s[32]s[32]", oldpass, newpass))
	{
		ChatMsgLang(playerid, YELLOW, "CHANGEPASSW");
		return 1;
	}
	else
	{
		new storedhash[MAX_PASSWORD_LEN];

		GetPlayerPassHash(playerid, storedhash);
		WP_Hash(buffer, MAX_PASSWORD_LEN, oldpass);
		
		if(!strcmp(buffer, storedhash))
		{
			new name[MAX_PLAYER_NAME];

			GetPlayerName(playerid, name, MAX_PLAYER_NAME);

			WP_Hash(buffer, MAX_PASSWORD_LEN, newpass);
			
			if(SetAccountPassword(name, buffer))
			{
				SetPlayerPassHash(playerid, buffer);
				ChatMsgLang(playerid, YELLOW, "PASSCHANGED", newpass);
			}
			else
			{
				ChatMsgLang(playerid, RED, "PASSCHERROR");
			}
		}
		else
		{
			ChatMsgLang(playerid, RED, "PASSCHNOMAT");
		}
	}
	return 1;
}

CMD:pos(playerid, params[])
{
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	ChatMsg(playerid, YELLOW, " >  Position: "C_BLUE"%.2f, %.2f, %.2f", x, y, z);

	return 1;
}

