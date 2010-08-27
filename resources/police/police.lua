--[[
Copyright (c) 2010 MTA: Paradise

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
]]

addCommandHandler( { "policeduty", "duty" },
	function( thePlayer, commandName )
		if exports.players:isLoggedIn( thePlayer ) then
			local inPD, factionID, factionName, factionTag = exports.factions:isPlayerInFactionType( thePlayer, 1 )
			if inPD and factionTag then
				local thePlayer = tonumber( thePlayer )
				giveWeapon ( thePlayer, 24, 500, false )
			else
				outputChatBox( "(( You are not in a Government faction. ))", thePlayer, 255, 0, 0 )
			end
		end
	end
)