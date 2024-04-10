BINDING_HEADER_WEAPONWHEEL_HEADER = "Weapon Wheel";
BINDING_NAME_WEAPONWHEEL1 = "Weapon Wheel 1";
BINDING_NAME_WEAPONWHEEL2 = "Weapon Wheel 2";
BINDING_NAME_WEAPONWHEEL3 = "Weapon Wheel 3";
BINDING_NAME_WEAPONWHEEL4 = "Weapon Wheel 4";

local currentWheel = nil
local currentAction = nil
local wheelSpawnAlpha = 0.01
local clickpos = {}
clickpos[1] = { x=0, y=0 }
clickpos[2] = { x=0, y=0 }
clickpos[3] = { x=0, y=0 }
clickpos[4] = { x=0, y=0 }

local clicktime = {}
clicktime[1] = 0
clicktime[2] = 0
clicktime[3] = 0
clicktime[4] = 0


function WeaponWheel_OnLoad()
--	PickupAction = LazyPig_PickupAction; -- BALAKE ACTION BAR HOOK

	this:RegisterEvent("VARIABLES_LOADED")
	
	SLASH_WEAPONWHEEL1 = "/WeaponWheel";
	SlashCmdList["WEAPONWHEEL"] = WeaponWheelCmd;
end

function WeaponWheelCmd(msg)
	msg = strlower(msg)
	local _, _, scale = strfind(msg, "scale (%d+%.?%d*)")
	if scale then
		WeaponWheelScale = scale
		WeaponWheel1:SetScale(scale)
		WeaponWheel2:SetScale(scale)
		WeaponWheel3:SetScale(scale)
		WeaponWheel4:SetScale(scale)
		DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel: |cffffffff Show Scale "..scale, WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		return
	end
	local _, _, alpha = strfind(msg, "alpha (%d+%.?%d*)")
	if alpha then
		WeaponWheelMaxAlpha = alpha
		DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel: |cffffffff Show Alpha "..alpha, WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		return
	end
	local _, _, delay = strfind(msg, "delay (%d+%.?%d*)")
	if delay then
		WeaponWheelShowDelay = delay
		DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel: |cffffffff Show Delay "..delay, WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		return
	end
	if strfind(msg, "rgb") then
		local _, _, red, green, blue = strfind(msg, "rgb (%d+%.?%d*)%s(%d+%.?%d*)%s(%d+%.?%d*)")
		if not red or not green or not blue then
			DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel: |cffffffff rgb {red} {green} {blue}", WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		else
			WeaponWheelHighlightColor.r = red
			WeaponWheelHighlightColor.g = green
			WeaponWheelHighlightColor.b = blue
			DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel New Highlight Color", WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			
			WeaponWheel1.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel1.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel1.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel1.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			
			WeaponWheel2.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel2.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel2.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel2.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			
			WeaponWheel3.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel3.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel3.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel3.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			
			WeaponWheel4.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel4.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel4.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
			WeaponWheel4.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		end
		return
	end
	if strfind(msg, "defaults") then
		WeaponWheelShowDelay = 0.15
		WeaponWheelMaxAlpha = 0.3
		WeaponWheelHighlightColor = { r=0.6, g=0.4, b=0.4 }
		WeaponWheelScale = 1
		
		WeaponWheel1:SetScale(WeaponWheelScale)
		WeaponWheel2:SetScale(WeaponWheelScale)
		WeaponWheel3:SetScale(WeaponWheelScale)
		WeaponWheel4:SetScale(WeaponWheelScale)
		
		WeaponWheel1.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel1.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel1.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel1.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		
		WeaponWheel2.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel2.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel2.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel2.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		
		WeaponWheel3.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel3.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel3.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel3.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		
		WeaponWheel4.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel4.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel4.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		WeaponWheel4.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		
		DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel: |cffffffff Reset to default settings", WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
		return
	end
	DEFAULT_CHAT_FRAME:AddMessage("Weapon Wheel: |cffffffff defaults / scale / alpha / delay / rgb", WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
	return
end

function WeaponWheelTemplate_OnUpdate(arg1)
	if GetTime() - WeaponWheelShowDelay > clicktime[this:GetID()] then
		this:SetAlpha(min(this:GetAlpha() + (this:GetAlpha()*arg1*30), WeaponWheelMaxAlpha))
	end
	if WeaponWheelEditBox:IsShown() or WeaponWheelIconBox:IsShown() then return end
	this.highlightRight:Hide()
	this.highlightUp:Hide()
	this.highlightDown:Hide()
	this.highlightLeft:Hide()
	
	currentAction = MouseDirectionToWheel(this)
	if currentAction == 1 then
		this.highlightUp:Show()
	elseif currentAction == 2 then
		this.highlightRight:Show()
	elseif currentAction == 3 then
		this.highlightDown:Show()
	elseif currentAction == 4 then
		this.highlightLeft:Show()
	end
end

function WeaponWheelTemplate_OnClick(button)
	currentAction = MouseDirectionToWheel(this)
	currentWheel = this:GetID()
	if ( button == "RightButton" ) then
		this:EnableMouse(false)
		local MouseX, MouseY = GetCursorPosition();
		local scale = WeaponWheelEditBox:GetEffectiveScale()
			
		MouseX = MouseX / scale
		MouseY = MouseY / scale
		
		WeaponWheelEditBox:ClearAllPoints();
		WeaponWheelEditBox:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", MouseX, MouseY);
		WeaponWheelEditBox:Show()
		WeaponWheelEditBox:SetClampedToScreen(true)
		if currentAction == 5 then
			if MouseIsOver(this.iconUpFrame) then
				currentAction = 1
			elseif MouseIsOver(this.iconRightFrame) then
				currentAction = 2
			elseif MouseIsOver(this.iconDownFrame) then
				currentAction = 3
			elseif MouseIsOver(this.iconLeftFrame) then
				currentAction = 4
			end
		end

		WeaponWheelEditAction:SetText(WeaponWheelActions[currentWheel][currentAction])
	else
		if currentAction == 5 then
			if MouseIsOver(this.iconCenterFrame) then
				WeaponWheelShowTextureSelect(this, 5)
			elseif MouseIsOver(this.iconUpFrame) then
				WeaponWheelShowTextureSelect(this, 1)
			elseif MouseIsOver(this.iconRightFrame) then
				WeaponWheelShowTextureSelect(this, 2)
			elseif MouseIsOver(this.iconDownFrame) then
				WeaponWheelShowTextureSelect(this, 3)
			elseif MouseIsOver(this.iconLeftFrame) then
				WeaponWheelShowTextureSelect(this, 4)
			end
		else
			WeaponWheelActions[currentWheel][5] = WeaponWheelActions[currentWheel][currentAction]
			WeaponWheelIcons[currentWheel][5] = WeaponWheelIcons[currentWheel][currentAction]
			RefreshWeaponWheelIcons(this)
		end
	end
end

function WeaponWheel_OnUpdate()
	
end

function WeaponWheel_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		if not WeaponWheelActions or not WeaponWheelIcons then
			WeaponWheelInitializeSettings()
		end
		if not WeaponWheelScale then
			WeaponWheelScale = 1.0
		end
		if not WeaponWheelShowDelay or not WeaponWheelMaxAlpha or not WeaponWheelHighlightColor then
			WeaponWheelInitializeConfig()
		end
		WeaponWheel1 = CreateFrame("Frame", "WeaponWheel1", UIParent, "WeaponWheelTemplate")
		CreateWeaponWheelFrame(WeaponWheel1, 1)
		
		WeaponWheel2 = CreateFrame("Frame", "WeaponWheel2", UIParent, "WeaponWheelTemplate")
		CreateWeaponWheelFrame(WeaponWheel2, 2)
		
		WeaponWheel3 = CreateFrame("Frame", "WeaponWheel3", UIParent, "WeaponWheelTemplate")
		CreateWeaponWheelFrame(WeaponWheel3, 3)
		
		WeaponWheel4 = CreateFrame("Frame", "WeaponWheel4", UIParent, "WeaponWheelTemplate")
		CreateWeaponWheelFrame(WeaponWheel4, 4)
	end
end

function WeaponWheelShow(arg)
	local frame = GetWeaponWheelFromIndex(arg)
	local MouseX, MouseY = GetCursorPosition();
	local scale = frame:GetEffectiveScale()
	
	currentWheel = arg
	clickpos[arg] = { x=MouseX, y=MouseY}
	clicktime[arg] = GetTime()
		
	MouseX = MouseX / scale
	MouseY = MouseY / scale
	
	frame:ClearAllPoints();
	frame:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", MouseX, MouseY);
	frame:SetAlpha(wheelSpawnAlpha)
	frame:EnableMouse(true)
	frame:Show()
	
	RefreshWeaponWheelIcons(frame)
end

function WeaponWheelAction(arg)
	if WeaponWheelEditBox:IsShown() then
		WeaponWheelEditAction:SetFocus()
	elseif WeaponWheelIconBox:IsShown() then
		WeaponWheelIconBox:SetFocus()
	else
		local frame = GetWeaponWheelFromIndex(arg)
		local loadedstring = WeaponWheelActions[arg][currentAction]
		local func, errormessage = loadstring(loadedstring)
		if func then func() else DEFAULT_CHAT_FRAME:AddMessage("|cffcc3333ERROR: |cffff5555".. (errormessage or "nil" )) end
		frame:Hide()
	end
end

function WeaponWheelConfirmEdit()
	WeaponWheelActions[currentWheel][currentAction] = WeaponWheelEditAction:GetText()
	WeaponWheelEditBox:Hide()
	local frame = GetWeaponWheelFromIndex(currentWheel)
	frame:Hide()
end

function WeaponWheelConfirmIconEdit()
	WeaponWheelIcons[currentWheel][currentAction] = WeaponWheelIconBox:GetText()
	print(WeaponWheelIcons[currentWheel][currentAction])
	WeaponWheelIconBox:Hide()
	local frame = GetWeaponWheelFromIndex(currentWheel)
	frame:Hide()
end

function WeaponWheelActionToSpellicon(wheelID, actionID)
	local _, _, spellname = strfind(WeaponWheelActions[wheelID][actionID], "CastSpellByName%(\"(.-)\"%)")
	local _, _, spellid = strfind(WeaponWheelActions[wheelID][actionID], "%-%-spell%:(%d+)")
	if spellid and SpellInfo then -- If the user has the expanded API mod
		local _, _, texture = SpellInfo(tonumber(spellid))
		return texture
	end
	if spellname then
		local l, _, spellrank = strfind(spellname, "(%(Rank .%))$")
		if spellrank then
			spellname = strsub(spellname, 1, l-1)
		end
		local i = 1
		while true do
			local bookSpellName, bookSpellRank = GetSpellName(i, BOOKTYPE_SPELL);
			if not bookSpellName then break end
			if strlower(spellname) == strlower(bookSpellName) then
				return GetSpellTexture(i, BOOKTYPE_SPELL)
			end
			
			i = i + 1;
		end
	end
	return nil
end

function RefreshWeaponWheelIcons(frame)
	local id = frame:GetID()
	local prefix = "Interface\\Icons\\"
	if WeaponWheelIcons[id][1] ~= "" then
		if not frame.iconUp:SetTexture(prefix..WeaponWheelIcons[id][1]) then frame.iconUp:SetTexture(nil) end
	elseif WeaponWheelActionToSpellicon(id, 1) then
		frame.iconUp:SetTexture(WeaponWheelActionToSpellicon(id, 1))
	else
		frame.iconUp:SetTexture(prefix.."INV_Misc_QuestionMark")
	end
	if WeaponWheelIcons[id][2] ~= "" then
		if not frame.iconRight:SetTexture(prefix..WeaponWheelIcons[id][2]) then frame.iconRight:SetTexture(nil) end
	elseif WeaponWheelActionToSpellicon(id, 2) then
		frame.iconRight:SetTexture(WeaponWheelActionToSpellicon(id, 2))
	else
		frame.iconRight:SetTexture(prefix.."INV_Misc_QuestionMark")
	end
	if WeaponWheelIcons[id][3] ~= "" then
		if not frame.iconDown:SetTexture(prefix..WeaponWheelIcons[id][3]) then frame.iconDown:SetTexture(nil) end
	elseif WeaponWheelActionToSpellicon(id, 3) then
		frame.iconDown:SetTexture(WeaponWheelActionToSpellicon(id, 3))
	else
		frame.iconDown:SetTexture(prefix.."INV_Misc_QuestionMark")
	end
	if WeaponWheelIcons[id][4] ~= "" then
		if not frame.iconLeft:SetTexture(prefix..WeaponWheelIcons[id][4]) then frame.iconLeft:SetTexture(nil) end
	elseif WeaponWheelActionToSpellicon(id, 4) then
		frame.iconLeft:SetTexture(WeaponWheelActionToSpellicon(id, 4))
	else
		frame.iconLeft:SetTexture(prefix.."INV_Misc_QuestionMark")
	end
	if WeaponWheelIcons[id][5] ~= "" then
		if not frame.iconCenter:SetTexture(prefix..WeaponWheelIcons[id][5]) then frame.iconCenter:SetTexture(nil) end
	elseif WeaponWheelActionToSpellicon(id, 5) then
		frame.iconCenter:SetTexture(WeaponWheelActionToSpellicon(id, 5))
	else
		frame.iconCenter:SetTexture(prefix.."INV_Misc_QuestionMark")
	end
end

function WeaponWheelShowTextureSelect(frame, actionID)
	currentWheel = frame:GetID()
	currentAction = actionID
	this:EnableMouse(false)
	
	WeaponWheelIconBox:ClearAllPoints();
	WeaponWheelIconBox:SetPoint("CENTER", this, "CENTER", 0, -30);
	WeaponWheelIconBox:Show()
	WeaponWheelIconBox:SetClampedToScreen(true)
	WeaponWheelIconBox:SetText(WeaponWheelIcons[currentWheel][currentAction])
end

function GetWeaponWheelFromIndex(index)
	if index == 1 then return WeaponWheel1
	elseif index == 2 then return WeaponWheel2
	elseif index == 3 then return WeaponWheel3
	elseif index == 4 then return WeaponWheel4 end
end

function CreateWeaponWheelFrame(this, index)
	this:Hide()
	this:SetScale(WeaponWheelScale)
	this:SetID(index)
	this:SetWidth(1024)
	this:SetHeight(1024)
	this:SetFrameStrata("HIGH")

	this.texture = this:CreateTexture(nil, "ARTWORK")
	this.texture:SetTexture("Interface\\AddOns\\WeaponWheel\\Textures\\DefaultWheel")
	this.texture:SetPoint("CENTER", this, "CENTER")
	this.texture:SetVertexColor(1, 1, 1)
	this.texture:SetWidth(256)
	this.texture:SetHeight(256)
	
	this.highlightLeft = this:CreateTexture(nil, "OVERLAY")
	this.highlightLeft:SetTexture("Interface\\AddOns\\WeaponWheel\\Textures\\HighlightLeft")
	this.highlightLeft:SetPoint("CENTER", this, "CENTER")
	this.highlightLeft:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
	this.highlightLeft:SetWidth(256)
	this.highlightLeft:SetHeight(256)
	this.highlightLeft:Hide()
	
	this.highlightRight = this:CreateTexture(nil, "OVERLAY")
	this.highlightRight:SetTexture("Interface\\AddOns\\WeaponWheel\\Textures\\HighlightRight")
	this.highlightRight:SetPoint("CENTER", this, "CENTER")
	this.highlightRight:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
	this.highlightRight:SetWidth(256)
	this.highlightRight:SetHeight(256)
	this.highlightRight:Hide()
	
	this.highlightUp = this:CreateTexture(nil, "OVERLAY")
	this.highlightUp:SetTexture("Interface\\AddOns\\WeaponWheel\\Textures\\HighlightUp")
	this.highlightUp:SetPoint("CENTER", this, "CENTER")
	this.highlightUp:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
	this.highlightUp:SetWidth(256)
	this.highlightUp:SetHeight(256)
	this.highlightUp:Hide()
	
	this.highlightDown = this:CreateTexture(nil, "OVERLAY")
	this.highlightDown:SetTexture("Interface\\AddOns\\WeaponWheel\\Textures\\HighlightDown")
	this.highlightDown:SetPoint("CENTER", this, "CENTER")
	this.highlightDown:SetVertexColor(WeaponWheelHighlightColor.r , WeaponWheelHighlightColor.g , WeaponWheelHighlightColor.b)
	this.highlightDown:SetWidth(256)
	this.highlightDown:SetHeight(256)
	this.highlightDown:Hide()
	
	this.iconCenterFrame = CreateFrame("Frame", nil, this)
	this.iconCenterFrame:SetPoint("CENTER", this, "CENTER")
	this.iconCenterFrame:SetWidth(48)
	this.iconCenterFrame:SetHeight(48)
	
	this.iconCenter = this:CreateTexture(nil, "BORDER")
	this.iconCenter:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	this.iconCenter:SetPoint("CENTER", this, "CENTER")
	this.iconCenter:SetWidth(48)
	this.iconCenter:SetHeight(48)
	this.iconCenter:Show()
	
	this.iconLeftFrame = CreateFrame("Frame", nil, this)
	this.iconLeftFrame:SetPoint("CENTER", this, "CENTER", -58, 0)
	this.iconLeftFrame:SetWidth(48)
	this.iconLeftFrame:SetHeight(48)
	
	this.iconLeft = this:CreateTexture(nil, "BORDER")
	this.iconLeft:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	this.iconLeft:SetPoint("CENTER", this, "CENTER", -58, 0)
	this.iconLeft:SetWidth(32)
	this.iconLeft:SetHeight(32)
	this.iconLeft:Show()
	
	this.iconRightFrame = CreateFrame("Frame", nil, this)
	this.iconRightFrame:SetPoint("CENTER", this, "CENTER", 58, 0)
	this.iconRightFrame:SetWidth(48)
	this.iconRightFrame:SetHeight(48)
	
	this.iconRight = this:CreateTexture(nil, "BORDER")
	this.iconRight:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	this.iconRight:SetPoint("CENTER", this, "CENTER", 58, 0)
	this.iconRight:SetWidth(32)
	this.iconRight:SetHeight(32)
	this.iconRight:Show()
	
	this.iconUpFrame = CreateFrame("Frame", nil, this)
	this.iconUpFrame:SetPoint("CENTER", this, "CENTER", 0, 58)
	this.iconUpFrame:SetWidth(48)
	this.iconUpFrame:SetHeight(48)
	
	this.iconUp = this:CreateTexture(nil, "BORDER")
	this.iconUp:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	this.iconUp:SetPoint("CENTER", this, "CENTER", 0, 58)
	this.iconUp:SetWidth(32)
	this.iconUp:SetHeight(32)
	this.iconUp:Show()	
	
	this.iconDownFrame = CreateFrame("Frame", nil, this)
	this.iconDownFrame:SetPoint("CENTER", this, "CENTER", 0, -58)
	this.iconDownFrame:SetWidth(48)
	this.iconDownFrame:SetHeight(48)
	
	this.iconDown = this:CreateTexture(nil, "BORDER")
	this.iconDown:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
	this.iconDown:SetPoint("CENTER", this, "CENTER", 0, -58)
	this.iconDown:SetWidth(32)
	this.iconDown:SetHeight(32)
	this.iconDown:Show()	
end

function WeaponWheelInitializeConfig()
	WeaponWheelShowDelay = 0.15
	WeaponWheelMaxAlpha = 0.3
	WeaponWheelHighlightColor = { r=0.6, g=0.4, b=0.4 }
end

function WeaponWheelInitializeProfile()
	WeaponWheelActions = {}
	WeaponWheelActions[1] = {}
	WeaponWheelActions[1][1] = ""
	WeaponWheelActions[1][2] = ""
	WeaponWheelActions[1][3] = ""
	WeaponWheelActions[1][4] = ""
	WeaponWheelActions[1][5] = ""
	WeaponWheelActions[2] = {}
	WeaponWheelActions[2][1] = ""
	WeaponWheelActions[2][2] = ""
	WeaponWheelActions[2][3] = ""
	WeaponWheelActions[2][4] = ""
	WeaponWheelActions[2][5] = ""
	WeaponWheelActions[3] = {}
	WeaponWheelActions[3][1] = ""
	WeaponWheelActions[3][2] = ""
	WeaponWheelActions[3][3] = ""
	WeaponWheelActions[3][4] = ""
	WeaponWheelActions[3][5] = ""
	WeaponWheelActions[4] = {}
	WeaponWheelActions[4][1] = ""
	WeaponWheelActions[4][2] = ""
	WeaponWheelActions[4][3] = ""
	WeaponWheelActions[4][4] = ""
	WeaponWheelActions[4][5] = ""
	
	WeaponWheelIcons = {}
	WeaponWheelIcons[1] = {}
	WeaponWheelIcons[1][1] = ""
	WeaponWheelIcons[1][2] = ""
	WeaponWheelIcons[1][3] = ""
	WeaponWheelIcons[1][4] = ""
	WeaponWheelIcons[1][5] = ""
	WeaponWheelIcons[2] = {} 
	WeaponWheelIcons[2][1] = ""
	WeaponWheelIcons[2][2] = ""
	WeaponWheelIcons[2][3] = ""
	WeaponWheelIcons[2][4] = ""
	WeaponWheelIcons[2][5] = ""
	WeaponWheelIcons[3] = {} 
	WeaponWheelIcons[3][1] = ""
	WeaponWheelIcons[3][2] = ""
	WeaponWheelIcons[3][3] = ""
	WeaponWheelIcons[3][4] = ""
	WeaponWheelIcons[3][5] = ""
	WeaponWheelIcons[4] = {} 
	WeaponWheelIcons[4][1] = ""
	WeaponWheelIcons[4][2] = ""
	WeaponWheelIcons[4][3] = ""
	WeaponWheelIcons[4][4] = ""
	WeaponWheelIcons[4][5] = ""
end

function MouseDirectionToWheel(frame)
	local mouseX, mouseY = GetCursorPosition()
	local frameX = clickpos[frame:GetID()].x
	local frameY = clickpos[frame:GetID()].y
	
	local deltaX = mouseX - frameX
    local deltaY = mouseY - frameY

	if deltaX*deltaX + deltaY*deltaY < 4096 * WeaponWheelScale * WeaponWheelScale then
		return 5
	end

    local angle = math.atan2(deltaY, deltaX)
    local angle_deg = math.deg(angle)
	if angle_deg < 45 and angle_deg > -45 then
        return 2
    elseif angle_deg > 45 and angle_deg < 135 then
        return 1
    elseif angle_deg < -45 and angle_deg > -135 then
        return 3
    else
        return 4
    end
	return 5
end
