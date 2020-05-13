
local recLookup = {}

StartReclaim = function(self, spec)
		self.RecEntityId = nil
		
        # do not resurrect buildings or experimentals or anything which is not a wreckage
        if (not spec.IsWreckage) or __blueprints[spec.AssociatedBP].CategoriesHash.STRUCTURE or __blueprints[spec.AssociatedBP].CategoriesHash.EXPERIMENTAL then
            return false
        end
        
        if recLookup[spec.EntityId] == nil then
			recLookup[spec.EntityId] = {
				BP = spec.AssociatedBP,
				Pos = spec.CachePosition,
				# 1/10th of the reclaim left
				HealthFactor = spec.ReclaimLeft/10
			}
			LOG('created prop entry for', spec.EntityId)
        end

        # allow multiple Necro units to start reclaiming+reviving+repairing the same wreckage
        self.RecEntityId=spec.EntityId
        
        return true
end

StopReclaim = function(self)
   # not resurrecting anything
   if self.RecEntityId == nil then
       return
   end
   
   # check if already resurrected
   local rec = recLookup[self.RecEntityId]
   local unit
   if rec ~= false then
	   # prevent other units to resurrect more than once
	   recLookup[self.RecEntityId] = false

	   LOG('resurrecting unit ' .. rec.BP)

	   unit = CreateUnitHPR(rec.BP, self:GetArmy(), rec.Pos[1], rec.Pos[2], rec.Pos[3], 0, 0, 0)
	   # TryCopyPose(rec.Prop, h, true)

	   local health = unit:GetMaxHealth() * rec.HealthFactor
	   if health < 1 then
		   health = 1
	   end
	   unit:SetHealth(unit, health)
	   unit:SetFuelRatio(0)
	   unit:SetShieldRatio(0)
	else
		# allow repairing
		unit = GetEntityById(self.RecEntityId)
	end
	self.RecEntityId = nil

	ForkThread(function()
       WaitTicks(1)
       IssueRepair({self}, unit)
	end)
end
