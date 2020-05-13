#****************************************************************************
#**
#**  File     :  /units/URL0310/URL0310_script.lua
#**  Author(s):  neagix
#**
#**  Summary  :  Cybran Unit Script
#**
#**  Copyright © 2020 neagix - licensed under a BSD 3-clause license
#****************************************************************************
#
# CYBRAN TIER 3 NECRO
#

local CConstructionUnit = import('/lua/cybranunits.lua').CConstructionUnit
local necro = import('/mods/necro/necro.lua')

local URL0310 = Class(CConstructionUnit) {

    OnCreate=function(self)
        self:SetCustomName("Necro")
        CConstructionUnit.OnCreate(self)
    end,

    OnStartReclaim = function(self, target)
		if not necro.StartReclaim(self, target) then
			return
		end

        CConstructionUnit.OnStartReclaim(self, target)
    end,

    GetReclaimCosts = function(self, target)
		local t, e, m = CConstructionUnit.GetReclaimCosts(self, target)
		
		# reduce reclaim energy/mass to 1
		return t, 1, 1
    end,

    OnStopReclaim = function(self, target)
        CConstructionUnit.OnStopReclaim(self, target)

		if not target then
			necro.StopReclaim(self)
		end
    end,

}
TypeClass = URL0310
