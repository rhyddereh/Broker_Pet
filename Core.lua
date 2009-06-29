--[[----------------------------------------------------------------------------------
	Broker_Pet Core
	
	TODO:   
	
------------------------------------------------------------------------------------]]


local UPDATEPERIOD, elapsed = 0.5, 0
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("Broker_Pet", {type = "data source", text = "No Pet"})
local f = CreateFrame("frame")
local happycolors = {"FF00FF00", "FFFFFF00", "FFFF0000"}

f:SetScript("OnUpdate", function(self, elap)
    elapsed = elapsed + elap
    if elapsed < UPDATEPERIOD then return end
    elapsed = 0
	local PetHappiness = (GetPetHappiness())
	if (PetHappiness) then
		local Petname = UnitName("pet")
		local Petlevel = UnitLevel("pet")
		local currXP, nextXP = GetPetExperience()
		local displaystring = '|c' .. happycolors[PetHappiness] .. Petname .. '|r'
		if (Petlevel == UnitLevel("player")) then
			displaystring = displaystring .. ' (' .. Petlevel .. ') ' .. currXP .. '/' .. nextXP
		end
		dataobj.text = displaystring
	else
		dataobj.text = "No pet"
	end
end)