addCommandHandler( "report",
	function( thePlayer, commandName, otherPlayer,... )
		if exports.players:isLoggedIn( thePlayer ) then
			local message = table.concat( { ... }, " " )
			if #message > 0 then
				message = getPlayerName( thePlayer ) .. ": " .. message
				local groups = exports.players:getGroups( thePlayer )
				if groups and #groups >= 1 then
					message = getPlayerName( thePlayer ) .. " reported " .. otherPlayer .." because: ".. message
				end
				
				for key, value in ipairs( getElementsByType( "player" ) ) do
					if hasObjectPermissionTo( value, "command.modchat", false ) then
						outputChatBox( message, value, 255, 150, 191 )
					end
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [Player ID] [text]", thePlayer, 255, 255, 255 )
			end
		end
	end,
	true
)