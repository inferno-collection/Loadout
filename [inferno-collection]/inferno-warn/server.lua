-- Inferno Collection Warn - Version 1.0
--
-- Copyright (c) 2019, Christopher M, Inferno Collection. All rights reserved.
--
-- This project is licensed under the following:
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, and merge the software, under the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. THE SOFTWARE MAY NOT BE SOLD.
--

-- Issue a new warning
RegisterServerEvent("Warn:NewWarning")
AddEventHandler("Warn:NewWarning", function(ID, Details)
    -- Send warning to player
    TriggerClientEvent("Warn:Return:NewWarning", ID, Details)
end)

-- Whitelist check on server join
RegisterServerEvent("Warn:WhitelistCheck")
AddEventHandler("Warn:WhitelistCheck", function(Whitelist)
	for i in pairs(Whitelist.Command) do
		Whitelist.Command[i] = "pending"
	end
    -- Collect all the data from the whitelist.json file
    local Data = LoadResourceFile(GetCurrentResourceName(), "whitelist.json")
    -- If able to collect data
    if Data then
        -- Place the decoded whitelist into the array
        local Entries = json.decode(Data)

        -- Loop through the whitelist array
        for _, Entry in ipairs(Entries) do
            -- Check if the player exists in the array.
            if GetPlayerIdentifier(source):lower() == Entry.steamhex:lower() then
                -- Loop though all values in whitelist entry
                for i in pairs(Entry) do
                    -- If the value is not the player's steam hex
                    if i ~= "steamhex" then
                        -- If whitelist value is true, aka they have access to a command
                        if Entry[i] then
                            -- If command is a valid command
                            if Whitelist.Command[i] then
                                -- Allow player to use that command
                                Whitelist.Command[i] = true
                            -- If command is not valid
                            else
                                -- Print error message to server console
                                print("===================================================================")
                                print("==============================WARNING==============================")
                                print("/" .. i .. " is not a valid command, but is listed in ")
                                print(Entry.steamhex:lower() .. "'s whitelist entry. Please correct this")
                                print("issue. Note: Entries are CaSe SeNsItIvE.")
                                print("===================================================================")
                            end
                        end
                    end
                end
                -- Break the loop once whitelist entry found
                break
            end
        end
    -- If unable to load json file
    else
        -- Print error message to server console
        print("===================================================================")
        print("==============================WARNING==============================")
        print("Unable to load whitelist file for Inferno-Warn. The whitelist has b")
        print("een disabled. This message will appear every time someone joins the")
        print("server until the issue is corrected.")
        print("===================================================================")
        -- Loop through all commands
        for i in pairs(Whitelist.Command) do
            -- Grant players all permissions
            Whitelist.Command[i] = true
        end
    end

    -- Loop through all commands
    for i in pairs(Whitelist.Command) do
        -- If command is still pending
        if Whitelist.Command[i] == "pending" then
            -- Deny access
            Whitelist.Command[i] = false
        end
    end

	-- Return whietlist object to client
	TriggerClientEvent("Warn:Return:WhitelistCheck", source, Whitelist)
end)