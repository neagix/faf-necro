#****************************************************************************
#**
#**  File     :  /units/URL0310/URL0310_script.lua
#**  Author(s):  neagix
#**
#**  Summary  :  Nomads Unit Script
#**
#**  Copyright © 2020 neagix - licensed under a BSD 3-clause license
#****************************************************************************
#
# NOMADS TIER 3 NECRO
#

local NConstructionUnit = import('/lua/nomadsunits.lua').NConstructionUnit
local necro = import('/mods/necro/necro.lua')

local XNL0310 = Class(NConstructionUnit) {

    OnCreate=function(self)
        self:SetCustomName("Necro")
        NConstructionUnit.OnCreate(self)
    end,

    OnStartReclaim = function(self, target)
		if not necro.StartReclaim(self, target) then
			return
		end

        NConstructionUnit.OnStartReclaim(self, target)
    end,

    GetReclaimCosts = function(self, target)
		local t, e, m = NConstructionUnit.GetReclaimCosts(self, target)
		
		# reduce reclaim energy/mass to 1
		return t, 1, 1
    end,

    OnStopReclaim = function(self, target)
        NConstructionUnit.OnStopReclaim(self, target)
        
		if not target then
			necro.StopReclaim(self)
		end
    end,

}

TypeClass = XNL0310
