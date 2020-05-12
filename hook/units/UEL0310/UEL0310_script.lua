#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0309/UEL0309_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Terran Tech 3 Engineer
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit

local UEL0310 = Class(TConstructionUnit) {
    BuildBones = {
        AimBone = 0,
        PitchBone = 'Turret_Barrel',
        YawBone = 'Turret',
        BuildEffectBones = { 'Turret_Muzzle01', 'Turret_Muzzle02', 'Turret_Muzzle03' },
    },
    
    OnCreate=function(self)
    self:SetCustomName("Necro")
    TConstructionUnit.OnCreate(self)
    end,
}

TypeClass = UEL0310