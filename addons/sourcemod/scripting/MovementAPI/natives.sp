/*	
	Natives

	Movement API native implementation.
*/

void CreateNatives()
{
	CreateNative("Movement_GetOrigin", Native_GetOrigin);
	CreateNative("Movement_SetOrigin", Native_SetOrigin);
	CreateNative("Movement_GetGroundOrigin", Native_GetGroundOrigin);
	CreateNative("Movement_GetVelocity", Native_GetVelocity);
	CreateNative("Movement_SetVelocity", Native_SetVelocity);
	CreateNative("Movement_GetSpeed", Native_GetSpeed);
	CreateNative("Movement_GetVerticalVelocity", Native_GetVerticalVelocity);
	CreateNative("Movement_GetBaseVelocity", Native_GetBaseVelocity);
	CreateNative("Movement_SetBaseVelocity", Native_SetBaseVelocity);
	CreateNative("Movement_GetOnGround", Native_GetOnGround);
	CreateNative("Movement_GetMoveType", Native_GetMoveType);
	CreateNative("Movement_SetMoveType", Native_SetMoveType);
	CreateNative("Movement_GetOnLadder", Native_GetOnLadder);
	CreateNative("Movement_GetNoclipping", Native_GetNoclipping);
	CreateNative("Movement_GetDucking", Native_GetDucking);
	CreateNative("Movement_GetTakeoffSpeed", Native_GetTakeoffSpeed);
	CreateNative("Movement_GetTakeoffOrigin", Native_GetTakeoffOrigin);
	CreateNative("Movement_GetTakeoffVelocity", Native_GetTakeoffVelocity);
	CreateNative("Movement_GetTakeoffTick", Native_GetTakeoffTick);
	CreateNative("Movement_GetLandingOrigin", Native_GetLandingOrigin);
	CreateNative("Movement_GetLandingVelocity", Native_GetLandingVelocity);
	CreateNative("Movement_GetLandingSpeed", Native_GetLandingSpeed);
	CreateNative("Movement_GetLandingTick", Native_GetLandingTick);
	CreateNative("Movement_GetJumpMaxHeight", Native_GetJumpMaxHeight);
	CreateNative("Movement_GetJumpDistance", Native_GetJumpDistance);
	CreateNative("Movement_GetJumpOffset", Native_GetJumpOffset);
	CreateNative("Movement_GetHitPerf", Native_GetHitPerf);
	CreateNative("Movement_GetVelocityModifier", Native_GetVelocityModifier);
	CreateNative("Movement_SetVelocityModifier", Native_SetVelocityModifier);
	CreateNative("Movement_GetDuckSpeed", Native_GetDuckSpeed);
	CreateNative("Movement_SetDuckSpeed", Native_SetDuckSpeed);
	CreateNative("Movement_GetEyeAngles", Native_GetEyeAngles);
	CreateNative("Movement_SetEyeAngles", Native_SetEyeAngles);
	CreateNative("Movement_GetTurning", Native_GetTurning);
	CreateNative("Movement_GetTurningLeft", Native_GetTurningLeft);
	CreateNative("Movement_GetTurningRight", Native_GetTurningRight);
	CreateNative("Movement_GetOldButtons", Native_GetOldButtons);
}

public int Native_GetOrigin(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_Origin[GetNativeCell(1)], 3);
}

public int Native_SetOrigin(Handle plugin, int numParams)
{
	GetNativeArray(2, gF_Origin[GetNativeCell(1)], 3);
	TeleportEntity(GetNativeCell(1), gF_Origin[GetNativeCell(1)], NULL_VECTOR, NULL_VECTOR);
	GetGroundOrigin(GetNativeCell(1), gF_GroundOrigin[GetNativeCell(1)]);
}

public int Native_GetGroundOrigin(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_GroundOrigin[GetNativeCell(1)], 3);
}

public int Native_GetVelocity(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_Velocity[GetNativeCell(1)], 3);
}

public int Native_SetVelocity(Handle plugin, int numParams)
{
	GetNativeArray(2, gF_Velocity[GetNativeCell(1)], 3);
	gF_Speed[GetNativeCell(1)] = SquareRoot(Pow(gF_Velocity[GetNativeCell(1)][0], 2.0) + Pow(gF_Velocity[GetNativeCell(1)][1], 2.0));
	if (gB_JustTookOff[GetNativeCell(1)])
	{
		gF_TakeoffVelocity[GetNativeCell(1)] = gF_Velocity[GetNativeCell(1)];
		gF_TakeoffSpeed[GetNativeCell(1)] = gF_Speed[GetNativeCell(1)];
	}
	TeleportEntity(GetNativeCell(1), NULL_VECTOR, NULL_VECTOR, gF_Velocity[GetNativeCell(1)]);
}

public int Native_GetSpeed(Handle plugin, int numParams)
{
	return view_as<int>(gF_Speed[GetNativeCell(1)]);
}

public int Native_GetVerticalVelocity(Handle plugin, int numParams)
{
	return view_as<int>(gF_Velocity[GetNativeCell(1)][2]);
}

public int Native_GetBaseVelocity(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_BaseVelocity[GetNativeCell(1)], 3);
}

public int Native_SetBaseVelocity(Handle plugin, int numParams)
{
	GetNativeArray(2, gF_BaseVelocity[GetNativeCell(1)], 3);
	SetEntPropVector(GetNativeCell(1), Prop_Data, "m_vecBaseVelocity", gF_BaseVelocity[GetNativeCell(1)]);
}

public int Native_GetOnGround(Handle plugin, int numParams)
{
	return view_as<int>(gB_OnGround[GetNativeCell(1)]);
}

public int Native_GetMoveType(Handle plugin, int numParams)
{
	return view_as<int>(gMT_MoveType[GetNativeCell(1)]);
}

public int Native_SetMoveType(Handle plugin, int numParams)
{
	gMT_MoveType[GetNativeCell(1)] = view_as<MoveType>(GetNativeCell(2));
	SetEntityMoveType(GetNativeCell(1), view_as<MoveType>(GetNativeCell(2)));
}

public int Native_GetOnLadder(Handle plugin, int numParams)
{
	return view_as<int>(gMT_MoveType[GetNativeCell(1)] == MOVETYPE_LADDER);
}

public int Native_GetNoclipping(Handle plugin, int numParams)
{
	return view_as<int>(gMT_MoveType[GetNativeCell(1)] == MOVETYPE_NOCLIP);
}

public int Native_GetDucking(Handle plugin, int numParams)
{
	return view_as<int>(gB_Ducking[GetNativeCell(1)]);
}

public int Native_GetTakeoffOrigin(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_TakeoffOrigin[GetNativeCell(1)], 3);
}

public int Native_GetTakeoffVelocity(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_TakeoffVelocity[GetNativeCell(1)], 3);
}

public int Native_GetTakeoffSpeed(Handle plugin, int numParams)
{
	return view_as<int>(gF_TakeoffSpeed[GetNativeCell(1)]);
}

public int Native_GetTakeoffTick(Handle plugin, int numParams)
{
	return gI_TakeoffTick[GetNativeCell(1)];
}

public int Native_GetLandingOrigin(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_LandingOrigin[GetNativeCell(1)], 3);
}

public int Native_GetLandingVelocity(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_LandingVelocity[GetNativeCell(1)], 3);
}

public int Native_GetLandingSpeed(Handle plugin, int numParams)
{
	return view_as<int>(gF_LandingSpeed[GetNativeCell(1)]);
}

public int Native_GetLandingTick(Handle plugin, int numParams)
{
	return gI_LandingTick[GetNativeCell(1)];
}

public int Native_GetJumpMaxHeight(Handle plugin, int numParams)
{
	return view_as<int>(gF_JumpMaxHeight[GetNativeCell(1)]);
}

public int Native_GetJumpDistance(Handle plugin, int numParams)
{
	return view_as<int>(gF_JumpDistance[GetNativeCell(1)]);
}

public int Native_GetJumpOffset(Handle plugin, int numParams)
{
	return view_as<int>(gF_JumpOffset[GetNativeCell(1)]);
}

public int Native_GetHitPerf(Handle plugin, int numParams)
{
	return view_as<int>(gB_HitPerf[GetNativeCell(1)]);
}

public int Native_GetVelocityModifier(Handle plugin, int numParams)
{
	return view_as<int>(gF_VelocityModifier[GetNativeCell(1)]);
}

public int Native_SetVelocityModifier(Handle plugin, int numParams)
{
	gF_VelocityModifier[GetNativeCell(1)] = GetNativeCell(2);
	SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flVelocityModifier", GetNativeCell(2));
}

public int Native_GetDuckSpeed(Handle plugin, int numParams)
{
	return view_as<int>(gF_DuckSpeed[GetNativeCell(1)]);
}

public int Native_SetDuckSpeed(Handle plugin, int numParams)
{
	gF_DuckSpeed[GetNativeCell(1)] = GetNativeCell(2);
	SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flDuckSpeed", GetNativeCell(2));
}

public int Native_GetEyeAngles(Handle plugin, int numParams)
{
	SetNativeArray(2, gF_EyeAngles[GetNativeCell(1)], 3);
}

public int Native_SetEyeAngles(Handle plugin, int numParams)
{
	GetNativeArray(2, gF_EyeAngles[GetNativeCell(1)], 3);
	TeleportEntity(GetNativeCell(1), NULL_VECTOR, gF_EyeAngles[GetNativeCell(1)], NULL_VECTOR);
}

public int Native_GetTurning(Handle plugin, int numParams)
{
	return view_as<int>(PlayerIsTurning(GetNativeCell(1)));
}

public int Native_GetTurningLeft(Handle plugin, int numParams)
{
	
	return view_as<int>(PlayerIsTurningLeft(GetNativeCell(1)));
}

public int Native_GetTurningRight(Handle plugin, int numParams)
{
	return view_as<int>(PlayerIsTurning(GetNativeCell(1)) && !PlayerIsTurningLeft(GetNativeCell(1)));
}

public int Native_GetOldButtons(Handle plugin, int numParams)
{
	return gI_OldButtons[GetNativeCell(1)];
} 