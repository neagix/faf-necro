#****************************************************************************
#**
#**  File     :  /units/URL0310/URL0310_script.lua
#**  Author(s):  neagix
#**
#**  Summary  :  Seraphim Unit Script
#**
#**  Copyright © 2020 neagix - licensed under a BSD 3-clause license
#****************************************************************************
#
# SERAPHIM TIER 3 NECRO
#

local SConstructionUnit = import('/lua/seraphimunits.lua').SConstructionUnit
local necro = import('/mods/necro/necro.lua')

local XSL0310 = Class(SConstructionUnit) {

    OnCreate=function(self)
        self:SetCustomName("Necro")
        SConstructionUnit.OnCreate(self)
    end,

    OnStartReclaim = function(self, target)
		if not necro.StartReclaim(self, target) then
			return
		end

        SConstructionUnit.OnStartReclaim(self, target)
    end,

    GetReclaimCosts = function(self, target)
		local t, e, m = SConstructionUnit.GetReclaimCosts(self, target)
		
		# reduce reclaim energy/mass to 1
		return t, 1, 1
    end,

    OnStopReclaim = function(self, target)
        SConstructionUnit.OnStopReclaim(self, target)
        
		if not target then
			necro.StopReclaim(self)
		end
    end,

}

TypeClass = XSL0310

