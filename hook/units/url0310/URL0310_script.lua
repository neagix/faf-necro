#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0309/URL0309_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Tier 3 Engineer Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CConstructionUnit = import('/lua/cybranunits.lua').CConstructionUnit

URL0310 = Class(CConstructionUnit) {
    BuildBones = {
        YawBone = 'Buildpoint_Center',
        PitchBone = 'Buildpoint_Center',
        BuildEffectBones = {'Buildpoint_Left','Buildpoint_Center','Buildpoint_Right'},
    },
    OnCreate=function(self)
    self:SetCustomName("Necro")
    CConstructionUnit.OnCreate(self)
    end,
}
TypeClass = URL0310