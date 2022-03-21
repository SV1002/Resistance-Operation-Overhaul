//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    UIMPUnitStats.uc
//  AUTHOR:  sbatista - 10/21/15
//  PURPOSE: A popup with unit's statistics and abilities that is shown during MP Squad Selection
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class UITLEUnitStats_Override extends UITLEUnitStats;

simulated function PopulateSoldierGear( XComGameState_Unit Unit, optional XComGameState NewCheckGameState)
{
	local XComGameState_Item equippedItem;
	local array<XComGameState_Item> utilItems;
	local array<string> weaponImages;
	local int i;

	mc.BeginFunctionOp("SetSoldierGear");

	equippedItem = Unit.GetItemInSlot(eInvSlot_Armor, NewCheckGameState, true);
	mc.QueueString(class'UITLE_SkirmishModeMenu'.default.m_strArmorLabel);//armor
	mc.QueueString(equippedItem.GetMyTemplate().strImage);
	mc.QueueString(equippedItem.GetMyTemplate().GetItemFriendlyNameNoStats());

	equippedItem = Unit.GetItemInSlot(eInvSlot_PrimaryWeapon, NewCheckGameState, true);
	mc.QueueString(class'UITLE_SkirmishModeMenu'.default.m_strPrimaryLabel);//primary
	mc.QueueString(equippedItem.GetMyTemplate().GetItemFriendlyNameNoStats());

	mc.QueueString(class'UITLE_SkirmishModeMenu'.default.m_strSecondaryLabel);//secondary

	equippedItem = Unit.GetItemInSlot(eInvSlot_SecondaryWeapon, NewCheckGameState, true);
	mc.QueueString(equippedItem.GetMyTemplate().strImage);
	mc.QueueString(equippedItem.GetMyTemplate().GetItemFriendlyNameNoStats());

	utilItems = Unit.GetAllItemsInSlot(eInvSlot_Utility, NewCheckGameState, , true);
	mc.QueueString(class'UITLE_SkirmishModeMenu'.default.m_strUtilLabel);//util 1
	mc.QueueString(utilItems[0].GetMyTemplate().strImage);
	mc.QueueString(utilItems[0].GetMyTemplate().GetItemFriendlyNameNoStats());
	mc.QueueString(utilItems[1].GetMyTemplate().strImage);// util 2 and 3
	mc.QueueString(utilItems[1].GetMyTemplate().GetItemFriendlyNameNoStats());

	equippedItem = Unit.GetItemInSlot(eInvSlot_GrenadePocket, NewCheckGameState, true);
	mc.QueueString(equippedItem.GetMyTemplate().strImage);
	mc.QueueString(equippedItem.GetMyTemplate().GetItemFriendlyNameNoStats());

	mc.EndOp();

	mc.BeginFunctionOp("SetSoldierPCS");
	equippedItem = Unit.GetItemInSlot(eInvSlot_CombatSim, NewCheckGameState, true);
	if (equippedItem != none)
	{
		mc.QueueString(equippedItem.GetMyTemplate().GetItemFriendlyName(equippedItem.ObjectID));
		mc.QueueString(class'UIUtilities_Image'.static.GetPCSImage(equippedItem));
		mc.QueueString(class'UIUtilities_Colors'.const.NORMAL_HTML_COLOR);
	}
	else
	{
		mc.QueueString("");
		mc.QueueString("");
		mc.QueueString(class'UIUtilities_Colors'.const.DISABLED_HTML_COLOR);
	}
	
	mc.EndOp();

	mc.BeginFunctionOp("SetPrimaryWeapon");
	equippedItem = Unit.GetItemInSlot(eInvSlot_PrimaryWeapon, NewCheckGameState, true);
	weaponImages = equippedItem.GetWeaponPanelImages();

	for (i = 0; i < weaponImages.Length; i++)
	{
		mc.QueueString(weaponImages[i]);
	}

	mc.EndOp();
}