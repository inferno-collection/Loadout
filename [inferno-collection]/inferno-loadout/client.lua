-- Inferno Collection Loadout - Version 1.0
--
-- Copyright (c) 2019, Christopher M, Inferno Collection. All rights reserved.
--
-- This project is licensed under the following:
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, and merge the software, under the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. THE SOFTWARE MAY NOT BE SOLD.
--

-- Weapon list
-- https://forum.fivem.net/t/list-of-weapon-spawn-names-after-hours/90750
local Weapons = {
    -- Combat Pistol
    "WEAPON_COMBATPISTOL",
    -- Tazer
    "WEAPON_STUNGUN",
    -- Baton
    "WEAPON_NIGHTSTICK",
    -- Flashlight
    "WEAPON_FLASHLIGHT",
    -- Pump Shotgun
    "WEAPON_PUMPSHOTGUN",
    -- Carbine Rifle
    "WEAPON_CARBINERIFLE"
}

-- When the client joins the server
AddEventHandler("onClientMapStart", function()
    -- Add command chat suggestion
    TriggerEvent("chat:addSuggestion", "/loadout", "Provides you with your loadout.")
end)

-- Command instead of menu for demonstration purposes
RegisterCommand("loadout", function()
    -- Gets the player's ped
    local ped = GetPlayerPed(-1)
    -- Loop though all items in array
    -- #{array} returns the number of entires an array
    for i = #Weapons, 1, -1 do
		-- Give the ped the weapon
        GiveWeaponToPed(ped, GetHashKey(Weapons[i]), 100, false, true)
    end
end)