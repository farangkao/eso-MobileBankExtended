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

MB.options.SetNumber = function(num,newnum)
	if MB.aliases and MB.aliases.Chars then
		for k,v in pairs(MB.aliases.Chars) do
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

MB.options.GetEditBox = function (num)
	editbox =  {
				type = "editbox",
				name = "Char " .. num .. ": " .. MB.options.GetRealName(num),
				tooltip = "Enter an Alias", 
				getFunc = function() return MB.options.GetAliasName(num) end,
				setFunc = function(text)  MB.options.SetAliasName(num,text) end,
				isMultiline = false,	--boolean
				width = "half",	--or "half" (optional)				
				default =  MB.options.GetRealName(num),	--(optional)
				disabled = not MB.options.IsCharacter(num)
			    }
	return editbox
end

MB.options.GetOrderBox = function (num)
	orderbox = {
				 type = "editbox",
				name = "Order (1-8)",
				tooltip = "Enter a Number from 1-8 to define the Order",
				getFunc = function() return MB.options.GetNumber(num) end,
				setFunc = function(text) 
					 MB.options.SetNumber(num, tonumber(text))
				end,
				isMultiline = false,	--boolean
				width = "half",	--or "half" (optional)				
				default = tostring(num),	--(optional)
				disabled =  not MB.options.IsCharacter(num)
				}
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
		text = "Use |cFF00FF/mb|r for command line options",
		width = "full",	--or "half" (optional)
	},
	[2] = {
		type = "description",	
		text = "Better set a new |cFF00FFKeybinding|r for at least one of the 3 possible views.",
		width = "full",	--or "half" (optional)
	},
	[3] = {
		type = "description",	
		text = "Once the Main Window is open you can also switch by clicking on |cFF00FF[I] [B] [G]|r to switch to Inventories, Bank and Guilds Views",
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
			type = "button",
			name = "Reset Data",
			-- tooltip = "Reset aButton's tooltip text.",
		func = function() 
			MB.commandHandler( "cls" )
		end,
		width = "half",	--or "half" (optional)
		warning = "This will reload the UI and you will need to login to every character to rebuild the Data after this",	--(optional)
	
	},
	[6] = {
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
						tooltip = "The Ordering is only applied when using Logoff or Reload the UI",
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


