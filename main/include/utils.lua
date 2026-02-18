-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "include.utils"
-- in any script using the functions.

local G = {}
G.formatted_number = 0

function G.shuffle( t )
	for i = #t, 2, -1 do
		local j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end
	return t
end

function G.copy_table(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

function G.round( number, digit_position ) 
	local precision = 10^-digit_position
	number = number + (precision / 2);
	return math.floor(number / precision --[[+ .5--]]) * precision
end

-- Add commas to number/currency
function G.format_number( number )
	local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

	--> Make sure fraction part has only 2 decimal places
	if ( fraction ~= "" ) then
		fraction = tonumber( fraction )
		fraction = string.format( "%.2f", fraction )
		fraction = string.sub( fraction, 2 )
	end

	-- reverse the int-string and append a comma to all blocks of 3 digits
	int = int:reverse():gsub("(%d%d%d)", "%1,")

	-- reverse the int-string back remove an optional comma and put the 
	-- optional minus and fractional part back
	G.formatted_number = minus .. int:reverse():gsub("^,", "") .. fraction
end

return G