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

};


public Plugin myinfo =
{
	name = "Bot Cant Pickup guns",
	author = "Sarrus, helped by Addie (a lot)",
	description = "Prevents bots from picking up anything else than pistols.",
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