do
local necro = import('/mods/necro/necro.lua')
local unitOld=Unit
LOG('Unit opening')
Unit=Class(unitOld){

OnStartReclaim = function(self, target)
        self.RecBP=target.AssociatedBP
        self.RecPosition=target:GetPosition()
        self:DoOnStartReclaimCallbacks()
        self:StartReclaimEffects(target)
        self:PlayUnitSound('StartReclaim')
        self:PlayUnitAmbientSound('ReclaimLoop')
    end,

OnStopReclaim = function(self, target)
        self:DoOnStopReclaimCallbacks()
		self:StopReclaimEffects(target)
		self:StopUnitAmbientSound('ReclaimLoop')
		self:PlayUnitSound('StopReclaim')
	ForkThread(function()
	WaitSeconds(1)
	LOG(self.RecBP)
	if (not target) and (self.RecBP) then
        local army=self:GetArmy()
        local aiBrain=self:GetAIBrain()
        local blueprint=aiBrain:GetUnitBlueprint(self.RecBP)
        local position=self.RecPosition
        if EntityCategoryContains(categories.NECRO,self)then
                necro.RespawnUnit(self.RecBP,army,position[1],position[2],position[3])
        end
	end
	end)
    end,

}
end