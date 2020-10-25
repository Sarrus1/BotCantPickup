#include <sourcemod>
#include <sdkhooks>

public void OnPluginStart() {
	for (int i = 0; i <= MaxClients; i++) {
		TryWeaponHook(i);
	}
}

public void OnClientPostAdminCheck(int iClient) {
	TryWeaponHook(iClient);
}

void TryWeaponHook(int iIndex) {
	if (IsFakeClient(iIndex)) 
	{
		SDKHook(iIndex, SDKHook_WeaponCanUse, Hook_WeaponCanUse);
	}
}

public Action Hook_WeaponCanUse(int iClient, int iWeapon) 
{
	if (IsFakeClient(iClient)) 
	{
		return Plugin_Handled;
	}
	return Plugin_Continue;
}