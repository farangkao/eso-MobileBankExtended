<<<<<<< HEAD
--	MobileBank Extended v1.4g
=======
--	MobileBank Extended v1.2
>>>>>>> origin/master
----------------------------
--  @farangkao
----------------------------

-- ZeroBane Studio Testing Setup
if ESOAddonDev then
  print("We are running inside ZeroBrane Studio Environment")
  ESOAddonDev.ShowCreateControl = true
  ESOAddonDev:GetXML([[MobileBank\MobileBank.xml]]) 
  -- Fake creation of Elements because XML Controls for Virtual Sub-Elements not working yet...
    for i=1,11,1 do
	    	
			WINDOW_MANAGER:CreateControl("MBUI_Row"..i.."ButtonIcon",MBUI,CT_CONTROL)
      WINDOW_MANAGER:CreateControl("MBUI_Row"..i.."ButtonStackCount",MBUI,CT_CONTROL)
      WINDOW_MANAGER:CreateControl("MBUI_Row"..i.."Name",MBUI,CT_CONTROL)
      WINDOW_MANAGER:CreateControl("MBUI_Row"..i.."StatValue",MBUI,CT_CONTROL)
      WINDOW_MANAGER:CreateControl("MBUI_Row"..i.."SellPrice",MBUI,CT_CONTROL)
      
    end
<<<<<<< HEAD
    for i=1,8 do
      _G["MBUI_ContainerTitleInventButton" .. i] = {
        SetNormalFontColor = function() end,
        SetParent = function() end,
        SetFont = function() end,
        SetDimensions = function() end,
        SetAnchor = function() end,
        SetMouseOverFontColor = function() end,
        SetHandler = function() end,
        SetHidden = function() end,
        GetWidth = function() return 100 end,
        }
    end
        
=======
    
>>>>>>> origin/master
    MBUI_ContainerTitleSwitchAll.SetState = function (self,state) end
    MBUI_ContainerTitleSwitchInv.SetState = function (self,state) end
    MBUI_ContainerTitleSwitchBank.SetState = function (self,state) end
    MBUI_ContainerTitleSwitchGuild.SetState = function (self,state) end
    MBUI_ContainerTitleSwitchRecipes.SetState = function (self,state) end
    MBUI_ContainerTitleSwitchLoot.SetState = function (self,state) end
    MBUI_ContainerTitleName.SetState = function (self,state) end
<<<<<<< HEAD
    MBUI_ContainerTitleToggleEquipped.SetState = function(self,state) end
    ZO_CurrencyControl_FormatCurrency = function (test) return "currency" end
    MBUI_ContainerTitleFilterAll.SetState = function(self,state) end
    MBUI_ContainerTitleFilterSubFilter1.SetState = function(self,state) end
    
    ItemTooltip = {}
    ItemTooltip.SetBagItem = 0
=======
    ZO_CurrencyControl_FormatCurrency = function (test) return "currency" end
>>>>>>> origin/master
end
--------------------------------

local LAM = {}

MB = {}

<<<<<<< HEAD
MB.version="1.4g"
=======
MB.version="1.2"
>>>>>>> origin/master

MB.dataDefaultItems = {
	Guilds={},
	Chars={}
}

for i=1,GetNumGuilds() do
	MB.dataDefaultItems.Guilds[GetGuildName(i)]={}
end 

MB.dataDefaultParams = {
	MBUI_Menu = {10,10},
	MBUI_Container = {500,120},
	hidden = true, -- With new Key and Options menu not necessairy to show Menu anymore.
}

MB.dataDefaultGlobal = {
	InventoryToolTips = true, -- With new Key and Options menu not necessairy to show Menu anymore.
  ShowEquipped = true,
  SelectedAccount = "",
  IgnoreGuild1 = true,
  IgnoreGuild2 = true,
  IgnoreGuild3 = true,
  IgnoreGuild4 = true,
  IgnoreGuild5 = true,
  IgnoreGuildIngredients1 = true,
  IgnoreGuildIngredients2 = true,
  IgnoreGuildIngredients3 = true,
  IgnoreGuildIngredients4 = true,
  IgnoreGuildIngredients5 = true
}

MB.UI_Movable=false
MB.AddonReady=false
MB.TempData={}
MB.GCountOnUpdateTimer=0
<<<<<<< HEAD
MB.Debug=false
=======
MB.GuildBankIdToPrepare=1
MB.Debug=true
>>>>>>> origin/master
MB.PreviousButtonClicked=nil
MB.LastButtonClicked=nil
MB.CharsName=nil
MB.GuildsName=nil
MB.FilterChildrens=nil
MB.CurrentFilterType="All"
MB.CurrentSubFilter="1"
MB.LastCommandUI=nil
MB.LastIdToPrepareInvent=1
MB.LastIdToPrepareGuild=1
MB.CursorWasActive=false
MB.Label="Bank"
MB.SearchText=""
MB.Loot = {}
MB.thisCharName=GetUnitName("player")
<<<<<<< HEAD
MB.thisAcocuntName=GetDisplayName()
=======
>>>>>>> origin/master
MB.CurrentChar=MB.thisCharName

local function debug(text)
	if MB.Debug then
		d(text)
	end
end

function MB.OnLoad(eventCode, addOnName)
	if (addOnName ~= "MobileBank" ) then return end

	--добавляем команду
	SLASH_COMMANDS["/mb"] = MB.commandHandler

	--Регистрация эвентов
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_OPEN_BANK, MB.PL_Opened)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_CLOSE_BANK, MB.PL_Closed)
	-- EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_OPEN_GUILD_BANK, MB.GB_Opened)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_GUILD_BANK_ITEMS_READY, MB.GB_Ready)
	
	

	-- Registering Events 

	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_LOOT_RECEIVED, MB.LootRecieved)
<<<<<<< HEAD
  EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, MB.SingleSlotUpdate)
=======
>>>>>>> origin/master
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_CLOSE_BANK, MB.SavePlayerInvent)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_CLOSE_STORE,  MB.SavePlayerInvent)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_MONEY_UPDATE , MB.SavePlayerInvent)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_CLOSE_GUILD_BANK, MB.SavePlayerInvent)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_END_CRAFTING_STATION_INTERACT, MB.SavePlayerInvent)
	EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_MAIL_CLOSE_MAILBOX , MB.SavePlayerInvent)

	--Загрузка сохраненных переменных
	MB.items= ZO_SavedVars:NewAccountWide( "MB_SavedVars" , 3, "Items" , MB.dataDefaultItems, nil )
	-- New for Gold Tracking
<<<<<<< HEAD
	MB.gold = ZO_SavedVars:NewAccountWide( "MB_SavedVars", 3, "Gold", MB.dataDefaultItems, nil )
	-- New for Aliases
	MB.aliases = ZO_SavedVars:NewAccountWide( "MB_SavedVars", 3,"Aliases", MB.dataDefaultItems,nil)
	
	MB.params= ZO_SavedVars:New( "MB_SavedVars" , 3, "Params" , MB.dataDefaultParams, nil )
	MB.global= ZO_SavedVars:NewAccountWide( "MB_SavedVars", 3, "Global" , MB.dataDefaultGlobal, nil )
  
=======
	MB.gold = ZO_SavedVars:NewAccountWide("MB_SavedVars", 3, "Gold", MB.dataDefaultItems, nil )
	-- New for Aliases
	MB.aliases = ZO_SavedVars:NewAccountWide("MB_SavedVars", 3,"Aliases", MB.dataDefaultItems,nil)
	
	MB.params= ZO_SavedVars:New( "MB_SavedVars" , 3, "Params" , MB.dataDefaultParams, nil )
	
>>>>>>> origin/master
  debug("Item Version: " .. tostring(MB.items.version))
  
  debug("API Version: " .. tostring(APIVersion))
  
<<<<<<< HEAD
  if not MB.thisAccountName or MB.thisAccountName == "" then
    if GetNumGuilds() > 0 then        
      MB.thisAccountName, _, _, _, _ =  GetGuildMemberInfo(GetGuildId(1),GetPlayerGuildMemberIndex(GetGuildId(1)))      
    else
      MB.thisAccountName = "@" .. GetCVar("AccountName")    
    end  
  end
  
  if not MB.global.SelectedAccount or MB.global.SelectedAccount == "" then
    MB.global.SelectedAccount = MB.thisAccountName
  end
  
=======
>>>>>>> origin/master
  MBUI_ContainerTitleName:SetState(1)

	MB.items.Chars[MB.thisCharName]={}
	-- New for Gold Tracking
	MB.gold.Chars[MB.thisCharName]={}
	-- New for Aliases
	
	if MB.aliases.Chars[MB.thisCharName] then
		-- We already have Alias entry...
    if not MB.thisAccountName or MB.thisAccountName == "" then -- if empty try to get from last time...
      MB.thisAccountName = MB.aliases.Chars[MB.thisCharName].Account
    else
      MB.aliases.Chars[MB.thisCharName].Account = MB.thisAccountName
    end
	else
		local maxid = 0
		
		for k,v in pairs(MB.aliases.Chars) do
			if v  and v["ID"] > maxid then
				maxid = v["ID"]
			end
		end
	
		if maxid > 0 and maxid < 8 then
			maxid = maxid + 1
		elseif maxid == 0 then
			maxid = 1
		else
			debug("Problem with Max. ID for Character")
		end

		MB.aliases.Chars[MB.thisCharName]={ 
			ID= maxid,
<<<<<<< HEAD
			Alias = MB.thisCharName,
      Account = MB.thisAccountName
=======
			Alias = MB.thisCharName
>>>>>>> origin/master
		}
	end
  
  for i=1,GetNumGuilds() do
    local guild = GetGuildName(i)
    if MB.aliases.Guilds[guild] and MB.aliases.Guilds[guild].ID then
      -- We already have Alias entry...
    else
      local maxid = 0
      
      for k,v in pairs(MB.aliases.Guilds) do
        if v and v["ID"] and v["ID"] > maxid then
          maxid = v["ID"]
        end
      end
    
      if maxid > 0 and maxid < 5 then
        maxid = maxid + 1
      elseif maxid == 0 then
        maxid = 1
      else
        d("Problem with Max. ID for Guild")
      end

      MB.aliases.Guilds[guild]={ 
        ID= maxid,
        Alias =  guild
      }
    end
  end	

	MB.CharsName={}
	for k,v in pairs(MB.items.Chars) do
		MB.CharsName[#MB.CharsName+1]=k
	end

	MB.GuildsName={}
	for k,v in pairs(MB.items.Guilds) do
	    if k ~= "" then
			MB.GuildsName[#MB.GuildsName+1]=k
		end
	end

	-- Save current Player Inventory
	MB.SavePlayerInvent()

	--Инициализация графического интерфейся
	MB_UI = WINDOW_MANAGER:GetControlByName("MBUI")

	-- Создаем меню
	MB.CreateMenu()
	-- Создаем банк
	MB.CreateBank()

	MB.CreateMBSearchBox()
    -- Add Settings menu via LibAddonMenu
	
	MB.options.SetData()
<<<<<<< HEAD
  MB.HookTooltips()
  
  LAM = LibStub("LibAddonMenu-2.0")
	MB.OptionsPanel = LAM:RegisterAddonPanel("MobileBankExtended", MB.options.panelData)
	LAM:RegisterOptionControls("MobileBankExtended", MB.options.optionsTable)
  if MB.global.ShowEquipped then
    MBUI_ContainerTitleToggleEquipped:SetState(1)
  else
    MBUI_ContainerTitleToggleEquipped:SetState(0)
  end
  MBUI_ContainerTitleFilterAll:SetState(1)
  MBUI_ContainerTitleFilterSubFilter1:SetState(1)  
=======
	
  LAM = LibStub("LibAddonMenu-2.0")
	MB.OptionsPanel = LAM:RegisterAddonPanel("MobileBankExtended", MB.options.panelData)
	LAM:RegisterOptionControls("MobileBankExtended", MB.options.optionsTable)
	
>>>>>>> origin/master
	MB.AddonReady=true
end


function MB.CreateMenu()
	MB_UI.Menu=WINDOW_MANAGER:CreateControl("MBUI_Menu",MBUI,CT_CONTROL)
	MB_UI.Menu.BG = WINDOW_MANAGER:CreateControl("MBUI_Menu_BG",MBUI_Menu,CT_BACKDROP)
	MB_UI.Menu.Title = WINDOW_MANAGER:CreateControl("MBUI_Menu_Title",MBUI_Menu,CT_LABEL)
	MB_UI.Menu.Button={}
	MB_UI.Menu.Button.Guild = WINDOW_MANAGER:CreateControl("MBUI_Menu_Button_Guild",MBUI_Menu,CT_BUTTON)
	MB_UI.Menu.Button.Bank = WINDOW_MANAGER:CreateControl("MBUI_Menu_Button_Bank",MBUI_Menu,CT_BUTTON)
	MB_UI.Menu.Button.Invent = WINDOW_MANAGER:CreateControl("MBUI_Menu_Button_Invent",MBUI_Menu,CT_BUTTON)
	-- MB_UI.Menu.Button.Move = WINDOW_MANAGER:CreateControl("MBUI_Menu_Button_Move",MBUI_Menu,CT_BUTTON)

	--Обработчики событий

    -- Клик по гильдии
    MB_UI.Menu.Button.Guild:SetHandler("OnClicked" , function(self)
    	local bool = not(MBUI_Container:IsHidden())
    	MB.PreviousButtonClicked=MB.LastButtonClicked
		MB.LastButtonClicked="Guild"

    	MB.CurrentLastValue=11

		MB.PrepareBankValues("Guild",1)
		-- MB.FillBank(MB.CurrentLastValue,MB.BankValueTable)
		MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
    	MB.HideContainer(bool)
    end )

    -- Клик по банку
    MB_UI.Menu.Button.Bank:SetHandler( "OnClicked" , function(self)
    	local bool = not(MBUI_Container:IsHidden())
    	MB.PreviousButtonClicked=MB.LastButtonClicked
		MB.LastButtonClicked="Bank"

    	MB.CurrentLastValue=11

		MB.PrepareBankValues("Bank")
    	-- MB.FillBank(MB.CurrentLastValue,MB.BankValueTable)
    	MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
    	MB.HideContainer(bool)
    end )

    -- Клик по инвентарю
    MB_UI.Menu.Button.Invent:SetHandler( "OnClicked" , function(self)
    	local bool = not(MBUI_Container:IsHidden())
    	MB.PreviousButtonClicked=MB.LastButtonClicked
		MB.LastButtonClicked="Invent"

    	MB.CurrentLastValue=11

		MB.PrepareBankValues("Invent",MB.ChangeCharacterDisplay())
    	-- MB.FillBank(MB.CurrentLastValue,MB.BankValueTable)
    	MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
    	MB.HideContainer(bool)
    end )


    MBUI_Menu:SetHandler("OnMouseUp" , function(self) MB.MouseUp(self) end)
    
    if MBUI_Container then      
      MBUI_Container:SetHandler("OnMouseUp" , function(self) MB.MouseUp(self) end)
    else
       print("ERROR MBUI_Container is empty!")
    end

	--Настройки меню
	MB_UI.Menu:SetAnchor(TOPLEFT,MBUI,TOPLEFT,MB.params.MBUI_Menu[1],MB.params.MBUI_Menu[2])
	MB_UI.Menu:SetDimensions(200,45)
	MB_UI.Menu:SetMouseEnabled(true)
	MB_UI.Menu:SetMovable(true)

	--Фон
	MB_UI.Menu.BG:SetAnchor(CENTER,MBUI_Menu,CENTER,0,0)
	MB_UI.Menu.BG:SetDimensions(200,40)
	MB_UI.Menu.BG:SetCenterColor(0,0,0,1)
	MB_UI.Menu.BG:SetEdgeColor(0,0,0,0)
	MB_UI.Menu.BG:SetAlpha(0.5)

	--Заголовок
	MB_UI.Menu.Title:SetAnchor(CENTER,MBUI_Menu,TOP,0,13)
	MB_UI.Menu.Title:SetFont("ZoFontGame" )
	MB_UI.Menu.Title:SetColor(255,255,255,1.5)
	MB_UI.Menu.Title:SetText( "|cff8000Mobile Bank|" )

	-- Кнопка "Гильдия"
	MB_UI.Menu.Button.Guild:SetAnchor(BOTTOMLEFT,MBUI_Menu,BOTTOMLEFT,0,0)
	MB_UI.Menu.Button.Guild:SetText("[Guild]")
	MB_UI.Menu.Button.Guild:SetDimensions(70,25)
	MB_UI.Menu.Button.Guild:SetFont("ZoFontGameBold")
	MB_UI.Menu.Button.Guild:SetNormalFontColor(0,255,255,.7)
	MB_UI.Menu.Button.Guild:SetMouseOverFontColor(0.8,0.4,0,1)

	-- Кнопка "Банк"
	MB_UI.Menu.Button.Bank:SetAnchor(BOTTOM,MBUI_Menu,BOTTOM,0,0)
	MB_UI.Menu.Button.Bank:SetText("[Bank]")
	MB_UI.Menu.Button.Bank:SetDimensions(70,25)
	MB_UI.Menu.Button.Bank:SetFont("ZoFontGameBold")
	MB_UI.Menu.Button.Bank:SetNormalFontColor(0,255,255,.7)
	MB_UI.Menu.Button.Bank:SetMouseOverFontColor(0.8,0.4,0,1)

	-- Кнопка "Инвентарь"
	MB_UI.Menu.Button.Invent:SetAnchor(BOTTOMRIGHT,MBUI_Menu,BOTTOMRIGHT,0,0)
	MB_UI.Menu.Button.Invent:SetText("[Invent]")
	MB_UI.Menu.Button.Invent:SetDimensions(70,25)
	MB_UI.Menu.Button.Invent:SetFont("ZoFontGameBold")
	MB_UI.Menu.Button.Invent:SetNormalFontColor(0,255,255,.7)
	MB_UI.Menu.Button.Invent:SetMouseOverFontColor(0.8,0.4,0,1)
end

function MB.ChangeCharacterDisplay(init,IdToPrepare)
    -- we have 1 to 8 slots, they need to be reordered and compared with the Account...
    -- Update Titles with Aliases	
    
    local inv1 = 0
    local inv2 = 0
    
    local orderTable = {}
    local maxorder = 0
    local nextXstep = 0
    
    debug("Selected Account: " .. tostring(MB.global.SelectedAccount))
    
    for i=1, #MB.CharsName do		
      local order = 0
      local account = nil
      if MB.aliases and MB.aliases.Chars then
        for k,v in pairs(MB.aliases.Chars) do        
          if k == MB.CharsName[i] then
            debug("Char @Account: " .. k .. " " .. tostring(v.Account))
            
            if not v.Account or v.Account == "" or v.Account:lower() == MB.global.SelectedAccount:lower()  then
              if v.Order then
                order = v.Order
              elseif v.ID and v.ID < 9 then
                order = v.ID
              end             
              if v.Account then
                account = v.Account
              else
                account = MB.thisAccountName
              end
              debug("here")
            end
          end
        end		
      end
      if account then -- and account ~= "" then
        if order> maxorder then maxorder = order end      
        debug("Chars: " .. MB.CharsName[i] .. " " .. tostring(order))
        orderTable[#orderTable+1] = order		
      end
    end
          
    -- Set all 0 to the next higher number
    for i=1,#orderTable do
      if orderTable[i]  == 0 then 
        maxorder = maxorder + 1
        orderTable[i] = maxorder
      end
    end
    
    debug("OrderTable: " .. tostring(#orderTable))
    
    for i,k in ipairs(orderTable) do
        debug("order: " .. tostring(i) .. ". " .. tostring(k))
    end
    
    if init then
      for i=1,8 do 
        if _G["MBUI_ContainerTitleInventButton" .. i] then
          _G["MBUI_ContainerTitleInventButton"..i]:SetHidden(true)
        end
      end
    end
             
    local SortedOrder = {}
    for k,v in pairs(orderTable) do
      SortedOrder[v] = k
    end
    
    debug("Sort Order: " ..tostring(#SortedOrder))
    local c=1
    for k=1,8 do      
      if SortedOrder[k] then
        local originalcharname=tostring(MB.CharsName[SortedOrder[k]])			
        local charname = originalcharname
        debug(tostring(k) .. ". " .. charname)
        -- Support for Alias Names
        if MB.aliases.Chars[charname] then
            local alias = MB.aliases.Chars[charname].Alias
            if alias ~= "" then
              charname = alias
            end
        end

        if k < 9 then			
          
          if originalcharname == MB.CurrentChar then
            inv1 = k
          end
          
          if originalcharname == GetUnitName("player") then
            inv2 = k
          end
          
          if init then
              if not _G["MBUI_ContainerTitleInventButton" .. k] then
                WINDOW_MANAGER:CreateControl("MBUI_ContainerTitleInventButton"..k,MBUI_ContainerTitle,CT_BUTTON)
              end
              _G["MBUI_ContainerTitleInventButton"..k]:SetHidden(false)
              _G["MBUI_ContainerTitleInventButton"..k]:SetParent(MBUI_ContainerTitleInventButtons)
              _G["MBUI_ContainerTitleInventButton"..k]:SetFont("ZoFontGame" )
              nextXstep=(MBUI_Container:GetWidth()/#orderTable*c)
              _G["MBUI_ContainerTitleInventButton"..k]:SetDimensions(MBUI_Container:GetWidth()/#orderTable,20)
              _G["MBUI_ContainerTitleInventButton"..k]:SetAnchor(TOP,MBUI_ContainerTitleInventButtons,TOPLEFT,nextXstep-_G["MBUI_ContainerTitleInventButton"..k]:GetWidth()/2,0)				          _G["MBUI_ContainerTitleInventButton"..k]:SetNormalFontColor(0,255,255,.7)
              _G["MBUI_ContainerTitleInventButton"..k]:SetMouseOverFontColor(0.8,0.4,0,1)
              _G["MBUI_ContainerTitleInventButton"..k].CharacterName = originalcharname
              _G["MBUI_ContainerTitleInventButton"..k]:SetHandler( "OnClicked" , function(self)
                MB.PrepareBankValues("Invent",k)
                MB.SortPreparedValues()
                MB.FilterBank(11,MB.CurrentFilterType,MB.SearchText)	
              end)                
            
            c = c+1
          end
          if _G["MBUI_ContainerTitleInventButton" .. k] then
            if charname then
              _G["MBUI_ContainerTitleInventButton"..k]:SetText("["..charname.."]")				
            end
            
            if  _G["MBUI_ContainerTitleInventButton".. k] then -- ZBS compatibility
              if k == IdToPrepare then
                _G["MBUI_ContainerTitleInventButton".. k]:SetNormalFontColor(255,255,0,1)
              else
                _G["MBUI_ContainerTitleInventButton".. k]:SetNormalFontColor(0,255,255,0.7)
              end
            end                
          else
            debug("Not found: " .. k)
          end
        end
      else
        debug("Order not found: " .. k)
      end
    end
    
    if inv1 > 0 then 
      return inv1
    elseif inv2 > 0 then
      return inv2
    else 
      return 1
    end
end

function MB.UpdateBankAliases()
	-- Update Titles with Aliases	
  --[[
	local orderTable = {}
	local maxorder = 0
	for i=1, #MB.CharsName do		
		local order = 0
		if MB.aliases and MB.aliases.Chars then
			for k,v in pairs(MB.aliases.Chars) do
				if k == MB.CharsName[i] then
					if v.Order then
						order = v.Order
					else
						order = v.ID
					end
				end
			end		
		end
		if order> maxorder then maxorder = order end
		orderTable[i] = order		
	end
	
	-- Set all 0 to the next higher number
	for i=1,#orderTable do
		if orderTable[i]  == 0 then 
			maxorder = maxorder + 1
			orderTable[i] = maxorder
		end
	end
	
	
  for i=1,#MB.CharsName do

		for k=1,#orderTable do
			if orderTable[k] == i then
			
				local charname=tostring(MB.CharsName[k])			
				-- Support for Alias Names
				if MB.aliases.Chars[charname] then
						local alias = MB.aliases.Chars[charname].Alias
						if alias ~= "" then
							charname = alias
						end
				end
                      
				if k < 9 then				
            _G["MBUI_ContainerTitleInventButton"..k]:SetText("["..charname.."]")				
        end
			end
		end
	end
  --]]
  
  MB.ChangeCharacterDisplay()
  
  -- Update Guilds
  
  local orderTable = {}
	local maxorder = 0
	for i=1, #MB.GuildsName do		
		local order = 0
		if MB.aliases and MB.aliases.Guilds then
			for k,v in pairs(MB.aliases.Guilds) do
				if k == MB.GuildsName[i] then
					if v.Order then
						order = v.Order
					else
						order = v.ID
					end
				end
			end		
		end
		if order> maxorder then maxorder = order end
		orderTable[i] = order		
	end
	
	-- Set all 0 to the next higher number
	for i=1,#orderTable do
		if orderTable[i]  == 0 then 
			maxorder = maxorder + 1
			orderTable[i] = maxorder
		end
	end
	
	
  for i=1,#MB.GuildsName do

		for k=1,#orderTable do
			if orderTable[k] == i then
			
				local guildname=tostring(MB.GuildsName[k])			
				-- Support for Alias Names
				if MB.aliases.Guilds[guildname] then
						local alias = MB.aliases.Guilds[guildname].Alias
						if alias ~= "" then
							guildname = alias
						end
				end
											
<<<<<<< HEAD
=======
				_G["MBUI_ContainerTitleInventButton"..k]:SetText("["..charname.."]")				
			end
		end
	end
  
  -- Update Guilds
  
  orderTable = {}
	maxorder = 0
	for i=1, #MB.GuildsName do		
		local order = 0
		if MB.aliases and MB.aliases.Guilds then
			for k,v in pairs(MB.aliases.Guilds) do
				if k == MB.GuildsName[i] then
					if v.Order then
						order = v.Order
					else
						order = v.ID
					end
				end
			end		
		end
		if order> maxorder then maxorder = order end
		orderTable[i] = order		
	end
	
	-- Set all 0 to the next higher number
	for i=1,#orderTable do
		if orderTable[i]  == 0 then 
			maxorder = maxorder + 1
			orderTable[i] = maxorder
		end
	end
	
	
  for i=1,#MB.GuildsName do

		for k=1,#orderTable do
			if orderTable[k] == i then
			
				local guildname=tostring(MB.GuildsName[k])			
				-- Support for Alias Names
				if MB.aliases.Chars[charname] then
						local alias = MB.aliases.Guilds[guildname].Alias
						if alias ~= "" then
							guildname = alias
						end
				end
											
>>>>>>> origin/master
				_G["MBUI_ContainerTitleGuildButton"..k]:SetText("["..guildname.."]")				
			end
		end
	end

end

function MB.CreateBank()
	local OldAnchor=false

	-- Настройки контейнера
	MBUI_Container:SetAnchor(TOPLEFT,GuiRoot,TOPLEFT,MB.params.MBUI_Container[1],MB.params.MBUI_Container[2])
	MBUI_Container:SetMovable(true)

	-- Правим Слайдер
    MBUI_ContainerSlider:SetValue(11)


    -- Создаем кнопки для переключения между гильдбанками
	local nextXstep=0
  
  local orderTable = {}
  local maxorder = 0
  for i=1, #MB.GuildsName do		
    local order = 0
    if MB.aliases and MB.aliases.Guilds then
      for k,v in pairs(MB.aliases.Guilds) do
        if k == MB.GuildsName[i] then
          if v.Order then
            order = v.Order
          else
            order = v.ID
          end
        end
      end		
    end    
    if order and order> maxorder then maxorder = order end
    orderTable[i] = order		
  end
    
  -- Set all 0 to the next higher number
  for i=1,#orderTable do
    if orderTable[i]  == 0 then 
      maxorder = maxorder + 1
      orderTable[i] = maxorder
    end
  end

  
  for i=1,#MB.GuildsName do    
    for k=1,#orderTable do
			if orderTable[k] == i then
			
    	  local guildname=tostring(MB.GuildsName[k])
      
        -- Support for Alias Names
        if MB.aliases.Guilds[guildname] then
            local alias = MB.aliases.Guilds[guildname].Alias
            if alias ~= "" then
              guildname = alias
            end
        end

        if guildname and guildname ~= "" then
          WINDOW_MANAGER:CreateControl("MBUI_ContainerTitleGuildButton"..k,MBUI_ContainerTitle,CT_BUTTON)
          _G["MBUI_ContainerTitleGuildButton"..k]:SetParent(MBUI_ContainerTitleGuildButtons)
          _G["MBUI_ContainerTitleGuildButton"..k]:SetFont("ZoFontGame" )
          nextXstep=(MBUI_Container:GetWidth()/#MB.GuildsName*k)
          _G["MBUI_ContainerTitleGuildButton"..k]:SetDimensions(MBUI_Container:GetWidth()/#MB.GuildsName,20)
          -- Делаем поправку на ширину самой кнопки
          _G["MBUI_ContainerTitleGuildButton"..k]:SetAnchor(TOP,MBUI_ContainerTitleGuildButton,TOPLEFT,nextXstep-_G["MBUI_ContainerTitleGuildButton"..k]:GetWidth()/2,0)
          _G["MBUI_ContainerTitleGuildButton"..k]:SetText("["..guildname.."]")
          _G["MBUI_ContainerTitleGuildButton"..k]:SetNormalFontColor(0,255,255,.7)
          _G["MBUI_ContainerTitleGuildButton"..k]:SetMouseOverFontColor(0.8,0.4,0,1)

          _G["MBUI_ContainerTitleGuildButton"..k]:SetHandler( "OnClicked" , function(self)
            MB.PrepareBankValues("Guild",k)
            MB.SortPreparedValues()
            -- MB.FillBank(11,MB.BankValueTable)
            MB.FilterBank(11,MB.CurrentFilterType,MB.SearchText)
           end)
         end
        end
		 end
	end

  MB.ChangeCharacterDisplay(true)  -- Create Characters for Inventory
  
    -- Создаем кнопки для переключения между Игроками
<<<<<<< HEAD
    --[[
=======
>>>>>>> origin/master
	nextXstep=0
	orderTable = {}
	maxorder = 0
	for i=1, #MB.CharsName do		
		local order = 0
		if MB.aliases and MB.aliases.Chars then
			for k,v in pairs(MB.aliases.Chars) do
				if k == MB.CharsName[i] then
					if v.Order then
						order = v.Order
					else
						order = v.ID
					end
				end
			end		
		end    
    if order and order> maxorder then maxorder = order end
		orderTable[i] = order		
	end
	
	-- Set all 0 to the next higher number
	for i=1,#orderTable do
		if orderTable[i]  == 0 then 
			maxorder = maxorder + 1
			orderTable[i] = maxorder
		end
	end
  
	
   -- MBUI_ContainerTitleInventButtons:SetDimensions(MBUI_Container:GetWidth(),80)
   -- MBUI_ContainerTitleInventButtons:SetAnchor(TOP,MBUI_Container,TOPLEFT,0,50)
	
    for i=1,#MB.CharsName do

		for k=1,#orderTable do
			if orderTable[k] == i then
			
<<<<<<< HEAD
        if k < 9 then
          local charname=tostring(MB.CharsName[k])			
          -- Support for Alias Names
          if MB.aliases.Chars[charname] then
              local alias = MB.aliases.Chars[charname].Alias
              if alias ~= "" then
                charname = alias
              end
          end
          
          WINDOW_MANAGER:CreateControl("MBUI_ContainerTitleInventButton"..k,MBUI_ContainerTitle,CT_BUTTON)
          _G["MBUI_ContainerTitleInventButton"..k]:SetParent(MBUI_ContainerTitleInventButtons)
          _G["MBUI_ContainerTitleInventButton"..k]:SetFont("ZoFontGame" )
          nextXstep=(MBUI_Container:GetWidth()/#MB.CharsName*i)
          _G["MBUI_ContainerTitleInventButton"..k]:SetDimensions(MBUI_Container:GetWidth()/#MB.CharsName,20)
          -- Делаем поправку на ширину самой кнопки
          _G["MBUI_ContainerTitleInventButton"..k]:SetText("["..charname.."]")
          _G["MBUI_ContainerTitleInventButton"..k]:SetAnchor(TOP,MBUI_ContainerTitleInventButtons,TOPLEFT,nextXstep-_G["MBUI_ContainerTitleInventButton"..k]:GetWidth()/2,0)				
          _G["MBUI_ContainerTitleInventButton"..k]:SetNormalFontColor(0,255,255,.7)
          _G["MBUI_ContainerTitleInventButton"..k]:SetMouseOverFontColor(0.8,0.4,0,1)

          _G["MBUI_ContainerTitleInventButton"..k]:SetHandler( "OnClicked" , function(self)
            MB.PrepareBankValues("Invent",k)
            MB.SortPreparedValues()
            -- MB.FillBank(11,MB.BankValueTable)
            MB.FilterBank(11,MB.CurrentFilterType,MB.SearchText)	
            end)
        end
      end
=======
				local charname=tostring(MB.CharsName[k])			
				-- Support for Alias Names
				if MB.aliases.Chars[charname] then
						local alias = MB.aliases.Chars[charname].Alias
						if alias ~= "" then
							charname = alias
						end
				end
				
				WINDOW_MANAGER:CreateControl("MBUI_ContainerTitleInventButton"..k,MBUI_ContainerTitle,CT_BUTTON)
				_G["MBUI_ContainerTitleInventButton"..k]:SetParent(MBUI_ContainerTitleInventButtons)
				_G["MBUI_ContainerTitleInventButton"..k]:SetFont("ZoFontGame" )
				nextXstep=(MBUI_Container:GetWidth()/#MB.CharsName*i)
				_G["MBUI_ContainerTitleInventButton"..k]:SetDimensions(MBUI_Container:GetWidth()/#MB.CharsName,20)
				-- Делаем поправку на ширину самой кнопки
        _G["MBUI_ContainerTitleInventButton"..k]:SetText("["..charname.."]")
				_G["MBUI_ContainerTitleInventButton"..k]:SetAnchor(TOP,MBUI_ContainerTitleInventButtons,TOPLEFT,nextXstep-_G["MBUI_ContainerTitleInventButton"..k]:GetWidth()/2,0)				
				_G["MBUI_ContainerTitleInventButton"..k]:SetNormalFontColor(0,255,255,.7)
				_G["MBUI_ContainerTitleInventButton"..k]:SetMouseOverFontColor(0.8,0.4,0,1)

				_G["MBUI_ContainerTitleInventButton"..k]:SetHandler( "OnClicked" , function(self)
					MB.PrepareBankValues("Invent",k)
					MB.SortPreparedValues()
					-- MB.FillBank(11,MB.BankValueTable)
					MB.FilterBank(11,MB.CurrentFilterType,MB.SearchText)	
					end)
			end
>>>>>>> origin/master
		end
	end
  --]]

    -- Правим строки (созданы из xml)
	for i = 1, 11 do
	    local dynamicControl = CreateControlFromVirtual("MBUI_Row", MBUI_Container, "MBUI_TemplateRow",i)

	    -- Строка
	    local fromtop=150
	    _G["MBUI_Row"..i]:SetAnchor(TOP,MBUI_Container,TOP,0,fromtop+52*(i-1))
	    -- _G["MBUI_Row"..i]:SetDimensions (530,52)

	    -- Анимация
	    _G["MBUI_Row"..i.."IconTimeline"]=ANIMATION_MANAGER:CreateTimelineFromVirtual("MBUI_IconAnimation",_G["MBUI_Row"..i.."ButtonIcon"])
	    -- _G["MBUI_Row"..i.."CountTimeline"]=ANIMATION_MANAGER:CreateTimelineFromVirtual("MBUI_IconAnimation",_G["MBUI_Row"..i.."ButtonStackCount"])

	end
end

function MB.PrepareBankValues(PrepareType,IdToPrepare)
<<<<<<< HEAD
  MB.Label = PrepareType	
	MB.BankValueTable={}  
=======
  MB.Label = PrepareType
	MB.GuildBankIdToPrepare=GuildBankIdToPrepare
	MB.BankValueTable={}
>>>>>>> origin/master

  MBUI_ContainerTitleFilter:SetHidden(false)
  MBUI_ContainerTitleSwitchAll:SetState(0)
  MBUI_ContainerTitleSwitchBank:SetState(0)
  MBUI_ContainerTitleSwitchInv:SetState(0)
  MBUI_ContainerTitleSwitchGuild:SetState(0)
  MBUI_ContainerTitleSwitchRecipes:SetState(0)
  MBUI_ContainerTitleSwitchLoot:SetState(0)
<<<<<<< HEAD
  MBUI_ContainerTitleToggleEquipped:SetHidden(true)
  
  local recipes = false
=======
>>>>>>> origin/master
  
	if PrepareType=="Bank" then
		debug("Preparing Player values")
    MBUI_ContainerTitleSwitchBank:SetState(1)
		local bagIcon, bagSlots=GetBagInfo(BAG_BANK)
		MB.ItemCounter=0
		while (MB.ItemCounter < bagSlots) do
			if GetItemName(BAG_BANK,MB.ItemCounter)~="" then

				--Избавляемся от мусора при сохранении
				local name = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(BAG_BANK, MB.ItemCounter))
				local link = GetItemLink(BAG_BANK,MB.ItemCounter)
				local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(name).."|h")

				local stackCount = GetSlotStackSize(BAG_BANK,MB.ItemCounter)
				local statValue = GetItemStatValue(BAG_BANK,MB.ItemCounter)
				local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyle, quality,level = GetItemInfo(BAG_BANK,MB.ItemCounter)
				local ItemType=GetItemType(BAG_BANK,MB.ItemCounter)

<<<<<<< HEAD
        local _, _, _, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(link)
        -- local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
      
        local level = GetItemLevel(BAG_BANK,MB.ItemCounter)
        
        if statValue == 0 then          
            statValue = tonumber(level)
            if not statValue then
              statValue = 1
            end
=======
        local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
      
        -- local level = GetItemLevel(BAG_BANK,MB.ItemCounter)
        
        if statValue == 0 then
            statValue = level
>>>>>>> origin/master
        end
      
				MB.BankValueTable[#MB.BankValueTable+1]={
					["ItemLink"]=tostring(clearlink),
					["icon"] = tostring(icon),
					["ItemName"]=name, -- GetItemName(BAG_BANK, MB.ItemCounter), -- tostring(name),
<<<<<<< HEAD
          ["Level"] = tonumber(level),
=======
          ["Level"] = level,
>>>>>>> origin/master
					["stackCount"]=stackCount,
					["statValue"]=statValue,
					["sellPrice"] = sellPrice,
					["quality"] = quality,
					["meetsUsageRequirement"]=meetsUsageRequirement,
					["ItemType"]=ItemType,
          ["Id"]=id,
				}
			end
			MB.ItemCounter=MB.ItemCounter+1
		end
		MB.BankValueTable.CurSlots=#MB.BankValueTable
		MB.BankValueTable.MaxSlots=bagSlots

		MBUI_ContainerTitleInventButtons:SetHidden(true)
		MBUI_ContainerTitleGuildButtons:SetHidden(true)
	elseif PrepareType=="Invent" then
    
    if not IdToPrepare then
      IdToPrepare = MB.LastIdToPrepareInvent
    else
      MB.LastIdToPrepareInvent = IdToPrepare
    end
    
    MBUI_ContainerTitleToggleEquipped:SetHidden(false)
		debug("Preparing Inventory values")
    MBUI_ContainerTitleSwitchInv:SetState(1)
<<<<<<< HEAD
    
		-- local LoadingCharName=MB.CharsName[IdToPrepare]
    local LoadingCharName = "Unknown"
    if IdToPrepare and _G["MBUI_ContainerTitleInventButton"..IdToPrepare] then
      LoadingCharName = _G["MBUI_ContainerTitleInventButton"..IdToPrepare].CharacterName
    else
      debug("Error inventButton: " .. tostring(IdToPrepare))
    end
=======
		local LoadingCharName=MB.CharsName[IdToPrepare]
>>>>>>> origin/master

		if LoadingCharName then
			-- Change Color of Char Text-Buttons..
			-- d("Selected Char: " .. LoadingCharName .. "(" .. IdToPrepare .. ")")
			
      if IdToPrepare then
        MB.ChangeCharacterDisplay(false, IdToPrepare)
      else
        MB.ChangeCharacterDisplay(false, 1)
      end
      
      --[[
			for i=1,#MB.CharsName do
        if i < 9 then
          if  _G["MBUI_ContainerTitleInventButton".. i] then -- ZBS compatibility
             if i == IdToPrepare then
              _G["MBUI_ContainerTitleInventButton".. i]:SetNormalFontColor(255,255,0,1)
             else
              _G["MBUI_ContainerTitleInventButton".. i]:SetNormalFontColor(0,255,255,0.7)
            end
          end
        end
			end
      --]]
    else
      LoadingCharName = MB.CurrentChar
		end
		
    if LoadingCharName and MB.items.Chars[LoadingCharName] then
      if MB.global.ShowEquipped then
          MB.BankValueTable=MB.items.Chars[LoadingCharName]
      else
        local equipped = 0
         -- debug("max-slots: " .. tostring(MB.items.Chars[LoadingCharName]["MaxSlots"]))
          
          for i=1,MB.items.Chars[LoadingCharName]["MaxSlots"] do
            if MB.items.Chars[LoadingCharName][i] then
              if MB.items.Chars[LoadingCharName][i].Equipped then
                equipped = equipped + 1  
              else
                MB.BankValueTable[#MB.BankValueTable+1] = MB.items.Chars[LoadingCharName][i]
              end
            end
          end        
          debug("equipped items: " .. tostring(equipped))
          MB.BankValueTable["MaxSlots"] =  tonumber(MB.items.Chars[LoadingCharName]["MaxSlots"]) - equipped
      end
    else
      debug("Missing CharName")      
    end
    
		MB.CurrentChar = LoadingCharName
		MBUI_ContainerTitleInventButtons:SetHidden(false)
		MBUI_ContainerTitleGuildButtons:SetHidden(true)
	elseif PrepareType=="Guild" then
<<<<<<< HEAD
    
    if not IdToPrepare then
      IdToPrepare = MB.LastIdToPrepareGuild
    else
      MB.LastIdToPrepareGuild = IdToPrepare
    end
=======
>>>>>>> origin/master
    MBUI_ContainerTitleSwitchGuild:SetState(1)
		bagIcon, bagSlots=GetBagInfo(BAG_GUILDBANK)
		debug("Preparing Guild values")
        
		if IdToPrepare == nil and #MB.GuildsName > 0 then IdToPrepare = 1 end
		
	    local guildname=tostring(MB.GuildsName[IdToPrepare])
		
		if guildname and IdToPrepare then
			-- Change Color of Guild Text-Buttons..
			 debug("Selected Guild: " .. guildname.. "(" .. IdToPrepare .. ")")
			
			for i=1,#MB.GuildsName do
			   if i == IdToPrepare then
					_G["MBUI_ContainerTitleGuildButton".. i]:SetNormalFontColor(255,255,0,1)
			   else
					_G["MBUI_ContainerTitleGuildButton".. i]:SetNormalFontColor(0,255,255,0.7)
			  end
			end
		end
				
		MB.BankValueTable=MB.items.Guilds[guildname]
		
		MBUI_ContainerTitleInventButtons:SetHidden(true)
		MBUI_ContainerTitleGuildButtons:SetHidden(false)
  elseif PrepareType == "All" then -- Show all Items (on Guild Banks ,Bank and Inventories) - except Recipes
<<<<<<< HEAD
    MBUI_ContainerTitleToggleEquipped:SetHidden(false)
    MBUI_ContainerTitleSwitchAll:SetState(1)       
    MB.BankValueTable = {}
    
    for i in ipairs(MB.CharsName) do
      debug("We have char : " ..MB.CharsName[i] .." ,so let's check")
      
      --[[
      		if MB.global.ShowEquipped then
        MB.BankValueTable=MB.items.Chars[LoadingCharName]
    else
      local equipped = 0
       -- debug("max-slots: " .. tostring(MB.items.Chars[LoadingCharName]["MaxSlots"]))
        
        for i=1,MB.items.Chars[LoadingCharName]["MaxSlots"] do
          if MB.items.Chars[LoadingCharName][i] then
            if MB.items.Chars[LoadingCharName][i].Equipped then
              equipped = equipped + 1  
            else
              MB.BankValueTable[#MB.BankValueTable+1] = MB.items.Chars[LoadingCharName][i]
            end
          end
        end        
        debug("equipped items: " .. tostring(equipped))
        MB.BankValueTable["MaxSlots"] =  tonumber(MB.items.Chars[LoadingCharName]["MaxSlots"]) - equipped
    end
    --]]
      
      if MB.global.ShowEquipped then
        MB.BankValueTable = MB_Util:MergeTables(MB.BankValueTable,MB.items.Chars[MB.CharsName[i]],"BeforeChars [with equip]: " .. MB.CharsName[i])                
      else
        local equipped = 0
         -- debug("max-slots: " .. tostring(MB.items.Chars[LoadingCharName]["MaxSlots"]))
          local tempTable = {}
          for k in ipairs(MB.items.Chars[MB.CharsName[i]]) do
            if MB.items.Chars[MB.CharsName[i]][k] then
              if not MB.items.Chars[MB.CharsName[i]][k].Equipped then
                tempTable[#tempTable+1] = MB.items.Chars[MB.CharsName[i]][k]
              end
            end
          end        
          
          MB.BankValueTable = MB_Util:MergeTables(MB.BankValueTable,tempTable,"BeforeChars [not equip]" .. MB.CharsName[i])
         -- debug("equipped items: " .. tostring(equipped))
         -- MB.BankValueTable["MaxSlots"] =  tonumber(MB.items.Chars[LoadingCharName]["MaxSlots"]) - equipped
      end
    end
      
=======
    
    MBUI_ContainerTitleSwitchAll:SetState(1)       
    MB.BankValueTable = {}
    
>>>>>>> origin/master
		if #MB.GuildsName > 0 then 
      debug("We have guilds, so let's check them...")
      for i=1,#MB.GuildsName do
        
          local guildname=tostring(MB.GuildsName[i])		
          
          if guildname then
            debug("Checking " .. guildname)
            MB.BankValueTable = MB_Util:MergeTables(MB.BankValueTable,MB.items.Guilds[guildname],"BeforeGuild")
          else
            debug("Invalid Guild: " .. tostring(i))
          end
      end
    end
    debug("We have bank, so let's check it...")
    local bagIcon, bagSlots=GetBagInfo(BAG_BANK)
		MB.ItemCounter=0
    MB.BankValueTableBankOnly = {}
    
		while (MB.ItemCounter < bagSlots) do
			if GetItemName(BAG_BANK,MB.ItemCounter)~="" then
				
				local name = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(BAG_BANK, MB.ItemCounter))
				local link = GetItemLink(BAG_BANK,MB.ItemCounter)
				local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(name).."|h")

				local stackCount = GetSlotStackSize(BAG_BANK,MB.ItemCounter)
				local statValue = GetItemStatValue(BAG_BANK,MB.ItemCounter)
				local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyle, quality = GetItemInfo(BAG_BANK,MB.ItemCounter)
				local ItemType=GetItemType(BAG_BANK,MB.ItemCounter)

<<<<<<< HEAD
        -- local id = link:MB_splitone(":",3)
                      
        local level = GetItemLevel(BAG_BANK,MB.ItemCounter)
      
        local _, _, _, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(link)
        
        if statValue == 0 then          
            statValue = tonumber(level)
            if not statValue then
              statValue = 1
            end
        end
        
=======
        local id = link:MB_splitone(":",3)
                      
        local level = GetItemLevel(BAG_BANK,MB.ItemCounter)
      
        if statValue == 0 then
            statValue = level
        end

>>>>>>> origin/master
				MB.BankValueTableBankOnly[#MB.BankValueTableBankOnly+1]={
					["ItemLink"]=tostring(clearlink),
					["icon"] = tostring(icon),
					["ItemName"]= name, -- GetItemName(BAG_BANK, MB.ItemCounter), -- tostring(name),
					["stackCount"]=stackCount,
					["statValue"]=statValue,
					["sellPrice"] = sellPrice,
					["quality"] = quality,
					["meetsUsageRequirement"]=meetsUsageRequirement,
					["ItemType"]=ItemType,
          ["Id"]=id
				}
			end
			MB.ItemCounter=MB.ItemCounter+1
		end
    debug("BankOnly: " .. tostring(#MB.BankValueTableBankOnly))
    MB.BankValueTable = MB_Util:MergeTables(MB.BankValueTable,MB.BankValueTableBankOnly,"BeforeBankOnly")
          
<<<<<<< HEAD

=======
		for i=1,#MB.CharsName do
      debug("We have char : " ..MB.CharsName[i] .." ,so let's check")
      MB.BankValueTable = MB_Util:MergeTables(MB.BankValueTable,MB.items.Chars[MB.CharsName[i]],"BeforeChars")
		end
				
>>>>>>> origin/master
		MB.BankValueTable.CurSlots=#MB.BankValueTable
		MB.BankValueTable.MaxSlots=bagSlots
    
		MBUI_ContainerTitleInventButtons:SetHidden(true)
		MBUI_ContainerTitleGuildButtons:SetHidden(true)
        
  elseif PrepareType == "Recipes" then
<<<<<<< HEAD
    recipes = true
=======
>>>>>>> origin/master
    MBUI_ContainerTitleSwitchRecipes:SetState(1)
    MBUI_ContainerTitleFilter:SetHidden(true)
    MB.ItemCounter=0
  
    local stopWatch = GetGameTimeMilliseconds() 
    
    for recipeListIndex = 1, GetNumRecipeLists() do
      local recipeListName, numRecipes, upIcon, downIcon, overIcon, disabledIcon, createSound = GetRecipeListInfo(recipeListIndex)        
      -- d("numRecipes:" .. tostring(numRecipes))
      if numRecipes then
        for recipeIndex = 1, numRecipes do
            local known, recipeName, numIngredients, provisionerLevelReq, qualityReq, specialIngredientType = GetRecipeInfo(recipeListIndex, recipeIndex)
            
            --[[ specialIngredientType
                 PROVISIONER_SPECIAL_INGREDIENT_TYPE_FLAVORING
                 PROVISIONER_SPECIAL_INGREDIENT_TYPE_NONE
                 PROVISIONER_SPECIAL_INGREDIENT_TYPE_SPICES 
                 --]]
            if known then
<<<<<<< HEAD
                local numCreatable = 9999
=======
                local numCreatable = 1000
>>>>>>> origin/master
                -- numCreatable = MB.CalculateHowManyCouldBeCreated(recipeListIndex, recipeIndex, numIngredients)
                                
                for i = 1, numIngredients do
                    local name, icon, stack, unknown, quality = GetRecipeIngredientItemInfo(recipeListIndex, recipeIndex, i)
                    local ingredientCount = GetCurrentRecipeIngredientCount(recipeListIndex, recipeIndex, i)  
                    
                   
                    local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, name)
                    
                    local num = MB.ToolTipSearch(itemName,true) 
<<<<<<< HEAD
                    debug(itemName .. " x " .. num)
=======
                    -- debug(itemName .. " x " .. num)
>>>>>>> origin/master
                    
                    if num == 0 then
                        numCreatable = 0
                    else
                        if numCreatable > num then
<<<<<<< HEAD
                           numCreatable = num
=======
                          numCreatable = num
>>>>>>> origin/master
                        end
                    end
                end
                           
<<<<<<< HEAD
                if numCreatable == 9999 then
=======
                if numCreatable == 1000 then
>>>>>>> origin/master
                  numCreatable = 0
                end
                
                -- local link = GetRecipeResultItemLink(recipeListIndex, recipeIndex)
                local link = GetRecipeResultItemLink(recipeListIndex, recipeIndex)
                local  _, _, _, data = ZO_LinkHandler_ParseLink(link)
                -- link = ZO_LinkHandler_CreateChatLink(link)

                -- local clearlink = string.gsub(link,"|H0:item:","|H1:item:")  -- string.gsub(link, "|h.+|h", "|h"..tostring(link).."|h")
                local icon, _ ,meetsUsageRequirement, equipType, itemStyle = GetItemLinkInfo(link)
                local clearname, _, _, sellPrice, quality = GetRecipeResultItemInfo(recipeListIndex, recipeIndex)                         
                                
--                debug("clearname: " .. clearname)
      
<<<<<<< HEAD
                -- local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
                -- local level = quality -- tonumber(link:MB_splitone(":",5))
                
                local _, _, _, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(link)
=======
                local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
                local level = quality -- tonumber(link:MB_splitone(":",5))
>>>>>>> origin/master
    
                --add parse out the data using
                local index = 1
                local itemAttributes = {}
                for value in string.gmatch(data,":") do  
                   itemAttributes[index] = value
                   index = index + 1
                end
                -- itemAttributes[1]  equals ItemID
                -- itemAttributes[2]  equals Quality
                -- itemAttributes[3]  equals Level Requirement
    
                MB.BankValueTable[#MB.BankValueTable+1]={
                  ["ItemLink"]= link,
                  ["icon"] = icon,
                  ["ItemName"]=  clearname, --zo_strformat(SI_TOOLTIP_ITEM_NAME, recipeName),
                  ["stackCount"]= numCreatable,
                  ["statValue"]=  provisionerLevelReq,
                  ["sellPrice"] = sellPrice,
                  ["quality"] = quality,
                  ["meetsUsageRequirement"]= meetsUsageRequirement,
                  ["ItemType"] = ITEMTYPE_RECIPE,
                  ["RecipeListID"] = recipeListIndex,
                  ["RecipeID"] = recipeIndex,
                  ["Id"] = id
                }                  
                
                MB.ItemCounter=MB.ItemCounter+1
            end
        end    
      end 
    end
    debug("time to prepare: " .. tostring(GetGameTimeMilliseconds() - stopWatch))
    MB.BankValueTable.CurSlots=#MB.BankValueTable
		MB.BankValueTable.MaxSlots=#MB.BankValueTable

		MBUI_ContainerTitleInventButtons:SetHidden(true)
		MBUI_ContainerTitleGuildButtons:SetHidden(true)    
  elseif PrepareType == "Loot" then
    MBUI_ContainerTitleSwitchLoot:SetState(1)
    debug("Loot items: " .. #MB.Loot)
    for i=#MB.Loot,1,-1 do             
        MB.BankValueTable[#MB.BankValueTable+1]={
        ["ItemLink"]= MB.Loot[i]["ItemLink"],
        ["icon"] = MB.Loot[i]["icon"],
        ["ItemName"]=  MB.Loot[i]["ItemName"],
        ["stackCount"]= MB.Loot[i]["stackCount"],
        ["statValue"]= MB.Loot[i]["statValue"],
        ["sellPrice"] = MB.Loot[i]["sellPrice"],
        ["quality"] = MB.Loot[i]["quality"],
        ["meetsUsageRequirement"]= MB.Loot[i]["meetsUsageRequirement"],
        ["ItemType"] = MB.Loot[i]["ItemType"],
        ["Id"] = MB.Loot[i]["Id"],
        }                  
    end  
    
    MB.BankValueTable.CurSlots=#MB.BankValueTable
		MB.BankValueTable.MaxSlots=#MB.BankValueTable

    MBUI_ContainerTitleInventButtons:SetHidden(true)
		MBUI_ContainerTitleGuildButtons:SetHidden(true)    
  else
		debug("Unknown prepare type: "..tostring(PrepareType))
	end

    MBUI_ContainerSlider:SetHandler("OnValueChanged",function(self, value, eventReason)
		-- MB.FillBank(value,MB.BankValueTable)
		MB.FilterBank(value,MB.CurrentFilterType,MB.SearchText)
    end)
   
  if PrepareType ~= "Loot" then
      MB.SortPreparedValues()
  end
<<<<<<< HEAD
  MB.InitToolTipSearch(recipes)
=======
  
>>>>>>> origin/master
	return MB.BankValueTable
end

-- Инициализация фильтов
function MB.FilterInit(self)
	MB.FilterChildrens={}
		for i=1,self:GetNumChildren() do
			MB.FilterChildrens[i]=self:GetChild(i)
		end
	-- Анимация
	--[[
	for k,v in pairs(MB.FilterChildrens) do
		v.NormalAnimation=ANIMATION_MANAGER:CreateTimelineFromVirtual("MBUI_FilterAnimation",_G[tostring(v:GetName().."TextureNormal")])
		v.HighlightAnimation=ANIMATION_MANAGER:CreateTimelineFromVirtual("MBUI_FilterAnimation",_G[tostring(v:GetName().."TextureHighlight")])
		v.PressedAnimation=ANIMATION_MANAGER:CreateTimelineFromVirtual("MBUI_FilterAnimation",_G[tostring(v:GetName().."TexturePressed")])
	end
]]

	-- MBUI_ContainerTitleFilterAll.PressedAnimation:PlayInstantlyToEnd()
	-- MBUI_ContainerTitleFilterAllTexturePressed:SetAlpha(1)
end

function MB.FilterEnter(self)
	_G[tostring(self:GetName().."TextureHighlight")]:SetAlpha(0.75)
	-- self.NormalAnimation:PlayFromStart()
	-- self.HighlightAnimation:PlayFromStart()
end

function MB.FilterExit(self)
	_G[tostring(self:GetName().."TextureHighlight")]:SetAlpha(0)
	-- self.NormalAnimation:PlayFromEnd()
	-- self.HighlightAnimation:PlayFromEnd()
end

<<<<<<< HEAD
function MB.FilterClicked(self,filtertype)    
  MB.CurrentFilterType = filtertype --debug("filtertyp:" .. filtertype)
--  if _G["MBUI_ContainerTitleFilter" .. filtertype] then
--    _G["MBUI_ContainerTitleFilter" .. filtertype]:SetState(1)
--  else
--    debug("Unknown Control: " .. "MBUI_ContainerTitleFilter" .. filtertype)
--  end
  local showSubFilter = false
  if filtertype == "Weapon" or filtertype == "Apparel" or filtertype == "Materials" or filtertype == "Consumable" or filtertype == "Miscellaneous" then
      showSubFilter = true
  end
  for i=1,8 do
     _G["MBUI_ContainerTitleFilterSubFilter" .. i]:SetHidden(true)
  end
  if showSubFilter then
    for i=1,8 do
       _G["MBUI_ContainerTitleFilterSubFilter" .. i]:SetHidden(false)
    end
  end
  MBUI_ContainerTitleFilterSubFilter1:SetState(1)  
=======
function MB.FilterClicked(self,filtertype)  
  debug("filtertyp:" .. filtertype)
  if _G["MBUI_ContainerTitleFilter" .. filtertype] then
    _G["MBUI_ContainerTitleFilter" .. filtertype]:SetState(1)
  else
    debug("Unknown Control: " .. "MBUI_ContainerTitleFilter" .. filtertype)
  end
>>>>>>> origin/master
	MB.FilterBank(11,filtertype,MB.SearchText)
	MBUI_ContainerSlider:SetValue(11)

--[[
	for k,v in pairs(MB.FilterChildrens) do
		_G[v:GetName().."TexturePressed"]:SetAlpha(0)
	end

	_G[self:GetName().."TexturePressed"]:SetAlpha(1)
  --]]
	-- self.PressedAnimation:PlayInstantlyToEnd()
end

-- Типы фильтров:
-- All, Weapon, Apparel,Consumable, Materials,Miscellaceous,Junk

-- Не знаю что это за типы.
-- ["ITEMTYPE_NONE"] = 0
-- ["ITEMTYPE_PLUG"] = 3
-- ["ITEMTYPE_TABARD"] = 15
function MB.FilterBank(position,FilterType,SearchText)
	local texture='/esoui/art/miscellaneous/scrollbox_elevator.dds'
<<<<<<< HEAD
  MB.CurrentFilterType = FilterType
  debug("FilterBank: " .. FilterType .. " (" ..SearchText .. ") : " ..tostring(position))
    
=======
  
  debug("FilterBank: " .. FilterType .. " (" ..SearchText .. ") : " ..tostring(position))
  
>>>>>>> origin/master
	if not position then position=11 end
    if MB.BankValueTable then
	
		MB.BankValueTableFiltered={}
    debug("Subfilter: " ..tostring(MB.CurrentSubFilter))
    local itemfilter = {} 
    local subfilter = nil
    if FilterType=="Weapon" then
      itemfilter ={ ITEMTYPE_WEAPON }
      if MB.CurrentSubFilter == "2" then
        subfilter = { WEAPONTYPE_AXE, WEAPONTYPE_SWORD, WEAPONTYPE_HAMMER, WEAPONTYPE_DAGGER }
      elseif MB.CurrentSubFilter == "3" then
        subfilter = { WEAPONTYPE_TWO_HANDED_AXE, WEAPONTYPE_TWO_HANDED_HAMMER, WEAPONTYPE_TWO_HANDED_SWORD }
      elseif MB.CurrentSubFilter == "4" then
        subfilter = { WEAPONTYPE_BOW }
      elseif MB.CurrentSubFilter == "5" then
        subfilter = { WEAPONTYPE_FIRE_STAFF, WEAPONTYPE_FROST_STAFF, WEAPONTYPE_LIGHTNING_STAFF }
      elseif MB.CurrentSubFilter == "6" then
        subfilter = { WEAPONTYPE_HEALING_STAFF }
      elseif MB.CurrentSubFilter == "7" then
        subfilter = { WEAPONTYPE_SHIELD }
      elseif MB.CurrentSubFilter == "8" then
        subfilter = { WEAPONTYPE_RUNE, WEAPONTYPE_NONE }
      end    
    elseif FilterType=="Apparel" then
      itemfilter ={ ITEMTYPE_ARMOR,ITEMTYPE_DISGUISE,ITEMTYPE_COSTUME }
      if MB.CurrentSubFilter == "2" then
        subfilter = { ARMORTYPE_HEAVY }
      elseif MB.CurrentSubFilter == "3" then
        subfilter = { ARMORTYPE_MEDIUM }
      elseif MB.CurrentSubFilter == "4" then
        subfilter = { ARMORTYPE_LIGHT }        
      end
    elseif FilterType=="Consumable" then
      itemfilter ={ ITEMTYPE_POTION,ITEMTYPE_RECIPE,ITEMTYPE_FOOD,ITEMTYPE_DRINK,ITEMTYPE_CONTAINER,ITEMTYPE_POISON, ITEMTYPE_RACIAL_STYLE_MOTIF }
      if MB.CurrentSubFilter == "2" then
        subfilter = { ITEMTYPE_FOOD, ITEMTYPE_DRINK }
      elseif MB.CurrentSubFilter == "3" then
        subfilter = { ITEMTYPE_POTION }
      elseif MB.CurrentSubFilter == "4" then
        subfilter = { ITEMTYPE_RECIPE, ITEMTYPE_CONTAINER, ITEMTTYPE_POISON, ITEMTTYPE_RACIAL_STYLE_MOTIF }
      end
		elseif FilterType=="Materials" then
      itemfilter ={ ITEMTYPE_ALCHEMY_BASE,ITEMTYPE_BLACKSMITHING_MATERIAL,ITEMTYPE_BLACKSMITHING_RAW_MATERIAL,ITEMTYPE_CLOTHIER_MATERIAL,
			ITEMTYPE_CLOTHIER_RAW_MATERIAL,ITEMTYPE_ENCHANTING_RUNE,ITEMTYPE_INGREDIENT,ITEMTYPE_RAW_MATERIAL,ITEMTYPE_REAGENT,
			ITEMTYPE_STYLE_MATERIAL,ITEMTYPE_WEAPON_TRAIT,ITEMTYPE_WOODWORKING_MATERIAL,ITEMTYPE_WOODWORKING_RAW_MATERIAL,ITEMTYPE_ARMOR_TRAIT,
			ITEMTYPE_SPICE,ITEMTYPE_FLAVORING,ITEMTYPE_ADDITIVE,ITEMTYPE_ARMOR_BOOSTER,ITEMTYPE_BLACKSMITHING_BOOSTER,ITEMTYPE_ENCHANTMENT_BOOSTER,
			ITEMTYPE_BLACKSMITHING_BOOSTER,ITEMTYPE_WOODWORKING_BOOSTER,ITEMTYPE_CLOTHIER_BOOSTER,
			ITEMTYPE_ENCHANTING_RUNE_ASPECT,ITEMTYPE_ENCHANTING_RUNE_ESSENCE,ITEMTYPE_ENCHANTING_RUNE_POTENCY	}
      if MB.CurrentSubFilter == "2" then
        subfilter = {  ITEMTYPE_BLACKSMITHING_MATERIAL, ITEMTYPE_BLACKSMITHING_RAW_MATERIAL, ITEMTYPE_WEAPON_BOOSTER }
      elseif MB.CurrentSubFilter == "3" then
        subfilter = {  ITEMTYPE_WOODWORKING_MATERIAL,  ITEMTYPE_WOODWORKING_RAW_MATERIAL, ITEMTYPE_WOODWORKING_BOOSTER }
      elseif MB.CurrentSubFilter == "4" then
        subfilter = {  ITEMTYPE_CLOTHIER_MATERIAL,ITEMTYPE_CLOTHIER_RAW_MATERIAL,ITEMTYPE_CLOTHIER_BOOSTER }
      elseif MB.CurrentSubFilter == "5" then
        subfilter = { ITEMTYPE_ENCHANTING_RUNE, ITEMTYPE_ENCHANTING_RUNE_ASPECT, ITEMTYPE_ENCHANTING_RUNE_ESSENCE, ITEMTYPE_ENCHANTING_RUNE_POTENCY, ITEMTYPE_ENCHANTMENT_BOOSTER}
      elseif MB.CurrentSubFilter == "6" then
        subfilter = { ITEMTYPE_ALCHEMY_BASE, ITEMTYPE_REAGENT }
      elseif MB.CurrentSubFilter == "7" then
        subfilter = { ITEMTYPE_INGREDIENT, ITEMTYPE_SPICE, ITEMTYPE_FLAVORING }
      elseif MB.CurrentSubFilter == "8" then
        subfilter = { ITEMTYPE_ARMOR_TRAIT,ITEMTYPE_WEAPON_TRAIT, ITEMTYPE_ADDITIVE,ITEMTYPE_STYLE_MATERIAL }
      end
    elseif FilterType=="Miscellaneous" then
      itemfilter = { ITEMTYPE_SCROLL,ITEMTYPE_TROPHY,ITEMTYPE_TOOL,ITEMTYPE_SOUL_GEM,ITEMTYPE_SIEGE,ITEMTYPE_LOCKPICK,ITEMTYPE_GLYPH_ARMOR,
			ITEMTYPE_GLYPH_JEWELRY,ITEMTYPE_GLYPH_WEAPON,ITEMTYPE_AVA_REPAIR,ITEMTYPE_COLLECTIBLE,ITEMTYPE_LURE,ITEMTYPE_POISON,
			ITEMTYPE_SPELLCRAFTING_TABLET }
      if MB.CurrentSubFilter == "2" then
        subfilter = { ITEMTYPE_GLYPH_ARMOR, ITEMTYPE_GLYPH_WEAPON, ITEMTYPE_GLYPH_JEWELRY }
      elseif MB.CurrentSubFilter == "3" then
        subfilter = { ITEMTYPE_TROPHY }
      elseif MB.CurrentSubFilter == "4" then
        subfilter = { ITEMTYPE_AVA_REPAIR, ITEMTYPE_SIEGE }
      elseif MB.CurrentSubFilter == "5" then
        subfilter = { ITEMTYPE_SCROLL, ITEMTYPE_TOOL, ITEMTYPE_SOUL_GEM, ITEMTYPE_LOCKPICK, ITEMTYPE_COLLECTIBLE, ITEMTTYPE_LURE, ITEMTTYPE_POISON, ITEMTTYPE_SPELLCRAFTING_TABLET }
      end
		elseif FilterType=="Junk" then
      itemfilter = { ITEMTYPE_TRASH,ITEMTYPE_NONE,ITEMTYPE_PLUG,ITEMTYPE_TABARD }
    end

		if FilterType=="Weapon" or FilterType=="Apparel" or FilterType=="Consumable" or FilterType=="Materials" or FilterType=="Miscellaneous" or FilterType=="Junk" then
			MB.CurrentFilterType=FilterType
			for k,v in pairs(MB.BankValueTable) do
				for k1,v1 in pairs(itemfilter) do
					if type(v)=="table" then
						if v.ItemType==v1 then
							-- debug(v.ItemName.." is "..tostring(FilterType))
<<<<<<< HEAD
              local good = false
              -- debug("Subfilter: " ..tostring(subfilter))
              if subfilter then
                for kv2,v2 in pairs(subfilter) do
                  local subtype = 0
                  if FilterType == "Weapon" then  subtype = GetItemLinkWeaponType(v.ItemLink)  end
                  if FilterType == "Apparel" then subtype = GetItemLinkArmorType(v.ItemLink) end
                  if FilterType == "Materials" or FilterType == "Consumable" or FilterType == "Miscellaneous" then subtype = v.ItemType end
                  if subtype == v2 then good = true end
                end
              else 
                good = true
              end
              if good then
                if(SearchText == "" or string.upper(v.ItemName):find(string.upper(SearchText)) ~= nil ) then
=======
							if(SearchText == "" or string.upper(v.ItemName):find(string.upper(SearchText)) ~= nil ) then
>>>>>>> origin/master
													MB.BankValueTableFiltered[#MB.BankValueTableFiltered+1]=v
                  end
							end
						end
					end
				end
			end
      MB.BankValueTableFiltered.CurSlots = #MB.BankValueTableFiltered
      MB.BankValueTableFiltered.MaxSlots = MB.BankValueTable.MaxSlots
			MB.FillBank(position,MB.BankValueTableFiltered,#MB.BankValueTable)
			if #MB.BankValueTableFiltered>11 then
				MBUI_ContainerSlider:SetMinMax(11,#MB.BankValueTableFiltered)
				MBUI_ContainerSlider:SetThumbTexture(texture, texture, texture, 18, (1/#MB.BankValueTableFiltered*25000)/3, 0, 0, 1, 1)
				MBUI_ContainerSlider:SetHidden(false)
			else
				MBUI_ContainerSlider:SetHidden(true)
			end
		elseif FilterType=="All" then
			MB.CurrentFilterType=FilterType
			for k,v in pairs(MB.BankValueTable) do
					if type(v)=="table" then
						-- debug(v.ItemName.." is "..tostring(FilterType))
						if(SearchText == "" or string.upper(v.ItemName):find(string.upper(SearchText)) ~= nil ) then
												MB.BankValueTableFiltered[#MB.BankValueTableFiltered+1]=v
						end
					end			
			end
      MB.BankValueTableFiltered.CurSlots = #MB.BankValueTableFiltered
      MB.BankValueTableFiltered.MaxSlots = MB.BankValueTable.MaxSlots
			MB.FillBank(position,MB.BankValueTableFiltered,#MB.BankValueTable)
			if #MB.BankValueTableFiltered>11 then
				MBUI_ContainerSlider:SetMinMax(11,#MB.BankValueTableFiltered)
				MBUI_ContainerSlider:SetThumbTexture(texture, texture, texture, 18, (1/#MB.BankValueTableFiltered*25000)/3, 0, 0, 1, 1)
				MBUI_ContainerSlider:SetHidden(false)
			else
				MBUI_ContainerSlider:SetHidden(true)
			end
		else
      MB.CurrentFilterType="All"
			debug("No such FilterType: "..tostring(FilterType))
			MB.FillBank(position,#MB.BankValueTable)
			if #MB.BankValueTable>11 then
				MBUI_ContainerSlider:SetMinMax(11,#MB.BankValueTable)
				MBUI_ContainerSlider:SetThumbTexture(texture, texture, texture, 18, (1/#MB.BankValueTable*25000)/3, 0, 0, 1, 1)
				MBUI_ContainerSlider:SetHidden(false)
			else
				MBUI_ContainerSlider:SetHidden(true)
			end
		end
	end
end

-- сортировка таблицы
function MB.SortPreparedValues()
	local function compare(a,b)
    local comp = a["ItemName"]<b["ItemName"]	
    if MB_Util.SortOrder == "Stat" then
      if a["statValue"] ~= b["statValue"] then
          comp = a["statValue"]>b["statValue"]
      end
    elseif MB_Util.SortOrder == "Value" then
      if a["sellPrice"] ~= b["sellPrice"] then
          comp = a["sellPrice"]>b["sellPrice"]
      end
    end
		return comp
	end

	if MB.BankValueTable then
		table.sort(MB.BankValueTable,compare)
	end
end

function MB.InitToolTipSearch(OnlyIngredients)
     MB.SearchBuffer = {}
           
     for k2,v2 in pairs(MB.items.Chars) do              
        local name = k2       
        if v2["MaxSlots"] then          
          for i=1,v2["MaxSlots"] do            
            if v2[i] then
              local equipped = ""
              local stat = ""
              if v2[i].Equipped then
                equipped = " |c559999Equipped|r "
              end
              if v2[i].statValue > 0 then  
                stat = " |c559999[" .. v2[i].statValue .. "]|r "
              end
              
              MB.SearchBuffer[#MB.SearchBuffer+1] =
              {
                 name = zo_strformat(SI_TOOLTIP_ITEM_NAME, v2[i].ItemName):lower(),
                 statValue = stat,              
                 stackCount = tostring(v2[i].stackCount),
                 equipped = equipped,
                 origin = "|cAAFFFF x " .. MB_Util:GetAliasName(name) .. "|r"
               }            
              
            end
          end
        end
      end
      -- My Bank Items
      local _, bagSlots=GetBagInfo(BAG_BANK)
      local cnt=0
      while (cnt < bagSlots) do        
        if GetItemName(BAG_BANK,cnt)~="" then				
          local name = GetItemName(BAG_BANK, cnt) -- zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(BAG_BANK, cnt))
          local _,stack,_,_,_,_,_,_ = GetItemInfo(BAG_BANK,cnt)
          local link = GetItemLink(BAG_BANK,cnt)
          local stackCount = GetSlotStackSize(BAG_BANK, cnt)
          local statValue = GetItemStatValue(BAG_BANK,cnt)
          local level = GetItemLevel(BAG_BANK,cnt)
          
          if statValue == 0 then          
              statValue = tonumber(level)
              if not statValue then
                statValue = 1
              end
          end
          
          name = zo_strformat(SI_TOOLTIP_ITEM_NAME, name)
      
          local stat = ""
          if statValue > 0 then  
            stat = " |c559999[" .. statValue .. "]|r "
          end
          
          MB.SearchBuffer[#MB.SearchBuffer+1] =
          {
             name = name:lower(),
             statValue = stat,              
             stackCount = tostring(stack),
             equipped = "",
             origin = "|c99DD99 x Bank|r"
           }            
        end
        cnt = cnt + 1         
      end
     -- Guilds Items
     for k2,v2 in pairs(MB.items.Guilds) do              
        local name = k2
        local ignore = false
        for k,v in pairs(MB.aliases.Guilds) do
          if k == name and OnlyIngredients then
            if v.ID == 1 then ignore = MB.global.IgnoreGuildIngredients1 end
            if v.ID == 2 then ignore = MB.global.IgnoreGuildIngredients2 end
            if v.ID == 3 then ignore = MB.global.IgnoreGuildIngredients3 end
            if v.ID == 4 then ignore = MB.global.IgnoreGuildIngredients4 end
            if v.ID == 5 then ignore = MB.global.IgnoreGuildIngredients5 end
          elseif k == name and not OnlyIngredients then
            if v.ID == 1 then ignore = MB.global.IgnoreGuild1 end
            if v.ID == 2 then ignore = MB.global.IgnoreGuild2 end
            if v.ID == 3 then ignore = MB.global.IgnoreGuild3 end
            if v.ID == 4 then ignore = MB.global.IgnoreGuild4 end
            if v.ID == 5 then ignore = MB.global.IgnoreGuild5 end
          end
        end
        if not ignore then
          if v2["MaxSlots"] then
            for i=1,v2["MaxSlots"] do              
              if v2[i] then
                local stat = ""
                if v2[i].statValue > 0 then  
                  stat = " |c559999[" .. v2[i].statValue .. "]|r "
                end
                
                MB.SearchBuffer[#MB.SearchBuffer+1] =
                {
                   name = zo_strformat(SI_TOOLTIP_ITEM_NAME,v2[i].ItemName):lower(),
                   statValue = stat,              
                   stackCount = tostring(v2[i].stackCount),
                   equipped = "",
                   origin = "|cAA6622 x " .. MB_Util:GetAliasGuildName(name) .. "|r"
                 }                      
              end
            end
          end
        else
          debug("Ignoring Guild: " .. name .. " / " .. tostring(OnlyIngredients))
        end
     end     
end  
  
function MB.HookTooltips()
    local InvokeSetBagItemTooltip = ItemTooltip.SetBagItem
    ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
        -- local tradeSkillType, itemType = GetItemCraftingInfo(bagId, slotIndex)        
        InvokeSetBagItemTooltip(control, bagId, slotIndex, ...)
        if MB.global.InventoryToolTips then
          control:AddVerticalPadding(10)          
--[[          local icon, sellPrice, meets, equipType, itemStyle, var1, var2, var3 = GetItemLinkInfo(GetItemLink(bagId,slotIndex))
          local _ , _ , _ , _, _, _, _, quality = GetItemInfo(bagId,slotIndex)
          debug("icon: " ..tostring(icon))
          debug("sellPrice: " ..tostring(sellPrice))
          debug("meets: " ..tostring(meets))
          debug("equipType: " ..tostring(equipType))
          debug("itemStyle: " ..tostring(itemStyle))
          local level = GetItemLevel(bagId,slotIndex) 
          debug("Level: " .. tostring(level))
          debug("Quality: " .. tostring(quality))
 --]]         
          local name = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(bagId,slotIndex))
          MB.ToolTipSearch(name, false, control)        
        end
    end
end

function MB.ToolTipSearch(search,onlyCount,control)    
   if not MB.SearchBuffer or #MB.SearchBuffer == 0 then
      debug("MB.SearchBuffer is empty!")
      MB.InitToolTipSearch(false)
   end
   if not control then
      control = ItemTooltip
   end 
   local num = 0
   local lowsearch = search:lower()   
   for i=1,#MB.SearchBuffer do
        if MB.SearchBuffer[i].name == lowsearch then
            num = num + MB.SearchBuffer[i].stackCount
            if not onlyCount then                
                control:AddLine(MB.SearchBuffer[i].stackCount .. MB.SearchBuffer[i].origin .."|r" .. MB.SearchBuffer[i].statValue .. MB.SearchBuffer[i].equipped,"ZoFontGame", 1, 1, 1, CENTER, MODIFY_TEXT_TYPE_NONE, LEFT, false)
            end
        end
   end
          
   return num
end
   

-- Заполнение банка
function MB.FillBank(last,TableToFillFrom,TotalItems)
  
  debug("FillBank")
-- Технические функции
-- Функции отображения и сокрытия тултипов при наведении мышки
	function MB.TooltipEnter(self)
		-- Тут может быть любой другой якорь. Нам важен его родитель
    
		ItemTooltip:ClearAnchors()
		ItemTooltip:ClearLines()
    
		if self:GetLeft()>=480 then
			ItemTooltip:SetAnchor(CENTER,self,CENTER,-480,0)
		else
			ItemTooltip:SetAnchor(CENTER,self,CENTER,500,0)
		end

		ItemTooltip:SetLink(TableToFillFrom[self.id].ItemLink)

		-- Show Comparative Tooltips for Type Weapon or Armor
<<<<<<< HEAD
		if TableToFillFrom[self.id].ItemType==ITEMTYPE_WEAPON or TableToFillFrom[self.id].ItemType==ITEMTYPE_ARMOR then
=======
		if self.ItemType==ITEMTYPE_WEAPON or self.ItemType==ITEMTYPE_ARMOR then
>>>>>>> origin/master
			-- Броня в банке
      if not TableToFillFrom[self.id].Equipped then -- don't show equipped stuff
        ItemTooltip:ClearAnchors()
        ComparativeTooltip1:ClearAnchors()

        if self:GetLeft()>=480 then
          ItemTooltip:SetAnchor(TOP,self,CENTER,-480,0)
          ComparativeTooltip1:SetAnchor(BOTTOM,self,CENTER,-480,0)
        else
          ItemTooltip:SetAnchor(TOP,self,CENTER,500,0)
          ComparativeTooltip1:SetAnchor(BOTTOM,self,CENTER,500,0)
        end	
        ComparativeTooltip1:SetAlpha(1)
        ComparativeTooltip1:SetHidden(false)
        ItemTooltip:ShowComparativeTooltips()
      end
		end
		
<<<<<<< HEAD
    ItemTooltip:AddVerticalPadding(10)
    
    --[[
    if TableToFillFrom[self.id].ItemType == ITEMTYPE_ARMOR then
        local weapontype,weapontypelabel = GetItemArmorType(TableToFillFrom[self.id].ItemLink)
        if not weapontypelabel then
          weapontypelabel = "Unknown"        
        end
        ItemTooltip:AddLine("|cFF0000" .. tostring(weapontype) .. " / " .. tostring(weapontypelabel) .. "|r")
    end
    --]]
    
=======
>>>>>>> origin/master
    if self.ItemType == ITEMTYPE_RECIPE then
      if TableToFillFrom[self.id].RecipeListID then
        local recipeListIndex = TableToFillFrom[self.id].RecipeListID
        local recipeIndex = TableToFillFrom[self.id].RecipeID
        local known, recipeName, numIngredients, provisionerLevelReq, qualityReq, specialIngredientType = GetRecipeInfo(recipeListIndex, recipeIndex)
      
        -- ItemTooltip:AddLine("|c66FF33 Provisioning Level Req:" .. tostring(provisionerLevelReq) .. "|r")
--        if specialIngredientType then
--          ItemTooltip:AddLine("|c66FF33 Special Ingredient^p:" .. tostring(specialIngredientType) .. "|r")
--        end
        
          if known then
                local numCreatable = 0
                -- numCreatable = MB.CalculateHowManyCouldBeCreated(recipeListIndex, recipeIndex, numIngredients)
                                              
                for i = 1, numIngredients do
                    local name, icon, stack, unknown, quality = GetRecipeIngredientItemInfo(recipeListIndex, recipeIndex, i)
                    local ingredientCount = GetCurrentRecipeIngredientCount(recipeListIndex, recipeIndex, i)  
                    -- d("name: " .. name)
                    -- d("stack: " .. tostring(stack))
                    -- d("quality: " .. tostring(quality))
                    -- d("unknown: " .. tostring(unknown))
                    -- d("count: " .. tostring(ingredientCount))
                    local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, name)
                    
                    local num = MB.ToolTipSearch(itemName,true) 
                    if num == 0 then
                        ItemTooltip:AddLine("|c44AA00" .. tostring(stack) .. " x " .. itemName .. "|r")
                        numCreatable = 0
                    else
                        ItemTooltip:AddLine("|c66FF33" .. tostring(stack) .. " x " .. itemName .. "|r")
                        if numCreatable > num then
                          numCreatable = num
                        end
                    end
                    MB.ToolTipSearch(itemName)                    
                end
                -- d("provisionerLevelReq: " .. tostring(provisionerLevelReq))
                -- d("qualityReq: " .. tostring(qualityReq))
                -- if specialIngredientType then
                --  d("specialIngredientType: " .. specialIngredientType)
                -- end
                -- d("numCreatable: " ..tostring(numCreatable))
                                                                 
                -- local link = GetRecipeResultItemLink(recipeListIndex, recipeIndex)
                -- local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(link).."|h")
                -- local icon,sellPrice,meetsUsageRequirement, equipType, itemStyle = GetItemLinkInfo(link)
                                              
            end
      end
    end
    
   -- ItemTooltip:AddLine("??")
<<<<<<< HEAD
     MB.ToolTipSearch(TableToFillFrom[self.id].ItemName)
=======
     -- local num = MB.ToolTipSearch(TableToFillFrom[self.id].ItemName)
>>>>>>> origin/master
     -- debug(zo_strformat(SI_TOOLTIP_ITEM_NAME, TableToFillFrom[self.id].ItemName) .. " x " .. num)
    
      ItemTooltip:SetAlpha(1)
      ItemTooltip:SetHidden(false)
      _G[tostring(self:GetName().."Highlight")]:SetAlpha(1)  
		-- self.IconTimeline=ANIMATION_MANAGER:CreateTimelineFromVirtual("MBUI_IconAnimation",_G[tostring(self:GetName().."ButtonIcon")])
		-- self.IconTimeline:PlayFromStart()
	end
<<<<<<< HEAD
  
=======

  function MB.ToolTipSearch(search,onlyCount)    
     local num = 0
     for k2,v2 in pairs(MB.items.Chars) do              
        local name = k2
        if v2["CurSlots"] then
          for i=1,v2["CurSlots"] do            
            
            if type(v2[i]) == "table" and v2[i].ItemName and zo_strformat(SI_TOOLTIP_ITEM_NAME, v2[i].ItemName):lower() == search:lower() then
                num = num + v2[i].stackCount
                if not onlyCount then
                  local stat = ""
                  local equipped = ""
                  if v2[i].statValue > 0 then
                    stat = " |c559999[" .. v2[i].statValue .. "]|r "
                  end
                  if v2[i].Equipped then
                    equipped = " |c559999Equipped|r "
                  end
                  ItemTooltip:AddLine("|cAAFFFF " .. tostring(v2[i].stackCount) .. "x " .. MB_Util:GetAliasName(name) .."|r" .. stat .. equipped)
                end             
            end
          end
        end
      end
      -- My Bank Items
      local _, bagSlots=GetBagInfo(BAG_BANK)
      local cnt=0
      while (cnt < bagSlots) do        
        if GetItemName(BAG_BANK,cnt)~="" then				
          local name = GetItemName(BAG_BANK, cnt) -- zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(BAG_BANK, cnt))
          local _,stack,_,_,_,_,_,_ = GetItemInfo(BAG_BANK,cnt)
          -- local link = GetItemLink(BAG_BANK,MB.ItemCounter)
          local stackCount = GetSlotStackSize(BAG_BANK, cnt)
          local statValue = GetItemStatValue(BAG_BANK,cnt)
          if statValue == 0 then
              statValue = GetItemLevel(BAG_BANK,cnt)
          end
          name = zo_strformat(SI_TOOLTIP_ITEM_NAME, name)
          if name:lower() == search:lower() then
              num = num + stackCount
              if not onlyCount then
                if statValue > 0 then                   
                   ItemTooltip:AddLine("|cAAFFFF " .. tostring(stack) ..  " x Bank ".. "  |c559999[" .. statValue .. "]|r")
                else
                   ItemTooltip:AddLine("|cAAFFFF " .. tostring(stack) ..  " x Bank " .. "|r")                                          
                end
              end
          end
        end
        cnt = cnt + 1         
      end
     -- Guilds Items
     for k2,v2 in pairs(MB.items.Guilds) do              
        local name = k2
        if v2["CurSlots"] then
          for i=1,v2["CurSlots"] do  
            if type(v2[i]) == "table" and v2[i].ItemName and zo_strformat(SI_TOOLTIP_ITEM_NAME,v2[i].ItemName):lower() == search:lower() then
                num = num + v2[i].stackCount
                if not onlyCount then
                  if v2[i].statValue > 0 then
                    ItemTooltip:AddLine("|c3366DD " .. tostring(v2[i].stackCount) .. "x " .. name .. "  |c559999[" .. v2[i].statValue .. "]|r")
                  else
                    ItemTooltip:AddLine("|c3366DD " .. tostring(v2[i].stackCount) .. "x " .. name .. "|r")                          
                  end
                end
            end
          end
        end
      end
      return num
  end
   

>>>>>>> origin/master
	function MB.TooltipExit(self)
		ItemTooltip:ClearAnchors()
		ItemTooltip:ClearLines()
		ItemTooltip:SetAlpha(0)
		ItemTooltip:SetHidden(true)
		_G[tostring(self:GetName().."Highlight")]:SetAlpha(0)

	  --	self.IconTimeline:PlayFromEnd()

			-- Сравнительный тултип
			if self.ItemType==ITEMTYPE_WEAPON or self.ItemType==ITEMTYPE_ARMOR then
				ComparativeTooltip1:ClearAnchors()
		    	ItemTooltip:HideComparativeTooltips()
			end

	end

	-- Функция прокрутки колёсиком
	function MB.MoveScrollerWheel(self,delta)
		local calculatedvalue=MB.CurrentLastValue-delta
		if (calculatedvalue>=11) and (calculatedvalue<=#TableToFillFrom) then
			-- MB.FillBank(calculatedvalue,MB.BankValueTable)
			MB.FilterBank(calculatedvalue,MB.CurrentFilterType,MB.SearchText)
			MBUI_ContainerSlider:SetValue(calculatedvalue)
		end
	end

  local showTotal = true
  local emptyTable = false
  
  if MB.Label == "All" or MB.Label == "Recipes" or MB.Label == "Guild" or MB.Label == "Loot" then
      showTotal = false
  end
  
	if not TableToFillFrom then debug("Wrong TableToFillFrom") return end

	if last<=1 then
    debug("last<=1")
    emptyTable = true
  elseif (#TableToFillFrom==0) then 
    debug("No data avaliable.")
    MBUI_ContainerItemCounter:SetHidden(true)
    MBUI_ContainerSlider:SetHidden(true)
    emptyTable = true
    for i=1,11 do
      _G["MBUI_Row"..i]:SetHidden(true)
    end
  elseif last>1 and last<=11 then
    for i=1,11 do
      _G["MBUI_Row"..i]:SetHidden(false)
    end
	else
    for i=1,11 do
      _G["MBUI_Row"..i]:SetHidden(false)
    end
  end
  MB.CurrentLastValue=last

  if #TableToFillFrom<11 and not emptyTable then
    -- Прячем Слайдер
    MBUI_ContainerSlider:SetHidden(true)
    -- Заполнение идёт сверху
    for i=1,#TableToFillFrom do
      local icon,sellPrice,meetsUsageRequirement,equipType,itemStyle = GetItemLinkInfo(TableToFillFrom[i].ItemLink)

      _G["MBUI_Row"..i].id=i
        _G["MBUI_Row"..i].ItemType=TableToFillFrom[i].ItemType

      _G["MBUI_Row"..i.."ButtonIcon"]:SetTexture(TableToFillFrom[i].icon)

<<<<<<< HEAD
      if not meetsUsageRequirement then
=======
      if not TableToFillFrom[i].meetsUsageRequirement then
>>>>>>> origin/master
        _G["MBUI_Row"..i.."ButtonIcon"]:SetColor(1,0,0,1)
      else
        _G["MBUI_Row"..i.."ButtonIcon"]:SetColor(1,1,1,1)
      end

      if TableToFillFrom[i].Equipped then
<<<<<<< HEAD
        -- _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("|t32:64:EsoUI/Art/Mounts/activemount_icon.dds:inheritColor|t")
         _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("|t16:16:EsoUI/Art/Miscellaneous/locked_over.dds:inheritColor|t")
         -- debug("equipped: " .. TableToFillFrom[i].ItemLink)
=======
        _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("|t32:64:EsoUI/Art/Mounts/activemount_icon.dds|t")
        debug("equipped: " .. TableToFillFrom[i].ItemLink)
>>>>>>> origin/master
      else
        _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("")
      end
      _G["MBUI_Row"..i.."ButtonStackCount"]:SetText(TableToFillFrom[i].stackCount)
      if TableToFillFrom[i].RecipeListID then
         _G["MBUI_Row"..i.."Name"]:SetText(GetRecipeResultItemLink(TableToFillFrom[i].RecipeListID, TableToFillFrom[i].RecipeID))
      else
         _G["MBUI_Row"..i.."Name"]:SetText(TableToFillFrom[i].ItemLink)
      end
      if (TableToFillFrom[i].statValue~=0) then
        _G["MBUI_Row"..i.."StatValue"]:SetText(TableToFillFrom[i].statValue)
      else
        _G["MBUI_Row"..i.."StatValue"]:SetText("-")
      end
      _G["MBUI_Row"..i.."SellPrice"]:SetText(TableToFillFrom[i].stackCount*sellPrice.." |t16:16:EsoUI/Art/currency/currency_gold.dds|t")

      _G["MBUI_Row"..i]:SetHandler("OnMouseUp", function(self,button) 
            if button~=2 then return end
              ZO_ChatWindowTextEntryEditBox:SetText(tostring(ZO_ChatWindowTextEntryEditBox:GetText()).."["..TableToFillFrom[i].ItemLink.."]")
            end)
    end

		-- Прячем пустые строки
		for i=#TableToFillFrom+1,11 do
			_G["MBUI_Row"..i]:SetHidden(true)
		end
  elseif not emptyTable then
    -- Показываем слайдер
    MBUI_ContainerSlider:SetHidden(false)
    -- Заполнение идёт снизу
    for i=11,1,-1 do
      -- debug("last: "..tostring(last))
      local item = TableToFillFrom[last]
      if item then          
        local icon,sellPrice,meetsUsageRequirement,equipType,itemStyle = GetItemLinkInfo(item.ItemLink)
        
        _G["MBUI_Row"..i].id=last
        _G["MBUI_Row"..i].ItemType=item.ItemType

        _G["MBUI_Row"..i.."ButtonIcon"]:SetTexture(item.icon)

<<<<<<< HEAD
          if not meetsUsageRequirement then
=======
          if not item.meetsUsageRequirement then
>>>>>>> origin/master
          _G["MBUI_Row"..i.."ButtonIcon"]:SetColor(1,0,0,1)
        else
          _G["MBUI_Row"..i.."ButtonIcon"]:SetColor(1,1,1,1)
        end
<<<<<<< HEAD
        if item.Equipped then
        --  _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("|t32:64:EsoUI/Art/Mounts/activemount_icon.dds:inheritColor|t")
          _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("|t16:16:EsoUI/Art/Miscellaneous/locked_over.dds:inheritColor|t")
        
          -- debug("equipped: " .. TableToFillFrom[i].ItemLink)
=======
        if TableToFillFrom[i].Equipped then
          _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("|t32:64:EsoUI/Art/Mounts/activemount_icon.dds|t")
          debug("equipped: " .. TableToFillFrom[i].ItemLink)
>>>>>>> origin/master
        else
          _G["MBUI_Row"..i.."ButtonEquipped"]:SetText("")
        end
        _G["MBUI_Row"..i.."ButtonStackCount"]:SetText(item.stackCount)
        if item.RecipeListID then
           _G["MBUI_Row"..i.."Name"]:SetText(GetRecipeResultItemLink(item.RecipeListID, item.RecipeID))
        else
          _G["MBUI_Row"..i.."Name"]:SetText(item.ItemLink) -- .ItemLink)
        end
          if (TableToFillFrom[last].statValue~=0) then
          _G["MBUI_Row"..i.."StatValue"]:SetText(item.statValue)
        else
          _G["MBUI_Row"..i.."StatValue"]:SetText("-")
        end
        _G["MBUI_Row"..i.."SellPrice"]:SetText(item.stackCount*sellPrice.." |t16:16:EsoUI/Art/currency/currency_gold.dds|t")

        _G["MBUI_Row"..i]:SetHandler("OnMouseUp", function(self,button) 
            if button~=2 then return end
            ZO_ChatWindowTextEntryEditBox:SetText(tostring(ZO_ChatWindowTextEntryEditBox:GetText()).."["..TableToFillFrom[self.id].ItemLink.."]")
          end)
      else
          debug("Error with item: " .. tostring(last))
      end
      
			if last<=#TableToFillFrom and last>1 then
    		last=last-1
    	else
    		last=11
    	end
		end
  end
  -- Заполняем вместимость банка
  local CurBankCapacity = TableToFillFrom.CurSlots or #TableToFillFrom
  local BankMaxCapacity = TableToFillFrom.MaxSlots or 0

	-- get the gold Amount of the Selected Character
	
	local goldtext = ""
	local totalgold = 0
	for i=1, #MB.CharsName do		
			if MB.gold.Chars[MB.CharsName[i]] and MB.gold.Chars[MB.CharsName[i]].Current then
				totalgold = MB.gold.Chars[MB.CharsName[i]].Current + totalgold
			end
	end
	
	totalgold = totalgold + GetBankedMoney()	
  totalgold = string.format("|u%d:%d:currency:%s|u", 0, 0, ZO_CurrencyControl_FormatCurrency(totalgold))

	if MB.CurrentChar then
	  debug("current char: " .. MB.CurrentChar)
		local goldTable = MB.gold.Chars[MB.CurrentChar]		
		if goldTable then
<<<<<<< HEAD
--      debug("gold table found")
      if goldTable.Current then				   --  and MB.Label == "Invent" 
        goldtext = "  - |cFFFF00 " .. string.format("|u%d:%d:currency:%s|u", 0, 0, ZO_CurrencyControl_FormatCurrency(goldTable.Current))  .. " |r |cAAAA00/ " .. tostring(totalgold) .." Gold|r"
 --       debug("gold text: " .. goldtext )
--      else
--        debug("no gold info found")
=======
      debug("gold table found")
      if goldTable.Current then				   --  and MB.Label == "Invent" 
        goldtext = "  - |cFFFF00 " .. string.format("|u%d:%d:currency:%s|u", 0, 0, ZO_CurrencyControl_FormatCurrency(goldTable.Current))  .. " |r |cAAAA00/ " .. tostring(totalgold) .." Gold|r"
        debug("gold text: " .. goldtext )
      else
        debug("no gold info found")
>>>>>>> origin/master
      end
		end
	end
	if MB.Label == "Bank" then
			goldtext =  "  - |cFFFF00 " .. string.format("|u%d:%d:currency:%s|u", 0, 0, ZO_CurrencyControl_FormatCurrency(GetBankedMoney()))  .. " |r |cAAAA00/ " .. tostring(totalgold) .." Gold|r"
  elseif MB.Label == "All" then
      goldtext =  "  - |cFFFF00 " .. tostring(totalgold)  .. " |r |cAAAA00/ " .. tostring(totalgold) .." Gold|r"
  elseif MB.Label == "Loot" or MB.Label == "Recipes" or MB.Label == "Guild" then
      goldtext =  "  - |cAAAA00 " .. tostring(totalgold) .." Gold|r"
	end

  local totaltext = ""
  if showTotal then
    totaltext = " / ".. tostring(BankMaxCapacity)
  end
  
  if TotalItems > 0 then
    if TotalItems == CurBankCapacity then
      MBUI_ContainerItemCounter:SetText(MB.Label .. ":  |c555555(".. tostring(CurBankCapacity)..")|r " .. tostring(TotalItems) .. totaltext .. goldtext)
    else
      MBUI_ContainerItemCounter:SetText(MB.Label .. ":  |cAAAAFF(".. tostring(CurBankCapacity) ..")|r " .. tostring(TotalItems) .. totaltext .. goldtext)
    end
  else
    MBUI_ContainerItemCounter:SetText(MB.Label .. ":  |cAAAAFF(".. tostring(CurBankCapacity) ..")|r " .. tostring(TotalItems) .. totaltext  .. goldtext)
  end
      
  MBUI_ContainerItemCounter:SetHidden(false)	
end


function MB.PL_Opened()
	debug("Event PL_Opened fired")
end

function MB.PL_Closed()
	debug("Event PL_Closed fired")
	MB.SavePlayerInvent()
end

function MB.GB_Opened()
	debug("Event GB_Opened fired")
end

function MB.GB_Ready()
	debug("Event GB_Ready fired")
	MB.SavePlayerInvent()
	MB.gcount()
end

<<<<<<< HEAD
function MB.SingleSlotUpdate(eventCode,bagId, slotId, isNewItem, itemSoundCategory, updateReason)
  
  -- EVENT_INVENTORY_SINGLE_SLOT_UPDATE (integer eventCode, integer bagId, integer slotId, bool isNewItem, integer itemSoundCategory, integer updateReason) 
  local bagname = "Unknown"
  
  if bagId == BAG_BACKPACK then bagname = "Backpack" end
  if bagId == BAG_BANK then bagname = "Bank" end
  if bagId == BAG_BUYBACK then bagname = "Buyback" end
  if bagId == BAG_GUILDBANK then bagname = "Guildbank" end
  if bagId == BAG_WORN then bagname = "Worn" end
  
  debug("Event SingleSlotUpdate fired: " .. bagname .. " Slot: " .. tostring(slotId) .. " (New: " ..tostring(isNewItem) .. ") / Reason: " .. tostring(updateReason))
    
  if bagname == "Backpack" and isNewItem then
    MB.SavePlayerInvent()
  end  
end

--[[
=======
>>>>>>> origin/master
function MB.CalculateHowManyCouldBeCreated(recipeListIndex, recipeIndex, numIngredients)
  
    local minCount

    for ingredientIndex = 1, numIngredients do
        local _, _, requiredQuantity = GetRecipeIngredientItemInfo(recipeListIndex, recipeIndex, ingredientIndex)
        local ingredientCount = GetCurrentRecipeIngredientCount(recipeListIndex, recipeIndex, ingredientIndex)

        minCount = zo_min(zo_floor(ingredientCount / requiredQuantity), minCount or math.huge)
        if minCount == 0 then
            return 0
        end
    end
<<<<<<< HEAD
=======

    return minCount or 0
end
>>>>>>> origin/master

    return minCount or 0
end
--]]

function MB.commandHandler( text )
  
  if not MB.CurrentChar then
    MB.CurrentChar = GetUnitName("player")
  end
  
	if text=="cls" then
		MB.items.Guilds={}
		MB.items.Chars={}
		-- Clear also Gold and Aliases
		MB.gold.Chars={}
    MB.Loot={}
		MB.aliases.Chars={}
    MB.aliases.Guilds={}
<<<<<<< HEAD
    MB.global.IgnoreGuild1 = false
    MB.global.IgnoreGuild2 = false
    MB.global.IgnoreGuild3 = false
    MB.global.IgnoreGuild4 = false
    MB.global.IgnoreGuild5 = false
=======
>>>>>>> origin/master
		MB.params.MBUI_Menu=nil
		MB.params.MBUI_Container=nil
		ReloadUI()
	elseif text=="hide" then
		MB.params.hidden=true
		MBUI_Menu:SetHidden(true)
	elseif text=="show" then
		MB.params.hidden=false
		MBUI_Menu:SetHidden(false)
  elseif text=="save" then
    MB.SavePlayerInvent()
<<<<<<< HEAD
  elseif text=="toggle" or text=="toggle inv" then
    if not MB.LastCommandUI then
        MB.LastCommandUI = "a"
        MB.Label = "All"
    end
    local isInventory = false   
    
    if text=="toggle inv" then
      -- toggle on/off Inventory Screen
      MAIN_MENU:ToggleCategory(MENU_CATEGORY_INVENTORY)
      -- Evaluate the status of Inventory Screen
      local categoryInfo = MAIN_MENU.categoryInfo[MENU_CATEGORY_INVENTORY]    
      if(categoryInfo.lastSceneName and SCENE_MANAGER:IsShowing(categoryInfo.lastSceneName)) then
        isInventory = true
      end            
    end

    if (MBUI_Container:IsHidden() == false and isInventory == true) then
      debug("MB is already open and Invetory is open now")
    else      
      debug("need to toggle MB")
      --local comm = MB.LastCommandUI    
       
      if MB.ShowHide(MB.LastCommandUI ) then
        if MB.Label then
          MB.PrepareBankValues(MB.Label)          
          MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
          MBUI_Container:SetHidden(false)
          MB.PreviousButtonClicked=nil
          MB.LastButtonClicked=nil		
        end
      end
    end
    
  elseif text=="search" then
    MB.InitToolTipSearch(false)
  elseif text=="test" then
    d(string.format("%2$s -> %1$s","Hello","Hallo"))    
=======
>>>>>>> origin/master
	elseif text=="p" then
	      if MB.ShowHide(text) then
			MB.CurrentLastValue=11
			MB.PrepareBankValues("Bank")
			-- MB.FillBank(MB.CurrentLastValue,MB.BankValueTable)
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
		end
	elseif text=="i" then
		if MB.ShowHide(text) then
			MB.CurrentLastValue=11
			-- Check for Last used Inventory Character... if nothing found use current Character
			local inv = 0
			local currentChar = GetUnitName("player")
			for k,v in pairs(MB.CharsName) do
				if v == MB.CurrentChar then
					inv = k
					break
				end
			end
			if inv == 0 then
				for k,v in pairs(MB.CharsName) do
					if v == currentChar then
						inv = k
						break
					end
				end
			end
			-- if nothing found (should never happen?) use the first entry
			if inv == 0  then
			   inv = 1
			end
			 
			MB.PrepareBankValues("Invent",inv)			
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
		end	
	elseif text=="g" then
		if MB.ShowHide(text) then
			MB.CurrentLastValue=11
			MB.PrepareBankValues("Guild",1)			
<<<<<<< HEAD
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
		end
  elseif text=="a" then
		if MB.ShowHide(text) then
			MB.CurrentLastValue=11
			MB.PrepareBankValues("All")			
=======
>>>>>>> origin/master
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
		end
<<<<<<< HEAD
=======
  elseif text=="a" then
		if MB.ShowHide(text) then
			MB.CurrentLastValue=11
			MB.PrepareBankValues("All")			
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
		end
>>>>>>> origin/master
  elseif text=="r" then        
    if MB.ShowHide(text) then
    	MB.PrepareBankValues("Recipes")			
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
    end
  elseif text=="l" then                
<<<<<<< HEAD
    if MB.ShowHide(text) then      
=======
    if MB.ShowHide(text) then
>>>>>>> origin/master
    	MB.PrepareBankValues("Loot")			
			MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
			MBUI_Container:SetHidden(false)
			MB.PreviousButtonClicked=nil
			MB.LastButtonClicked=nil
    end
  elseif text=="o" or text=="options" then
      if LAM and MB.OptionsPanel then
        debug("Show Options")
        LAM:OpenToPanel(MB.OptionsPanel)
      end
	else
    d("Enter /mb <command> where command can be:")
    d("a    - show all items")
		d("p,g  - show player bank,guild banks")
		d("i    - show inventories of your characters")
    d("l    - show recent loot")
		d("rs    - show recipes (of current char)")
    d("cls  - clear all data and reloadui")
 		d("hide,show - small menu window (not fully supported anymore)")		    
		
	end
end

function MB.ShowHide(command)		
		-- Check if UI is hidden...
		if MBUI_Container:IsHidden() then
		    -- UI is not displayed at the moment...
			-- Turn On/Off Cursor Mode depending on Situation
			-- Save first the active Cursor State....
			MB.CursorWasActive = IsGameCameraUIModeActive()
			if  not IsGameCameraUIModeActive() then
				SetGameCameraUIMode(true)				
			end
			MB.LastCommandUI=command
			return true  -- true = turn on UI
		else
			-- UI is already displayed...			
			-- Hide it if same Typ , or display other Type
			if MB.LastCommandUI == command then
				MBUI_Container:SetHidden(true)
				-- Turn On/Off Cursor Mode depending on Situation
				if  IsGameCameraUIModeActive() and not MB.CursorWasActive then
					SetGameCameraUIMode(false)
					MB.CursorWasActive = false					
				end			
				MB.LastCommandUI=command
				return false -- false = not turn on UI
			else
				MB.LastCommandUI=command
				return true  -- true = turn on UI
			end
		end
end

function MB.gcount()
	MB.GCountOnUpdateTimer=GetGameTimeMilliseconds()
	MB.GCountOnUpdateReady=true
end

function MB.MouseUp(self)
	local name = self:GetName()
    local left = self:GetLeft()
    local top = self:GetTop()

    if name=="MBUI_Menu" then
    	debug("Menu saved")
    	MB.params.MBUI_Menu={left,top}
    elseif name=="MBUI_Container" then
    	debug("Container saved")
    	MB.params.MBUI_Container={left,top}
    else
    	debug("Unknown window")
    end
end

function MB.LootRecieved(eventCode, receivedBy, itemName, quantity, itemSound, lootType, mine)
  debug("Event Loot Recieved fired")
  if (mine) then
     if (lootType == LOOT_TYPE_ITEM) then
        debug("objectName:" .. itemName)
        debug("stackCount:" .. tostring(quantity))   
<<<<<<< HEAD
        debug("recievedBy:" .. tostring(recievedBy))        
        local icon,sellPrice,meetsUsageRequirement,ItemType,_ = GetItemLinkInfo(itemName)                
        -- local level = 0
        local statValue = 0
        local quality = 0
        -- local id = 0
        local name = "Unknown"
        
        MB.SavePlayerInvent()
        
        local _, _, _, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(itemName)
                
        --local id=tonumber(itemName:MB_splitone(":",3)) -- string.sub(link,start,finish))
        --debug("ID: "..tostring(id))
        local level = 1
=======
        debug("recievedBy:" .. tostring(recievedBy))
        
        local icon,sellPrice,meetsUsageRequirement,ItemType,_ = GetItemLinkInfo(itemName)
                
        local level = 0
        local statValue = 0
        local quality = 0
        local id = 0
        local name = "Unknown"
        
        MB.SavePlayerInvent()
        local id=tonumber(itemName:MB_splitone(":",3)) -- string.sub(link,start,finish))
        debug("ID: "..tostring(id))
>>>>>>> origin/master
        
        for i=1,#MB.items.Chars[GetUnitName("player")] do
              local item = MB.items.Chars[GetUnitName("player")][i]
              if item.Id == id then
<<<<<<< HEAD
                    icon = item.icon
=======
>>>>>>> origin/master
                    name = item.ItemName
                    statValue = item.statValue
                    quality = item.quality
                    -- id = item.Id
                    level = item.Level
                    itemName = item.ItemLink
                    ItemType = item.ItemType
              end
        end
        
        MB.Loot[#MB.Loot+1] = {
          ["ItemLink"]=itemName,
          ["icon"] = tostring(icon),
          ["ItemName"]= name,
<<<<<<< HEAD
          ["Level"] = tonumber(level),
=======
          ["Level"] = level,
>>>>>>> origin/master
          ["stackCount"]=quantity,
          ["statValue"]=statValue,
          ["sellPrice"] = sellPrice,
          ["quality"] = quality,
          ["meetsUsageRequirement"]=meetsUsageRequirement,
          ["ItemType"]=ItemType,
          ["Id"]=id
        }       
     end    	
  end
end

function MB.SavePlayerInvent()
<<<<<<< HEAD
    
  debug("Save Player Invent: " .. GetTimeString())
	local bagIcon, bagSlots=GetBagInfo(BAG_BACKPACK)
  local equippeditems = 0
	MB.ItemCounter=0
  MB.SearchBuffer = {}
=======
	local bagIcon, bagSlots=GetBagInfo(BAG_BACKPACK)
	MB.ItemCounter=0
>>>>>>> origin/master
	debug("ThisCharName: "..tostring(MB.thisCharName))
	debug("Items in Table Chars:"..tostring(#MB.items.Chars[MB.thisCharName]))
	MB.items.Chars[MB.thisCharName]={}
	debug("Items in Table Chars after clean:"..tostring(#MB.items.Chars[MB.thisCharName]))
<<<<<<< HEAD

  -- Check Equipped Items
  
  local slots = {
   "HEAD",
   "CHEST",
   "SHOULDERS",
   "FEET",
   "HAND",
   "LEGS",
   "WAIST",
   "RING1",
   "RING2",
   "NECK",
   "COSTUME",
   "MAIN_HAND",
   "OFF_HAND",
   "BACKUP_MAIN",
   "BACKUP_OFF"
  }
  
  for k,v in pairs(slots) do
    if _G["EQUIP_SLOT_" .. v] then      
      local num = _G["EQUIP_SLOT_" .. v] 
      local icon,slotHasItem, sellPrice, isHeldSlot, isHeldNow, locked = GetEquippedItemInfo(num)
      if slotHasItem then        
        local _, stack, _, meetsUsageRequirement, _, equipType, itemStyle, quality = GetItemInfo(0,num)
        local name = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(0,num))
        local link = GetItemLink(0,num)
        local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(name).."|h")
        local statValue = GetItemStatValue(0,num)
        local ItemType=GetItemType(0,num)        
        local level = GetItemLevel(0,num)
        
      --  local level = GetItemLevel(0,num)
      
        -- local _, _, _, _, _, level, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(link)
          
        equippeditems = equippeditems+1
        
        if statValue == 0 then          
            statValue = tonumber(level)
            if not statValue then
              statValue = 1
            end
        end
        
      	MB.items.Chars[MB.thisCharName][#MB.items.Chars[MB.thisCharName]+1]={
				["ItemLink"]=tostring(clearlink),
				["icon"] = tostring(icon),
				["ItemName"] = name, -- GetItemName(0,num), -- tostring(name),
        ["Level"] = tonumber(level),
				["stackCount"]=stack,
				["statValue"]=statValue,
				["sellPrice"] = sellPrice,
				["quality"] = quality,
				["meetsUsageRequirement"]=meetsUsageRequirement,
				["ItemType"]=ItemType,
				["Id"]=id,
        ["Equipped"] = v
        }		
      end
    end
  end

=======

  -- Check Equipped Items
  
  local slots = {
   "HEAD",
   "CHEST",
   "SHOULDERS",
   "FEET",
   "HAND",
   "LEGS",
   "WAIST",
   "RING1",
   "RING2",
   "NECK",
   "COSTUME",
   "MAIN_HAND",
   "OFF_HAND",
   "BACKUP_MAIN",
   "BACKUP_OFF"
  }
  
  for k,v in pairs(slots) do
    if _G["EQUIP_SLOT_" .. v] then      
      local num = _G["EQUIP_SLOT_" .. v] 
      local icon,slotHasItem, sellPrice, isHeldSlot, isHeldNow, locked = GetEquippedItemInfo(num)
      if slotHasItem then        
        local _, stack, _, meetsUsageRequirement, _, equipType, itemStyle, quality = GetItemInfo(0,_G[num])
        local name = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(0,num))
        local link = GetItemLink(0,num)
        local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(name).."|h")
        local statValue = GetItemStatValue(0,num)
        local ItemType=GetItemType(0,num)        
        debug( v .. ":" ..name .. "," .. link)
        local level = GetItemLevel(0,num)
      
        if statValue == 0 then
            statValue = level
        end    
        
      	MB.items.Chars[MB.thisCharName][#MB.items.Chars[MB.thisCharName]+1]={
				["ItemLink"]=tostring(clearlink),
				["icon"] = tostring(icon),
				["ItemName"] = name, -- GetItemName(0,num), -- tostring(name),
        ["Level"] = level,
				["stackCount"]=stack,
				["statValue"]=statValue,
				["sellPrice"] = sellPrice,
				["quality"] = quality,
				["meetsUsageRequirement"]=meetsUsageRequirement,
				["ItemType"]=ItemType,
				["Id"]=id,
        ["Equipped"] = v
        }		
      end
    end
  end

>>>>>>> origin/master
    
	while (MB.ItemCounter < bagSlots) do
		if GetItemName(BAG_BACKPACK,MB.ItemCounter)~="" then

			--Избавляемся от мусора при сохранении
			local name = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(BAG_BACKPACK, MB.ItemCounter))
			local link = GetItemLink(BAG_BACKPACK,MB.ItemCounter)
			local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(name).."|h")

			local stackCount = GetSlotStackSize(BAG_BACKPACK,MB.ItemCounter)
			local statValue = GetItemStatValue(BAG_BACKPACK,MB.ItemCounter)
			local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyle, quality = GetItemInfo(BAG_BACKPACK,MB.ItemCounter)
			local ItemType=GetItemType(BAG_BACKPACK,MB.ItemCounter)
			-- local start,finish=string.find(link, "%d+")
<<<<<<< HEAD
			-- local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
          
      local level = GetItemLevel(BAG_BACKPACK,MB.ItemCounter)
      
      local _, _, _, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(link)
      
      if statValue == 0 then          
         statValue = tonumber(level)
         if not statValue then
            statValue = 1
         end
=======
			local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
          
      local level = GetItemLevel(BAG_BACKPACK,MB.ItemCounter)
      
      if statValue == 0 then
          statValue = level
>>>>>>> origin/master
      end
      
			MB.items.Chars[MB.thisCharName][#MB.items.Chars[MB.thisCharName]+1]={
				["ItemLink"]=tostring(clearlink),
				["icon"] = tostring(icon),
				["ItemName"]=name, -- GetItemName(BAG_BACKPACK, MB.ItemCounter), -- tostring(name),
<<<<<<< HEAD
        ["Level"] = tonumber(level),
=======
        ["Level"] = level,
>>>>>>> origin/master
				["stackCount"]=stackCount,
				["statValue"]=statValue,
				["sellPrice"] = sellPrice,
				["quality"] = quality,
				["meetsUsageRequirement"]=meetsUsageRequirement,
				["ItemType"]=ItemType,
				["Id"]=id
			}			
		end
		MB.ItemCounter=MB.ItemCounter+1
	end
	local itemsToCheck=bagSlots
	while not CheckInventorySpaceSilently(itemsToCheck) do
		itemsToCheck=itemsToCheck-1
	end
	MB.gold.Chars[MB.thisCharName].Current = GetCurrentMoney() 
	MB.items.Chars[MB.thisCharName].CurSlots=bagSlots-itemsToCheck
<<<<<<< HEAD
	MB.items.Chars[MB.thisCharName].MaxSlots=bagSlots+equippeditems
=======
	MB.items.Chars[MB.thisCharName].MaxSlots=bagSlots
>>>>>>> origin/master
end

function MB.Update(self)
if (not MB.AddonReady) then return end

	local EscMenuHidden = ZO_GameMenu_InGame:IsHidden()
	local interactHidden = ZO_InteractWindow:IsHidden()

	if (EscMenuHidden == false) then
		MBUI_Container:SetHidden(true)
		MBUI_Menu:SetHidden(true)
	elseif (interactHidden == false) then
		MBUI_Container:SetHidden(true)
		MBUI_Menu:SetHidden(true)
	elseif (MB.params.hidden==false) then
		MBUI_Menu:SetHidden(false)
	elseif (MB.params.hidden==true) then
		MBUI_Menu:SetHidden(true)
	end

	--Wait for Guild Bank to be Ready (EVENT fired) and then check for the Contents
	if MB.GCountOnUpdateReady and (GetGameTimeMilliseconds()-MB.GCountOnUpdateTimer>=1000) then
		MB.GCountOnUpdateReady=false
	    local guildbankid=GetSelectedGuildBankId() or 0
	    local guildname=tostring(GetGuildName(guildbankid)) or 0

	    if guildname=="" then d("Cannot save variables. Try again.") return end

	    MB.items.Guilds[guildname]={}
		debug("Data saved for "..guildname)
	      	
		local bagIcon, bagSlots=GetBagInfo(BAG_GUILDBANK)

		local sv = MB.items.Guilds[guildname]

		for i=1, #ZO_GuildBankBackpack.data do
			local slotIndex=ZO_GuildBankBackpack.data[i].data.slotIndex

			local link = GetItemLink(BAG_GUILDBANK,slotIndex)
			local iconFile=ZO_GuildBankBackpack.data[i].data.iconFile
			local name=ZO_GuildBankBackpack.data[i].data.name
			local stackCount=ZO_GuildBankBackpack.data[i].data.stackCount
			local statValue=ZO_GuildBankBackpack.data[i].data.statValue
			local sellPrice=ZO_GuildBankBackpack.data[i].data.sellPrice
			local quality=ZO_GuildBankBackpack.data[i].data.quality
			local meetsUsageRequirement=ZO_GuildBankBackpack.data[i].data.meetsUsageRequirement
			local ItemType=GetItemType(BAG_GUILDBANK,slotIndex)

			local clearlink =string.gsub(link, "|h.+|h", "|h"..tostring(name).."|h")
			-- start,finish=string.find(link, "%d+")
			-- id=tonumber(string.sub(link,start,finish))
     
<<<<<<< HEAD
      -- local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
    
      local level = GetItemLevel(BAG_GUILDBANK,slotIndex)
    
      local _, _, _, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,_ = ZO_LinkHandler_ParseLink(link)
      
      
      if statValue == 0 then          
          statValue = tonumber(level)
          if not statValue then
            statValue = 1
          end
      end
      
=======
      local id=tonumber(link:MB_splitone(":",3)) -- string.sub(link,start,finish))
    
      local level = GetItemLevel(BAG_GUILDBANK,slotIndex)
    
      if statValue == 0 then
          statValue = level
      end

>>>>>>> origin/master
			sv[#sv+1] = 
			{
				["ItemLink"] = tostring(clearlink),
				["icon"] = tostring(iconFile),
				["ItemName"] = name, -- GetItemName(BAG_GUILDBANK,slotIndex),-- tostring(name),
				["stackCount"] = stackCount,
        ["Level"] = level,
				["statValue"] = statValue,
				["sellPrice"] = sellPrice,
				["quality"] = quality,
				["meetsUsageRequirement"]=meetsUsageRequirement,
				["ItemType"]=ItemType,
				["Id"]=id

			}
			sv.CurSlots=#ZO_GuildBankBackpack.data
			sv.MaxSlots=bagSlots
		end
	end
end

function MB.HideContainer(value)
	debug("StartPrevious:"..tostring(MB.PreviousButtonClicked))
	debug("StartLast:"..tostring(MB.LastButtonClicked))
	if MB.PreviousButtonClicked==MB.LastButtonClicked then
		MBUI_Container:SetHidden(true)
		MB.PreviousButtonClicked=nil
		MB.LastButtonClicked=nil
	else
		MBUI_Container:SetHidden(false)
	end
	debug("FinishPrevious:"..tostring(MB.PreviousButtonClicked))
	debug("FinishLast:"..tostring(MB.LastButtonClicked))
end

function MB.CreateMBSearchBox()
    local parent = MBUI_Container
    local mb_search = WINDOW_MANAGER:CreateControl("MB_SEARCH_CONTROL",parent,CT_in2search)
    local controlName = "MB_SEARCH_CONTROL"
    mb_search:SetDimensions(parent:GetWidth()-5, 24)
    mb_search:SetMouseEnabled(true)
    mb_search:SetAnchor(TOPLEFT,parent,BOTTOMLEFT,5, 0)
    --mb_search:SetAnchor(TOPRIGHT,parent,BOTTOMRIGHT,0, 0)
    mb_search:SetHidden(false)
    --mb_search:SetInheritAlpha(false)

    mb_search.label = WINDOW_MANAGER:CreateControl(controlName .. "_Label", mb_search, CT_LABEL)
    local label = mb_search.label
    label:SetDimensions(70, 24)
    label:SetAnchor(LEFT)
    label:SetFont("ZoFontWinH4")
    label:SetText("Search:")

    mb_search.bg = WINDOW_MANAGER:CreateControlFromVirtual(controlName.."_BG", label, "ZO_EditBackdrop")
    local bg = mb_search.bg
    bg:SetDimensions(parent:GetWidth()-80,24)
    bg:SetAnchor(LEFT, label, RIGHT, 2, 0)
    bg:SetAnchor(TOPRIGHT, parent, BOTTOMRIGHT, -5, 0)
    mb_search.edit = WINDOW_MANAGER:CreateControlFromVirtual(controlName.."_Edit", bg, "ZO_DefaultEditForBackdrop")
    --mb_search.edit:SetText()
    --mb_search.edit:SetHandler("OnFocusLost", function(self) setFunc(self:SetText()) end)

    mb_search.tooltipText = "Search by name..."

    ZO_PreHookHandler(mb_search.edit, "OnTextChanged", function(self)
        local text = mb_search.edit:GetText()
		MB.SearchText = text
		MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
        -- InventoryInsight.IN2_UpdateScrollDataLinesData(text)
        -- InventoryInsight.IN2_UpdateIN2InventoryScroll()
    end)
    -- mb_search:SetHandler("OnMouseEnter", ZO_Options_OnMouseEnter)
    -- mb_search:SetHandler("OnMouseExit", ZO_Options_OnMouseExit)

    mb_search.ClearButton = WINDOW_MANAGER:CreateControl(mb_search:GetName().."ClearButton",mb_search,CT_TEXTURE)
    mb_search.ClearButton:SetDimensions(20,20)
    mb_search.ClearButton:SetDrawLevel(15)
    mb_search.ClearButton:SetDrawLayer(2)
    mb_search.ClearButton:SetAnchor(RIGHT,mb_search.edit,RIGHT,-5,0)
    mb_search.ClearButton:SetTexture("/esoui/art/buttons/cancel_up.dds")
    mb_search.ClearButton:SetTextureCoords(0,1,0,1)
    mb_search.ClearButton:SetMouseEnabled(true)
    mb_search.ClearButton:SetHandler("OnMouseEnter", function(control)
        control:SetTexture("/esoui/art/buttons/cancel_over.dds")
        InitializeTooltip(InformationTooltip, control, LEFT, 0, 0, 0)
        InformationTooltip:SetHidden(false)
        InformationTooltip:ClearLines()
        InformationTooltip:AddLine("Reset")
    end)
    mb_search.ClearButton:SetHandler("OnMouseExit", function(control)
        control:SetTexture("/esoui/art/buttons/cancel_up.dds")
        InformationTooltip:SetHidden(true)
        InformationTooltip:ClearLines()
    end)
    mb_search.ClearButton:SetHandler("OnMouseDown", function(control)
        control:SetTexture("/esoui/art/buttons/cancel_down.dds")
    end)    
    mb_search.ClearButton:SetHandler("OnMouseUp", function(control)
        control:SetTexture("/esoui/art/buttons/cancel_up.dds")
        control:GetParent().edit:SetText("")
		MB.SearchText = ""
        PlaySound(SOUNDS.DIALOG_DECLINE)
    end)

end

-- Testing with ZBS --------------------------
if ESOAddonDev then    
    dofile [[MobileBank\ZBS\MobileBankTests.lua]]
end
-----------------------------------------------
-- Register Event for OnLoad
EVENT_MANAGER:RegisterForEvent("MobileBank", EVENT_ADD_ON_LOADED, MB.OnLoad)
