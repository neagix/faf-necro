#****************************************************************************
#**
#**  File     :  /units/UEL0310/UEL0310_script.lua
#**  Author(s):  neagix
#**
#**  Summary  :  Terran Unit Script
#**
#**  Copyright © 2020 neagix - licensed under a BSD 3-clause license
#****************************************************************************
#
# TERRAN TECH 3 NECRO
#

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit
local necro = import('/mods/necro/necro.lua')

local UEL0310 = Class(TConstructionUnit) {

    OnCreate=function(self)
        self:SetCustomName("Necro")
        TConstructionUnit.OnCreate(self)
    end,

    OnStartReclaim = function(self, target)
		if not necro.StartReclaim(self, target) then
			return
		end

        TConstructionUnit.OnStartReclaim(self, target)
    end,
    
    GetReclaimCosts = function(self, target)
		local t, e, m = TConstructionUnit.GetReclaimCosts(self, target)
		
		# reduce reclaim energy/mass to 1
		return t, 1, 1
    end,

    OnStopReclaim = function(self, target)
        TConstructionUnit.OnStopReclaim(self, target)
        
		if not target then
			necro.StopReclaim(self)
		end
    end,

}

TypeClass = UEL0310
