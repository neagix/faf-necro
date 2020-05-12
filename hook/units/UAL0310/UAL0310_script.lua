#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0309/UAL0309_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# AEON TECH 3 ENGINEER
#
local AConstructionUnit = import('/lua/aeonunits.lua').AConstructionUnit
UAL0310 = Class(AConstructionUnit) {


OnCreate=function(self)
    self:SetCustomName("Necro")
    AConstructionUnit.OnCreate(self)
    end,
  }
TypeClass = UAL0310

