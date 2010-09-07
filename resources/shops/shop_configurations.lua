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

shop_configurations =
{
	cluckinbell =
	{
		name = "Cluckin' Bell",
		skin = 167,
		{ itemID = 3, itemValue = 10, name = "Cluckin' Little Meal", description = "Contains french fries, a Little Clucker Kids Meal and a can of Sprunk.", price = 2 },
		{ itemID = 3, itemValue = 30, name = "Cluckin' Big Meal", description = "Contains french fries, a Fillet Burger, a Fowl Wrap and a can of Sprunk.", price = 5 },
		{ itemID = 3, itemValue = 55, name = "Cluckin' Huge Meal", description = "Contains french fries, a Double Fillet Burger, a Wing Pieces and a can of Sprunk.", price = 10 },
		{ itemID = 3, itemValue = 40, name = "Salad Meal", description = "Contains a plate of salad, Fowl Wraps, a Dip and a can of Sprunk.", price = 10 },
		{ itemID = 4, itemValue = 30, name = "Sprunk", description = "A can of this delicious Sprunk.", price = 5 },
		{ itemID = 4, itemValue = 20, name = "Water", description = "A bottle of crystal clear mountain water.", price = 3 },
	},
		bar =
	{
		name = "The Bar",
		skin = 217,
		{ itemID = 4, itemValue = 30, name = "Water", price = 2 },
		{ itemID = 4, itemValue = 10, name = "Sprunk", price = 3 },
		{ itemID = 4, itemValue = 0, name = "Beer", price = 5 },
		{ itemID = 4, itemValue = 5, name = "Wine", price = 8 },
		{ itemID = 4, itemValue = -10, name = "Whiskey", price = 11 },
		{ itemID = 4, itemValue = 0, name = "Vodka", price = 7 },
		{ itemID = 4, itemValue = 0, name = "Martini", price = 15 },
		{ itemID = 4, itemValue = 5, name = "Champagne", price = 20 },
	},
	cafe =
	{
		name = "Oceanside Cafe",
		skin = 250,
		{ itemID = 3, itemValue = 10, name = "Pizza Combo", description = "Contains french fries, a slice of Pizza and a can of Sprunk.", price = 4 },
		{ itemID = 3, itemValue = 30, name = "Burger Combo", description = "Contains french fries, a Fillet Burger, a Fowl Wrap and a can of Sprunk.", price = 5 },
		{ itemID = 3, itemValue = 30, name = "Beef Combo", description = "Contains french fries, a Serloin Steak, a Fowl Wrap and a can of Sprunk.", price = 5 },
		{ itemID = 3, itemValue = 40, name = "Salad Meal", description = "Contains a plate of salad, Fowl Wraps, a Dip and a can of Sprunk.", price = 10 },
		{ itemID = 4, itemValue = 30, name = "Sprunk", description = "A can of this delicious Sprunk.", price = 5 },
		{ itemID = 4, itemValue = 20, name = "Water", description = "A bottle of crystal clear mountain water.", price = 3 },
	},
	burgershot =
	{
		name = "Burger-Shot",
		skin = 205,
		{ itemID = 3, itemValue = 15, name = "Moo Kids Meal", description = "A Little Moo's Kids Meal with a can of Sprunk.", price = 2 },
		{ itemID = 3, itemValue = 30, name = "Beef Tower Meal", description = "Contains french fries, a Beef Tower burger, a Fowl Wrap and a can of Sprunk.", price = 5 },
		{ itemID = 3, itemValue = 50, name = "Meat Stack Meal", description = "Contains french fries, a Measure the Meat-Burger and a can of Sprunk.", price = 10 },
		{ itemID = 3, itemValue = 40, name = "Salad Meal", description = "Contains a plate of salad and a can of Sprunk.", price = 10 },
		{ itemID = 4, itemValue = 30, name = "Sprunk", description = "A can of this delicious Sprunk.", price = 5 },
		{ itemID = 4, itemValue = 20, name = "Water", description = "A bottle of crystal clear mountain water.", price = 3 },
	},
	pizza =
	{
		name = "The Well\nStacked Pizza Co.",
		skin = 155,
		{ itemID = 3, itemValue = 10, name = "Buster", description = "Contains french fries, a slice of Pizza and a can of Sprunk.", price = 3 },
		{ itemID = 3, itemValue = 30, name = "Double D-Luxe", description = "Contains french fries, a slice of Pizza, a salad with chicken breast and a can of Sprunk.", price = 5 },
		{ itemID = 3, itemValue = 50, name = "Full Rack", description = "Contains french fries, a Pizza and a can of Sprunk.", price = 10 },
		{ itemID = 3, itemValue = 70, name = "Large Salad Meal", description = "Contains a large plate of salad and a can of Sprunk.", price = 10 },
		{ itemID = 4, itemValue = 30, name = "Sprunk", description = "A can of this delicious Sprunk.", price = 5 },
		{ itemID = 4, itemValue = 20, name = "Water", description = "A bottle of crystal clear mountain water.", price = 3 },
	},
	hotdogs =
	{
		name = "Chilli Dogs",
		skin = 168,
		{ itemID = 3, itemValue = 15, name = "Hotdog", description = "A delicious hotdog.", price = 4 },
	},
	noodles =
	{
		name = "Noodle Exchange",
		skin = 168,
		{ itemID = 3, itemValue = 20, name = "Ramen", description = "A Japanese noodle soup.", price = 2 },
	},
	icecream =
	{
		name = "Ice Cream Vendor",
		skin = 168,
		{ itemID = 3, itemValue = 10, name = "Ice cream stick", description = "Delicious choccolate ice cream.", price = 1 },
	},
	electronics =
	{
		name = "San Fierro\nElectronics",
		skin = 217,
		{ itemID = 7, description = "A modern, black cellphone.", price = 50 },
	},
	books =
	{
		name = "Book Store",
		skin = 211,
	},
	copuniform =
	{
		name = "San Fierro\nUniforms",
		skin = 217,
		{ itemID = 5, itemValue = 71, name = "Cadet Uniform", price = 0 },
		{ itemID = 5, itemValue = 280, name = "Officer Uniform", price = 0 },
		{ itemID = 5, itemValue = 281, name = "Sergeant Uniform", price = 0 },
		{ itemID = 5, itemValue = 282, name = "Lieutenant Uniform", price = 0 },
		{ itemID = 5, itemValue = 284, name = "Motorcycle Uniform", price = 0 },
		{ itemID = 5, itemValue = 285, name = "SWAT Uniform", price = 0 },
		{ itemID = 5, itemValue = 288, name = "Deputy Chief Uniform", price = 0 },
		{ itemID = 5, itemValue = 283, name = "Chief Uniform", price = 0 },
	},
}

local function loadBookStore( )
	for key, value in ipairs( shop_configurations.books ) do
		shop_configurations.books[ key ] = nil
	end
	
	local languages = exports.players:getLanguages( )
	if languages then
		for key, value in ipairs( languages ) do
			table.insert( shop_configurations.books, { itemID = 8, itemValue = value[2], name = value[1] .. " Dictionary", description = "A dictionary to learn the basics of the " .. value[1] .. " language.", price = 100 } )
		end
	end
end

addEventHandler( getResources and "onResourceStart" or "onClientResourceStart", root,
	function( res )
		if res == resource then
			if getResourceFromName( "players" ) and ( not getResourceState or getResourceState( getResourceFromName( "players" ) ) == "running" ) then
				loadBookStore( )
			end
		elseif res == getResourceFromName( "players" ) then
			loadBookStore( )
		end
	end
)
