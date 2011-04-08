--[[----------------------------------------------------------------------------------
	Broker_Pet Core	
------------------------------------------------------------------------------------]]

local UPDATEPERIOD, elapsed = 0.5, 0
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("Broker_Pet", {type = "data source", text = "No Pet"})
local f = CreateFrame("frame")
local happycolors = {"FFFF0000", "FFFFFF00", "FF00FF00"}
local length = 30
local char = "||"
local	colorXP = "ff6060ff"
local colorRemaining = "ffcccccc"
local Petname, Petlevel, currXP, nextXP, displaystring, numberoffilledbars, numberofemptybars

if not Broker_PetDBPC then Broker_PetDBPC = {} end
if not Broker_PetDBPC.displaybar then Broker_PetDBPC.displaybar = false end

local function updatedisplay()
	local PetHappiness = (GetPetHappiness())
	if (PetHappiness) then
		Petname = UnitName("pet")
		Petlevel = UnitLevel("pet")
		currXP, nextXP = GetPetExperience()
		displaystring = '|c' .. happycolors[PetHappiness] .. Petname .. '|r'
		if (Petlevel ~= UnitLevel("player")) then
			displaystring = displaystring .. ' (' .. Petlevel .. ')'
			if Broker_PetDBPC.displaybar then
				numberoffilledbars = math.ceil(currXP/nextXP*length)
				numberofemptybars = length - numberoffilledbars
				displaystring = displaystring .. ' |c' .. colorXP .. string.rep(char, numberoffilledbars) .. '|r|c' .. colorRemaining .. string.rep(char, numberofemptybars) .. '|r'
			else
				displaystring = displaystring .. ' ' .. currXP .. '/' .. nextXP
			end
		end
		dataobj.text = displaystring
	else
		dataobj.text = "No pet"
	end
end

function dataobj.OnClick(self, button)
	Broker_PetDBPC.displaybar = not Broker_PetDBPC.displaybar
	updatedisplay()
end

f:SetScript("OnUpdate", function(self, elap)
    elapsed = elapsed + elap
    if elapsed < UPDATEPERIOD then return end
    elapsed = 0
	updatedisplay()
end)