-- Inferno Collection Warn - Version 1.0
--
-- Copyright (c) 2019, Christopher M, Inferno Collection. All rights reserved.
--
-- This project is licensed under the following:
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, and merge the software, under the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. THE SOFTWARE MAY NOT BE SOLD.
--

-- Local whitelist variable
local Whitelist = {}
-- Whitelist variable for commands
Whitelist.Command = {}
-- Boolean for whether player is whitelisted for warn command
Whitelist.Command.warn = false

-- On client join server
AddEventHandler("onClientMapStart", function()
    -- Ask server to check whitelist for this client
    TriggerServerEvent("Warn:WhitelistCheck", Whitelist)
end)

-- Return from whitelist check
RegisterNetEvent("Warn:Return:WhitelistCheck")
AddEventHandler("Warn:Return:WhitelistCheck", function(NewWhitelist)
	-- Update local whitelist values with server ones
	Whitelist = NewWhitelist
end)

-- /warn <player id> {optional message}
-- Used to enable and disable pager, and set tones to be tuned to
RegisterCommand("warn", function(source, Args)
    -- Variables
    local ID
    local Details = ""
    -- If this player has access to this command
    if Whitelist.Command.warn then
        -- If a player ID is provided, and it is a number
        if Args[1] and tonumber(Args[1]) then
            -- Set local ID var to the player ID
            ID = Args[1]
            -- If details provided
            if Args[2] then
                -- Remove player ID from details
                table.remove(Args, 1)
                -- Loop though details (each word is an element)
				for _, l in ipairs(Args) do
					-- Add word to variable
					Details = Details .. " " .. l
				end
                -- Add issuer's name
                Details = Details .. " - Warning issued by " .. GetPlayerName(PlayerId())
            -- If no details provided
            else
                -- Set default details
                Details = "You received a warning from " .. GetPlayerName(PlayerId())
            end

            -- Send warning to server
            TriggerServerEvent("Warn:NewWarning", ID, Details)
        -- If no player ID provided, or provided ID is not a number
        else
            -- Send error notification
            NewNoti("No or invalid player ID provided!", true)
        end
    -- If player does not have access to the command
    else
        -- Send error notification
        NewNoti("Access denied to this command.", true)
    end
end)

-- Return from whitelist check
RegisterNetEvent("Warn:Return:NewWarning")
AddEventHandler("Warn:Return:NewWarning", function(Details)
	-- Send message to chat, only warned player can see message
    TriggerEvent("chat:addMessage", {
        -- Red
        color = { 255, 0, 0},
        -- Allow multiline
        multiline = true,
        -- Message
        args = {"Warning", Details}
    })
end)

-- Draws notification on client's screen
function NewNoti(Text, Flash)
	-- Tell GTA that a string will be passed
	SetNotificationTextEntry("STRING")
	-- Pass temporary variable to notification
	AddTextComponentString(Text)
	-- Draw new notification on client's screen
	DrawNotification(Flash, true)
end