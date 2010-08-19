function startup()
	for k, v in ipairs (getElementsByType("PayNSpray")) do
		local marker = createMarker(getElementData(v,"x"),getElementData(v,"y"),getElementData(v,"z"),"cylinder")
		createBlipAttachedTo(marker,63,2,255,0,0,255,0,250)
		setElementData(marker,"PNSMarker",true)
		setGarageOpen(tonumber(getElementData(v,"garage")),true)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(),startup)

function payNSpray(hitElement)
	if (getElementData(source,"PNSMarker") == true) then
		if (getElementType(hitElement) == "vehicle") then
			if (getElementHealth(hitElement) < 1000) then
				local charge = math.floor(1000-getElementHealth(hitElement))
				if (getPlayerMoney(getVehicleController(hitElement)) >= charge) then
					outputChatBox("Your vehicle has been repaired for $"..charge..".",getVehicleController(hitElement),255,255,0)
					fixVehicle(hitElement)
					exports.players:takeMoney(getVehicleController(hitElement),charge)
					toggleControl(getVehicleController(hitElement),"accelerate",false)
					toggleControl(getVehicleController(hitElement),"enter_exit",false)
					toggleControl(getVehicleController(hitElement),"handbrake",false)
					setControlState(getVehicleController(hitElement),"handbrake",true)
					fadeCamera(getVehicleController(hitElement),false,1)
					setTimer(restoreControl,1000,1,getVehicleController(hitElement))
				else
					local extraCost = math.floor(charge-getPlayerMoney(getVehicleController(hitElement)))
					outputChatBox("You need an additional $"..extraCost.." for a repair.",getVehicleController(hitElement),255,0,0)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),payNSpray)

function restoreControl(player)
	toggleControl(player,"accelerate",true)
	toggleControl(player,"enter_exit",true)
	setControlState(player,"handbrake",false)
	toggleControl(player,"handbrake",true)
	fadeCamera(player,true)
end