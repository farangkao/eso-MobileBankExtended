MB.options = {}

MB.options.GetRealName = function (num)
    if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do
			if v.ID == num then
				return k
			end
		end
	end
	return ""
end

MB.options.GetRealGuildName = function (num)
    if MB.aliases and MB.aliases.Guilds then
		for k,v in pairs(MB.aliases.Guilds) do
			if v.ID == num then
				return k
			end
		end
	end
	return ""
end

MB.options.GetNumber = function(num)
	if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do
			if v.ID == num then
				if v.Order then
					return v.Order
				else
					return v.ID
				end
			end
		end		
	end
	return 0
end

MB.options.GetGuildNumber = function(num)
	if MB.aliases and MB.aliases.Guilds then
		for k,v in pairs(MB.aliases.Guilds) do
			if v.ID == num then
				if v.Order then
					return v.Order
				else
					return v.ID
				end
			end
		end		
	end
	return 0
end

MB.options.SetNumber = function(num,newnum)
	if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do
			if v.ID == num then
				v.Order = newnum
			end
		end		
	end
end

MB.options.SetGuildNumber = function(num,newnum)
	if MB.aliases and MB.aliases.Guilds then
		for k,v in pairs(MB.aliases.Guilds) do
			if v.ID == num then
				v.Order = newnum
			end
		end		
	end
end

 MB.options.IsCharacter = function (num)
    if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do
			if v.ID == num then
				return true
			end
		end
	end
	return false
end

 MB.options.IsGuild = function (num)
    if MB.aliases and MB.aliases.Guilds then
		for k,v in pairs(MB.aliases.Guilds) do
			if v.ID == num then
				return true
			end
		end
	end
	return false
end

MB.options.GetAliasName = function (num)
    if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do		    
			if v.ID == num then
				return v.Alias
			end
		end
	end
	return ""
end

MB.options.GetAliasGuildName = function (num)
    if MB.aliases and MB.aliases.Guilds then
		for k,v in pairs(MB.aliases.Guilds) do		    
			if v.ID == num then
				return v.Alias
			end
		end
	end
	return ""
end


MB.options.SetAliasName = function (num, text)
	if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do
			if v.ID == num then				
				v.Alias = text
				MB.UpdateBankAliases()
			end
		end
	end
end

MB.options.SetAliasGuildName = function (num, text)
	if MB.aliases and MB.aliases.Guilds then
		for k,v in pairs(MB.aliases.Guilds) do
			if v.ID == num then				
				v.Alias = text
				MB.UpdateBankAliases()
			end
		end
	end
end



MB.options.GetEditBox = function (num, isGuild)
	local editbox =  {
				type = "editbox",				
				tooltip = "Enter an Alias", 
				isMultiline = false,	--boolean
				width = "half",	--or "half" (optional)				
        }
        if isGuild then
            editbox.name = "Guild " .. num .. ": " .. MB.options.GetRealGuildName(num)
            editbox.getFunc = function() return MB.options.GetAliasGuildName(num) end
            editbox.setFunc = function(text)  MB.options.SetAliasGuildName(num,text) end
            editbox.default =  MB.options.GetRealGuildName(num)
            editbox.disabled = not MB.options.IsGuild(num)

        else
            editbox.name = "Char " .. num .. ": " .. MB.options.GetRealName(num)
            editbox.getFunc = function() return MB.options.GetAliasName(num) end
            editbox.setFunc = function(text)  MB.options.SetAliasName(num,text) end
            editbox.default =  MB.options.GetRealName(num)
            editbox.disabled = not MB.options.IsCharacter(num)
        end
	return editbox
end

MB.options.GetOrderBox = function (num, isGuild)
	local orderbox = {
				 type = "editbox",
				name = "Order (1-8)",
				tooltip = "Enter a Number from 1-8 to define the Order",				
				isMultiline = false,	--boolean
				width = "half",	--or "half" (optional)				
				default = tostring(num),	--(optional)				
      }
      
      if isGuild then
         orderbox.getFunc = function() return MB.options.GetGuildNumber(num) end
         orderbox.setFunc = function(text) 
                              MB.options.SetGuildNumber(num, tonumber(text))
                            end
         orderbox.disabled =  not MB.options.IsGuild(num)
       else
         orderbox.getFunc = function() return MB.options.GetNumber(num) end
         orderbox.setFunc = function(text) 
                              MB.options.SetNumber(num, tonumber(text))
                            end         
         orderbox.disabled =  not MB.options.IsCharacter(num)
       end
	return orderbox
end

MB.options.SetData = function()

    MB.options.panelData = {
	type = "panel",
	name = "Mobile Bank Extended",
	displayName = "Mobile Bank |cFFFF00Extended|r",
	author = "Farangkao",
	version = "1.1",
	-- slashCommand = "/mboptions",	--(optional) will register a keybind to open to this panel
	registerForRefresh = true,	--boolean (optional) (will refresh all options controls when a setting is changed and when the panel is shown)
	registerForDefaults = true,	--boolean (optional) (will set all options controls back to default values)
	}

	MB.options.optionsTable = {

	[1] = {
		type = "description",
		title = "Addon Help",	--(optional)		
		text = "Use |cFF00FF/mb|r for command line options. Due to API changes your data has been cleared with the last Update. If you notice problems try clear your Data.",
		width = "full",	--or "half" (optional)
	},
	[2] = {
		type = "description",	
		text = "Better set a new |cFF00FFKeybinding|r for at least one of the many possible views.",
		width = "full",	--or "half" (optional)
	},
	[3] = {
		type = "description",	
		text = "Once the Main Window is open you can also switch by clicking on the buttons on the |cFF00FFTop Left|r to switch to All Items,Inventories, Bank and Guilds or Recipes Views",
		width = "full",	--or "half" (optional)
	},
	[4] = {
				type = "checkbox",
				name = "Show Mobile Bank Menu Area",
				tooltip = "This is the old way of Starting Mobile Bank Window. It's better to bind a Key to open it with the Extended version",
				getFunc = function() return not MB.params.hidden end,
				setFunc = function(value) 
					--	debug("checkbox:" .. tostring(value))
						MB.params.hidden= not value
						MBUI_Menu:SetHidden(not value)
						end,
				-- width = "half",	--or "half" (optional)
				-- warning = "Will need to reload the UI.",	--(optional)
			},
  [5] = {
				type = "checkbox",
				name = "Show Debug Text in Chat Window",
				tooltip = "This option is only useful if there is any problems. The output will help to find problems",
				getFunc = function() return (MB.Debug) end,
				setFunc = function(value) 					
                    MB.Debug = value						
                  end,				
				warning = "Will turn off automatically after ReloadUI or logoff",	--(optional)
			},
	[6] = {
			type = "button",
			name = "Reset Data",
			-- tooltip = "Reset aButton's tooltip text.",
		func = function() 
			MB.commandHandler( "cls" )
		end,
		width = "half",	--or "half" (optional)
		warning = "This will reload the UI and you will need to login to every character to rebuild the Data after this",	--(optional)
	
	},
	[7] = {
		type = "submenu",
		name = "Characters",
		tooltip = "Reorder Display of Characters and set Aliases",	--(optional)
		controls = {
			[1] =  MB.options.GetEditBox(1),
			[2] = MB.options.GetOrderBox(1),
			[3] = MB.options.GetEditBox(2),
			[4] = MB.options.GetOrderBox(2),
			[5] = MB.options.GetEditBox(3),
			[6] = MB.options.GetOrderBox(3),
			[7] = MB.options.GetEditBox(4),
			[8] = MB.options.GetOrderBox(4),
			[9] = MB.options.GetEditBox(5),
			[10] = MB.options.GetOrderBox(5),
			[11] = MB.options.GetEditBox(6),
			[12] = MB.options.GetOrderBox(6),
			[13] = MB.options.GetEditBox(7),
			[14] = MB.options.GetOrderBox(7),
			[15] = MB.options.GetEditBox(8),
			[16] = MB.options.GetOrderBox(8),
			[17] = {
						type = "button",
						name = "Apply Changes",
            tooltip = "For Alias Changes just press ESC twice. The Order changes are only applied when using Logoff or Reload the UI",						
						func = function()
							ReloadUI()													
						end,
						width = "half",	--or "half" (optional)
						warning = "This will reload the UI to apply Order Changes",	--(optional)
	
			},
			},
		},
  	[8] = {
		type = "submenu",
		name = "Guilds",
		tooltip = "Reorder Display of Guilds and set Aliases",	--(optional)
		controls = {
			[1] =  MB.options.GetEditBox(1,true),
			[2] = MB.options.GetOrderBox(1,true),
			[3] = MB.options.GetEditBox(2,true),
			[4] = MB.options.GetOrderBox(2,true),
			[5] = MB.options.GetEditBox(3,true),
			[6] = MB.options.GetOrderBox(3,true),
			[7] = MB.options.GetEditBox(4,true),
			[8] = MB.options.GetOrderBox(4,true),
			[9] = MB.options.GetEditBox(5,true),
			[10] = MB.options.GetOrderBox(5,true),
			[11] = {
						type = "button",
						name = "Apply Changes",
						tooltip = "For Alias Changes just press ESC twice. The Order changes are only applied when using Logoff or Reload the UI",
						func = function()
							ReloadUI()													
						end,
						width = "half",	--or "half" (optional)
						warning = "This will reload the UI to apply Order Changes",	--(optional)
	
			},
			},
		},

	}
end


print (MB)


