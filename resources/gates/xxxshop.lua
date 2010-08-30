local gates =
{
	{ gate = createObject(2930,-2670.55,491.87,71.7,0,0,0), offset = { 0, -1.25, 0, 0, 0, 0 }, open = false },
	{ gate = createObject(2930,-2663.11,494.27,71.7,0,0,269.75), offset = { 1.25, 0, 0, 0, 0, 0 }, open = true },
	{ gate = createObject(2886,-2670.85,488.26,70.5,0,0,270) },
	{ gate = createObject(2886,-2670.85,488.69,70.5,0,0,270) },
}

for _, gate in pairs(gates) do
	setElementInterior(gate.gate, 3)
	setElementDimension(gate.gate, 141)
end

local function resetBusy( shortestID )
	gates[ shortestID ].busy = nil
end

local function openDoor(source, id)
	if getElementDimension(source) == 141 then
		local gate = gates[id]
		if gate and gate.offset then
			if not gate.busy then
				if gate.open then
					local nx, ny, nz = getElementPosition( gate.gate )
					moveObject( gate.gate, 1000, nx - gate.offset[1], ny - gate.offset[2], nz - gate.offset[3], -gate.offset[4], -gate.offset[5], -gate.offset[6] )
					outputChatBox( "You closed the door!", source, 0, 255, 0 )
					gate.open = false
				else
					local nx, ny, nz = getElementPosition( gate.gate )
					moveObject( gate.gate, 1000, nx + gate.offset[1], ny + gate.offset[2], nz + gate.offset[3], gate.offset[4], gate.offset[5], gate.offset[6] )
					outputChatBox( "You opened the door!", source, 0, 255, 0 )
					gate.open = true
				end
				gate.busy = true
				setTimer( resetBusy, 1000, 1, id )
			end
		end
	end
end
addEventHandler( "onElementClicked", gates[3].gate, function( button, state, player ) if button=="left" and state=="up" then openDoor(player,1) end end)
addEventHandler( "onElementClicked", gates[4].gate, function( button, state, player ) if button=="left" and state=="up" then openDoor(player,2) end end)
