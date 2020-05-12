do
local Entity = import('/lua/sim/Entity.lua').Entity
local EffectUtil = import('/lua/EffectUtilities.lua')
local oldPropfile=Prop

Prop = Class(oldPropfile) {

        GetReclaimCosts = function(self, reclaimer)
        local rbp = reclaimer:GetBlueprint()
        local mtime = self.ReclaimTimeMassMult * (self.MassReclaim / (rbp.Economy.BuildRate or 1))
        local etime = self.ReclaimTimeEnergyMult * (self.EnergyReclaim / (rbp.Economy.BuildRate or 1))
        local time = mtime

        if mtime < etime then
            time = etime
        end
        
        if EntityCategoryContains(categories.NECRO,reclaimer)then
        return (time/10), 1, 1
        end
        return (time/10), self.EnergyReclaim, self.MassReclaim
    end,
}
end
