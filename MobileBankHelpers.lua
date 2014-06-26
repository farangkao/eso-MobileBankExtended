 	
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
   
   MergeTables = function(self,in_main,in_add,identifier)
     local newt = {}
     local main = self:ShallowCopyTable(in_main)
     local add = self:ShallowCopyTable(in_add)
     if #main == 0 then
        return add
     end 
     -- d("Table1:" ..tostring(#main))
     -- d("Table2:" ..tostring(#add))
     -- first we need to find possible duplicated itemlinks...
     for i=1,#main do
        local dupl = false
        local stackCount = 0
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
               -- d("It's a dub")
               stackCount = add[k].stackCount
            end              
          end
          if dupl then
            -- d("Dupl: " .. main[i].ItemName .. " (" .. stackCount .. " / " .. main[i].stackCount .. ")")
            newt[#newt+1] = self:ShallowCopyTableValues(main[i])
            newt[#newt].stackCount = main[i].stackCount + stackCount
          else -- not duplicate just copy
            newt[#newt+1] = self:ShallowCopyTableValues(main[i])
          end
        end
     end
     for i=1,#add do
        local dupl = false
        for k=1,#newt do            
            if (add[i].ItemName == newt[k].ItemName and add[i].statValue == newt[k].statValue) then  
               dupl = true                 
            end            
        end
        if not dupl then          
          newt[#newt+1] = self:ShallowCopyTableValues(add[i])
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
      
   
 }
 
