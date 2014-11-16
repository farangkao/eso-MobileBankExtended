	
  
function string:MB_split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end

function string:MB_splitone(sep, num)
  local t = self:MB_split(sep)
  if #t > num then
    return t[num]
  else
    return ""
  end
end

function string:MB_starts(start)
   return string.sub(self,1,string.len(start))==start
end


MB_Util = {
  -- Retrieve alias Name from MB.aliases.Chars
   SortOrder = "Name",
   GetAliasName = function(self,name)
     local alias = name      
      if MB and MB.aliases and MB.aliases.Chars then               
        for k,v in pairs(MB.aliases.Chars) do                    
            if k == name then
              alias=v.Alias
            end
        end
      end
      return alias      
   end,
   
   GetAliasGuildName = function(self,name)
     local alias = name      
      if MB and MB.aliases and MB.aliases.Guilds then               
        for k,v in pairs(MB.aliases.Guilds) do                    
            if k == name then
              alias=v.Alias
            end
        end
      end
      return alias      
   end,
   
   ShallowCopyTable = function(self,t)   
      local t2 = {}
        for i=1,#t do
          t2[i] = {}
          for k,v in pairs(t[i]) do
            t2[i][k] = v
          end
        end
      return t2
   end,
   
   ShallowCopyTableValues = function(self,t)   
      local t2 = {}
        for k,v in pairs(t) do
          t2[k] = v
        end
      return t2
   end,
   
   GetCurrentCharInv = function(self)
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
   end,
   
   MergeTables = function(self,in_main,in_add,identifier)
     local newt = {}
     local main = self:ShallowCopyTable(in_main)
     local add = self:ShallowCopyTable(in_add)
     -- d("MergeTables " .. identifier)
     
     if #main == 0 then
        -- d("Return original!")
        return add
     end 
     -- d("Table1:" ..tostring(#main))
     -- d("Table2:" ..tostring(#add))
     -- first we need to find possible duplicated itemlinks...
     for i=1,#main do
        local dupl = false
        local stackCount = main[i].stackCount
        --[[
        if main[i].Id then
         -- if main[i].Id == 0 then
            -- d("ID is 0")
         --  end
        elseif identifier then
          d("ID is nil from " .. identifier .. " : " .. main[i].ItemName)
        else
          d("ID is nil no identifier :" .. main[i].ItemName)
        end
        --]]
        if main[i].Id then          
          for k=1,#add do              
            if main[i].ItemName == add[k].ItemName and main[i].statValue == add[k].statValue then
               dupl = true
               if main[i].ItemName == "Orichalcum Ingot" then
                 -- d("Iron Ingot: " .. tostring(main[i].stackCount) .. " / " .. tostring(add[k].stackCount) .. " ( " .. tostring(stackCount) .. ")")
                end
               stackCount = stackCount + add[k].stackCount
            end              
          end
          if dupl then
            -- d("Dupl: " .. main[i].ItemName .. " (" .. stackCount .. " / " .. main[i].stackCount .. ")")
            local tbltemp = self:ShallowCopyTableValues(main[i])
            tbltemp.stackCount = stackCount -- main[i].stackCount +
            newt[#newt+1] = tbltemp
            -- newt[#newt].stackCount = main[i].stackCount + stackCount            
          else -- not duplicate just copy
            newt[#newt+1] = self:ShallowCopyTableValues(main[i])
          end
        end
     end
     for i=1,#add do
        local dupl = false
        local dplind = 0
        for k=1,#newt do            
            if (add[i].ItemName == newt[k].ItemName and add[i].statValue == newt[k].statValue) then  
                dplind = k
               dupl = true                 
            end            
        end
        if not dupl then      
          if add[i].ItemName == "Orichalcum Ingot" then
            -- d("Orichalcum Ingot (new): " .. tostring(add[i].stackCount))
          end
          newt[#newt+1] = self:ShallowCopyTableValues(add[i])
        else 
          if add[i].ItemName == "Orichalcum Ingot" then
            -- d("Orichalcum Ingot (add): " .. tostring(add[i].stackCount))
            if dplind > 0 then
              newt[dplind].stackCount = newt[dplind].stackCount + add[i].stackCount
            end
          end
        end       
     end
     -- d("Merged Table Size: " .. tostring(#newt))
     return newt
    end,
    
    SetSort = function(self, button)
      if button then        
        MBUI_ContainerTitleName:SetState(0)
        MBUI_ContainerTitleStat:SetState(0)
        MBUI_ContainerTitleValue:SetState(0)
        button:SetState(1)
        self.SortOrder = button:GetName():gsub("MBUI_ContainerTitle","")
        MB.SortPreparedValues()
        MB.FilterBank(MB.CurrentLastValue,MB.CurrentFilterType,MB.SearchText)
      end      
    end,
    
    SubFilterOnShow = function(self,control)
          MBUI_ContainerTitleFilterSubFilter1:SetState(1)
          -- d("SubFilterOnShow")
          local num = control:GetName():gsub("MBUI_ContainerTitleFilterSubFilter","")
          local texture = [[EsoUI/Art/Progression/progression_crafting_delevel_down.dds]]
          local text = "unknown"
          -- d("MB.CurrentFilterType : " ..tostring(MB.CurrentFilterType))
          if MB.CurrentFilterType == "Weapon" then
            if num == "1" then
              texture = [[EsoUI/Art/Inventory/inventory_tabIcon_all_up.dds]]
              text = "All Weapons"
            elseif num == "2" then 
              texture = [[EsoUI/Art/Progression/icon_dualwield.dds]]
              text = "Dual Wield"
            elseif num == "3" then 
              texture = [[EsoUI/Art/Progression/icon_2handed.dds]]  
              text = "Two Handed"
            elseif num == "4" then 
              texture = [[EsoUI/Art/Progression/icon_bows.dds]]
              text = "Bow"
            elseif num == "5" then 
              texture = [[EsoUI/Art/Progression/icon_firestaff.dds]]
              text = "Destruction Staff"
            elseif num == "6" then 
              texture = [[EsoUI/Art/Progression/icon_healstaff.dds]]
              text = "Healing Staff"
            elseif num == "7" then
              texture = [[EsoUI/Art/Progression/progression_indexicon_weapons_up.dds]]
              text = "Shield"
            elseif num == "8" then
              texture = [[EsoUI/Art/Progression/progression_tabicon_passive_active.dds]]
              text = "Special"
            end
          elseif MB.CurrentFilterType == "Apparel" then
            if num == "1" then
              texture = [[EsoUI/Art/Inventory/inventory_tabIcon_all_up.dds]]
              text = "All Apparel"
            elseif num == "2" then 
              texture = [[EsoUI/Art/Progression/progression_indexicon_armor_up.dds]]
              text = "Heavy"              
            elseif num == "3" then 
              texture = [[EsoUI/Art/Campaign/overview_indexicon_scoring_up.dds]]  
              text = "Medium"
            elseif num == "4" then 
              texture = [[EsoUI/Art/CharacterCreate/charactercreate_bodyicon_up.dds]]
              text = "Light"
            elseif num == "5" then
              control:SetHidden(true)
            elseif num == "6" then
              control:SetHidden(true)                           
            elseif num == "7" then
              control:SetHidden(true)                            
            elseif num == "8" then
              control:SetHidden(true)
            end
          elseif MB.CurrentFilterType == "Consumable" then
            if num == "1" then
              texture = [[EsoUI/Art/Inventory/inventory_tabIcon_all_up.dds]]
              text = "All Consumable"
            elseif num == "2" then 
              texture = [[EsoUI/Art/Crafting/provisioner_indexicon_beer_up.dds]]
              text = "Food & Drink"              
            elseif num == "3" then 
              texture = [[EsoUI/Art/Inventory/inventory_consumables_tabicon_active.dds]]  
              text = "Potion"
            elseif num == "4" then 
              texture = [[EsoUI/Art/Progression/progression_tabicon_passive_active.dds]]
              text = "Special"
            elseif num == "5" then
              control:SetHidden(true)
            elseif num == "6" then
              control:SetHidden(true)                           
            elseif num == "7" then
              control:SetHidden(true)                            
            elseif num == "8" then
              control:SetHidden(true)
            end       
          elseif MB.CurrentFilterType == "Materials" then
            if num == "1" then
              texture = [[EsoUI/Art/Inventory/inventory_tabIcon_all_up.dds]]
              text = "All Materials"
            elseif num == "2" then 
              texture = [[EsoUI/Art/Crafting/smithing_tabicon_armorset_up.dds]]
              text = "Blacksmithing"              
            elseif num == "3" then 
              texture = [[EsoUI/Art/Worldmap/map_ava_tabicon_woodmill_up.dds]]  
              text = "Woodworking"
            elseif num == "4" then 
              texture = [[EsoUI/Art/Worldmap/map_indexicon_locations_up.dds]]
              text = "Clothier"
            elseif num == "5" then
              texture = [[EsoUI/Art/Crafting/enchantment_tabicon_aspect_up.dds]]
              text = "Enchanting"
            elseif num == "6" then
              texture = [[EsoUI/Art/Crafting/alchemy_tabicon_solvent_up.dds]]
              text = "Alchemy"
            elseif num == "7" then
              texture = [[EsoUI/Art/Crafting/provisioner_indexicon_meat_up.dds]]
              text = "Provisioning"          
            elseif num == "8" then
              texture = [[EsoUI/Art/Crafting/smithing_tabicon_research_up.dds]]
              text = "Traits, Styles"          
            end              
          elseif MB.CurrentFilterType == "Miscellaneous" then
            if num == "1" then
              texture = [[EsoUI/Art/Inventory/inventory_tabIcon_all_up.dds]]
              text = "All Miscellaneous"
            elseif num == "2" then 
              texture = [[EsoUI/Art/MainMenu/menubar_skills_up.dds]]
              text = "Glyphs"              
            elseif num == "3" then 
              texture = [[EsoUI/Art/Campaign/campaign_tabicon_leaderboard_up.dds]]  
              text = "Trophy"
            elseif num == "4" then 
              texture = [[EsoUI/Art/Campaign/campaignbrowser_indexicon_normal_up.dds]]
              text = "AVA"
            elseif num == "5" then
              texture = [[EsoUI/Art/Progression/progression_tabicon_passive_active.dds]]
              text = "Special"
            elseif num == "6" then
              control:SetHidden(true)                           
            elseif num == "7" then
              control:SetHidden(true)                            
            elseif num == "8" then
              control:SetHidden(true)
            end                                    
          end    
          control.ToolTipText = text
          control:SetNormalTexture(texture)
          control:SetMouseOverTexture(texture)
          control:SetPressedTexture(texture)    
    end,
     
      
 }
 
 if not GetBagInfo then  -- checking if Function GetBagInfo still exists...
     -- v1.2
		-- local bagIcon, bagSlots=GetBagInfo(BAG_BANK)
    -- v1.3
    -- local bagSlots = GetBagSize(BAG_BANK)
    GetBagInfo = function(bagtype)
        return nil,GetBagSize(bagtype)
      end
 end

 
