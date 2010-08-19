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

-- getPlayerName with spaces instead of _ for player names
local _getPlayerName = getPlayerName
local getPlayerName = function( x ) return _getPlayerName( x ):gsub( "_", " " ) end

-- addCommandHandler supporting arrays as command names (multiple commands with the same function)
local addCommandHandler_ = addCommandHandler
      addCommandHandler  = function( commandName, fn, restricted, caseSensitive )
	-- add the default command handlers
	if type( commandName ) ~= "table" then
		commandName = { commandName }
	end
	for key, value in ipairs( commandName ) do
		if key == 1 then
			addCommandHandler_( value, fn, restricted, caseSensitive )
		else
			addCommandHandler_( value,
				function( player, ... )
					-- check if he has permissions to execute the command, default is not restricted (aka if the command is restricted - will default to no permission; otherwise okay)
					if hasObjectPermissionTo( player, "command." .. commandName[ 1 ], not restricted ) then
						fn( player, ... )
					end
				end
			)
		end
	end
end

-- returns all players within <range> units away <from>
local function getPlayersInRange( from, range )
	local x, y, z = getElementPosition( from )
	local dimension = getElementDimension( from )
	local interior = getElementInterior( from )
	
	local t = { }
	for key, value in ipairs( getElementsByType( "player" ) ) do
		if getElementDimension( value ) == dimension and getElementInterior( value ) == interior then
			local distance = getDistanceBetweenPoints3D( x, y, z, getElementPosition( value ) )
			if distance < range then
				t[ value ] = range
			end
		end
	end
	return t
end

-- sends a ranged message
local function localMessage( from, message, r, g, b, range, r2, g2, b2 )
	range = range or 20
	r2 = r2 or r
	g2 = g2 or g
	b2 = b2 or b
	
	for player, distance in pairs( getPlayersInRange( from, range ) ) do
		outputChatBox( message, player, r2 + ( r - r2 ) * 1 - ( distance / range ), g2 + ( g - g2 ) * 1 - ( distance / range ), b2 + ( b - b2 ) * 1 - ( distance / range ) )
	end
end

-- exported function to send fake-me's
function me( source, message, prefix )
	if isElement( source ) and getElementType( source ) == "player" and type( message ) == "string" then
		local message = ( prefix or "" ) .. " *" .. getPlayerName( source ) .. ( message:sub( 1, 2 ) == "'s" and "" or " " ) .. message
		localMessage( source, message, 255, 40, 80 )
		exports.server:message( "%C04[" .. exports.players:getID( source ) .. "]" .. message .. "%C" )
		return true
	else
		return false
	end
end

-- faction chat
local function faction( player, factionID, message )
	if factionID then
		local tag = exports.factions:getFactionTag( factionID )
		exports.factions:sendMessageToFaction( factionID, "(( " .. tag .. " )) " .. getPlayerName( player ) .. ": " .. message, 127, 127, 255 )
	end
end

-- overwrite MTA's default chat events
addEventHandler( "onPlayerChat", getRootElement( ),
	function( message, type )
		cancelEvent( )
		if exports.players:isLoggedIn( source ) and not isPedDead( source ) then
			if type == 0 then
				localMessage( source, " " .. getPlayerName( source ) .. " says: " .. message, 230, 230, 230, false, 127, 127, 127 )
				exports.server:message( "%C04[" .. exports.players:getID( source ) .. "]%C  " .. getPlayerName( source ) .. " says: " .. message )
			elseif type == 1 then
				me( source, message )
			elseif type == 2 then
				faction( source, exports.factions:getPlayerFactions( source )[ 1 ], message )
			end
		end
	end
)

for i = 1, 10 do
	addCommandHandler( "f" .. ( i > 1 and i or "" ),
		function( thePlayer, commandName, ... )
			if exports.players:isLoggedIn( thePlayer ) then
				local factionID = exports.factions:getPlayerFactions( thePlayer )[ i ]
				if factionID then
					local message = table.concat( { ... }, " " )
					if #message > 0 then
						faction( thePlayer, factionID, message )
					else
						outputChatBox( "Syntax: /" .. commandName .. " [ooc faction text]", thePlayer, 255, 255, 255 )
					end
				end
			end
		end
	)
end

-- /do
addCommandHandler( "do", 
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				localMessage( thePlayer, " *" .. message .. " ((" .. getPlayerName( thePlayer ) .. "))", 255, 40, 80 )
				exports.server:message( "%C04[" .. exports.players:getID( thePlayer ) .. "] *" .. message .. " ((" .. getPlayerName( thePlayer ) .. "))" )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [in character text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /c
addCommandHandler( "c", 
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				localMessage( thePlayer, " " .. getPlayerName( thePlayer ) .. " whispers: " .. message, 255, 255, 255, 3 )
				exports.server:message( "%C04[" .. exports.players:getID( thePlayer ) .. "]%C15  " .. getPlayerName( thePlayer ) .. " whispers: " .. message .. "%C" )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [local ic text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /s(hout)
addCommandHandler( { "s", "shout" }, 
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				local message = " " .. getPlayerName( thePlayer ) .. " shouts: " .. message .. ( message:sub( #message ) ~= "." and message:sub( #message ) ~= "!" and message:sub( #message ) ~= "?" and "!" or "" )
				localMessage( thePlayer, message, 255, 255, 255, 40 )
				exports.server:message( "%C04[" .. exports.players:getID( thePlayer ) .. "]%C " .. message )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [local ic text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /my
addCommandHandler( "my", 
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				me( thePlayer, "'s " .. message )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [in character text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /b; bound to 'b' client-side
addCommandHandler( { "b", "LocalOOC" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				localMessage( thePlayer, getPlayerName( thePlayer ) ..  ": (( " .. message .. " ))", 196, 255, 255 )
				exports.server:message( "%C04[" .. exports.players:getID( thePlayer ) .. "]%C12  " .. getPlayerName( thePlayer ) .. ": (( " .. message .. " ))%C" )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [local ooc text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /o; bound to 'o' client-side
addCommandHandler( { "o", "GlobalOOC" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				outputChatBox( "(( " .. getPlayerName( thePlayer ) ..  ": " .. message .. " ))", root, 196, 255, 255 )
				exports.server:message( "%C04[" .. exports.players:getID( thePlayer ) .. "]%C12  (( " .. getPlayerName( thePlayer ) .. ": " .. message .. " ))%C" )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [local ooc text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( { "announce", "ann" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				outputChatBox( "*** " .. message .. " ***", root, 0, 255, 153 )
				exports.server:message( "%C03[" .. exports.players:getID( thePlayer ) .. "] Announcement by " .. getPlayerName( thePlayer ) .. ": " .. message .. "%C" )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [text]", thePlayer, 255, 255, 255 )
			end
		end
	end,
	true
)

addCommandHandler( { "adminchat", "a" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				message = getPlayerName( thePlayer ) .. ": " .. message
				local groups = exports.players:getGroups( thePlayer )
				if groups and #groups >= 1 then
					message = groups[1].displayName .. " " .. message
				end
				
				for key, value in ipairs( getElementsByType( "player" ) ) do
					if hasObjectPermissionTo( value, "command.adminchat", false ) then
						outputChatBox( message, value, 255, 255, 91 )
					end
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [text]", thePlayer, 255, 255, 255 )
			end
		end
	end,
	true
)

addCommandHandler( { "modchat", "m" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				message = getPlayerName( thePlayer ) .. ": " .. message
				local groups = exports.players:getGroups( thePlayer )
				if groups and #groups >= 1 then
					message = groups[1].displayName .. " " .. message
				end
				
				for key, value in ipairs( getElementsByType( "player" ) ) do
					if hasObjectPermissionTo( value, "command.modchat", false ) then
						outputChatBox( message, value, 255, 255, 191 )
					end
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [text]", thePlayer, 255, 255, 255 )
			end
		end
	end,
	true
)

-- /ad to send a global advertisement
addCommandHandler( { "ad", "advertisement" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				if exports.players:takeMoney( thePlayer, 3 ) then
					outputChatBox( "[AD] (( " .. getPlayerName( thePlayer ) ..  " )) " .. message .. ".", root, 106, 255, 255 )
				else
					outputChatBox( "You don't have enough money for this advertisement.", thePlayer, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [advertisement]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /sr SAN radio chat
addCommandHandler( { "sr", "san" },
	function( thePlayer, commandName, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				outputChatBox( "[SAN] " .. getPlayerName( thePlayer ) ..  " says: " .. message, root, 62, 184, 255 )
			else
				outputChatBox( "Syntax: /" .. commandName .. " [radio message]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

-- /pm to message other players
local function pm( player, target, message )
	outputChatBox( "PM to [" .. exports.players:getID( target ) .. "] " .. getPlayerName( target ) .. ": " .. message, player, 255, 255, 0 )
	outputChatBox( "PM from [" .. exports.players:getID( player ) .. "] " .. getPlayerName( player ) .. ": " .. message, target, 255, 255, 0 )
end

addCommandHandler( "pm",
	function( thePlayer, commandName, otherPlayer, ... )
		if exports.players:isLoggedIn( thePlayer ) then
			if otherPlayer and ( ... ) then
				local message = table.concat( { ... }, " " )
				local player, name = exports.players:getFromName( thePlayer, otherPlayer )
				if player then
					pm( thePlayer, player, message )
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [player] [ooc text]", thePlayer, 255, 255, 255 )
			end
		end
	end
)

addEventHandler( "onPlayerPrivateMessage", root,
	function( message, recipent )
		if exports.players:isLoggedIn( thePlayer ) and exports.players:isLoggedIn( recipent ) then
			pm( source, recipent, message )
		end
		cancelEvent( )
	end
)

-- /dice
addCommandHandler( "dice", 
	function( thePlayer, commandName )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			me( thePlayer, "rolls a dice. It shows " .. math.random( 6 ) .. ".", "(Dice)" )
		end
	end
)

-- /coin
addCommandHandler( "coin", 
	function( thePlayer, commandName )
		if exports.players:isLoggedIn( thePlayer ) and not isPedDead( thePlayer ) then
			if exports.players:getMoney( thePlayer ) >= 1 then
				me( thePlayer, "flips a coin. It shows " .. ( math.random( 2 ) == 1 and "Heads" or "Tails" ) .. ".", "(Coin)" )
			else
				outputChatBox( "You don't have a coin.", thePlayer, 255, 0, 0 )
			end
		end
	end
)
