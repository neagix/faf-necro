local oldPosition1=1
local oldPosition2=1
local oldPosition3=1

RespawnUnit=function(blueprint,army,pos1,pos2,pos3)
if oldPosition1~=pos1 or oldPosition3~=pos3 or oldPosition2~=pos2 then
CreateUnitHPR(blueprint,army,pos1,pos2,pos3,0,0,0)
oldPosition1=pos1
oldPosition2=pos2
oldPosition3=pos3
end

end