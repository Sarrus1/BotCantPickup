#include <sourcemod>
#include <sdkhooks>
#include <cstrike>

CSWeaponID[] allowedBotWeapons = {
    CSWeapon_P228,
    CSWeapon_USP,
	CSWeapon_USP_SILENCER,
	CSWeapon_KNIFE_T,
	CSWeapon_KNIFE,
	CSWeapon_TEC9,
	CSWeapon_HKP2000,
	CSWeapon_P250,
	CSWeapon_CZ75A,
	CSWeapon_REVOLVER,
	CSWeapon_GLOCK,
	CSWeapon_DEAGLE,
	CSWeapon_XM1014,
	CSWeapon_MAC10,
	CSWeapon_AUG,
	CSWeapon_ELITE,
	CSWeapon_FIVESEVEN,
	CSWeapon_UMP45,
	CSWeapon_SG550,
	CSWeapon_GALIL,
	CSWeapon_FAMAS,
	CSWeapon_USP,
	CSWeapon_AWP,
	CSWeapon_MP5NAVY,
	CSWeapon_M249,
	CSWeapon_M4A1,
	CSWeapon_AK47,
	CSWeapon_P90,
	CSWeapon_KEVLAR,
	CSWeapon_GALILAR,
	CSWeapon_BIZON,
	CSWeapon_MAG7,
	CSWeapon_NEGEV,
	CSWeapon_SAWEDOFF,
	CSWeapon_MP7,
	CSWeapon_MP9,
	CSWeapon_NOVA,
	CSWeapon_P250,
	CSWeapon_SCAR17,
	CSWeapon_SG556,
	CSWeapon_SSG08,
	CSWeapon_M4A1_SILENCER,
	CSWeapon_SHIELD
};


public Plugin myinfo =
{
	name = "Bot Cant Pickup guns",
	author = "Sarrus, helped by Addie (a lot)",
	description = "Prevents bots from picking up anything else than guns.",
	version = "1.0",
	url = "https://github.com/Sarrus1/BotCantPickup"
};

public void OnPluginStart()
{
    for (int i = MaxClients; i > 0; --i)
        if (IsClientInGame(i))
            OnClientPutInServer(i);
}

public void OnClientPutInServer(int client)
{
    if (IsFakeClient(client))
        SDKHook(client, SDKHook_WeaponCanUse, OnWeaponCanUse);
}

public Action OnWeaponCanUse(int client, int weapon) 
{
    CSWeaponID wepid = GetWeaponID(weapon);

    for (int i; i < sizeof(allowedBotWeapons); i++)
        if (allowedBotWeapons[i] == wepid)
            return Plugin_Continue;

    return Plugin_Handled;
}

CSWeaponID GetWeaponID(int weapon)
{
    int idx = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
    return CS_ItemDefIndexToID(idx);
}