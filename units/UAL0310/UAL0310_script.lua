#****************************************************************************
#**
#**  File     :  /units/UAL0310/UAL0310_script.lua
#**  Author(s):  neagix
#**
#**  Summary  :  Aeon Unit Script
#**
#**  Copyright © 2020 neagix - licensed under a BSD 3-clause license
#****************************************************************************
#
# AEON TECH 3 NECRO
#

local AConstructionUnit = import('/lua/aeonunits.lua').AConstructionUnit
local necro = import('/mods/necro/necro.lua')

local UAL0310 = Class(AConstructionUnit) {

    OnCreate=function(self)
        self:SetCustomName("Necro")
        AConstructionUnit.OnCreate(self)
    end,
    
    OnStartReclaim = function(self, target)
		if not necro.StartReclaim(self, target) then
			return
		end

        AConstructionUnit.OnStartReclaim(self, target)
    end,

    GetReclaimCosts = function(self, target)
		local t, e, m = AConstructionUnit.GetReclaimCosts(self, target)
		
		# reduce reclaim energy/mass to 1
		return t, 1, 1
    end,

    OnStopReclaim = function(self, target)
        AConstructionUnit.OnStopReclaim(self, target)

		if not target then
			necro.StopReclaim(self)
		end
    end,

}

TypeClass = UAL0310
