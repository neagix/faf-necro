local NConstructionUnit = import('/lua/nomadsunits.lua').NConstructionUnit

XNL0310 = Class(NConstructionUnit) {

    OnCreate=function(self)
        self:SetCustomName("Necro")
        NConstructionUnit.OnCreate(self)
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

        NConstructionUnit.OnStartReclaim(self, spec)
    end,

    OnStopReclaim = function(self, target)
        NConstructionUnit.OnStopReclaim(self, target)

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

TypeClass = XNL0310

