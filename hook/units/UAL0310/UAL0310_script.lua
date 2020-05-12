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

UAL0310 = Class(AConstructionUnit) {

OnCreate=function(self)
    self:SetCustomName("Necro")
    AConstructionUnit.OnCreate(self)
    end,
    
    OnStartReclaim = function(self, spec)
		self.RecBP=spec.AssociatedBP
		# do not resurrect buildings or experimentals
		if self.RecBP.CategoriesHash.STRUCTURE or self.RecBP.CategoriesHash.EXPERIMENTAL then
			self.RecBP = nil
			return
		end

		self.RecPosition=spec.CachePosition
		self.RecOrient=spec.OrientationCache   #spec:GetOrientation()
		
		# 1/10th of the reclaim left
		self.RecFactor = spec.ReclaimLeft/10
		
		TConstructionUnit.OnStartReclaim(self, spec)
    end,

OnStopReclaim = function(self, target)
		TConstructionUnit.OnStopReclaim(self, target)

		if (not target) and (self.RecBP) then
			LOG('resurrecting unit ' .. self.RecBP)

			local position=self.RecPosition
			local orient=self.RecOrient
			LOG('orientation:', orient[1], orient[2], orient[3])
			h = CreateUnitHPR(self.RecBP, self:GetArmy(), position[1], position[2], position[3], orient[1], orient[2], orient[3])

			health = h:GetMaxHealth() * self.RecFactor
			if health < 1 then
				health = 1
			end
			h:SetHealth(h, health)

			ForkThread(function()
				WaitTicks(1)
				IssueRepair({self}, h)
			end)
		end
    end,

}

TypeClass = UAL0310
