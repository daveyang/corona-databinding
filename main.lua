
-- UI data binding demo for Corona SDK
--
-- Update variables and UI elements (textfields in this demo) are updated automatically
--
-- Created by:	Dave Yang / Quantumwave Interactive Inc.
-- Version:	1.00

-- place variables inside UIdata
local UIdata = {
	sum = 0,
	rand = -1,
}

-- create the UI elements
local sumTxt = display.newText( UIdata.sum, 150, 125, native.systemFont, 24 )
local randTxt = display.newText( UIdata.rand, 150, 250, native.systemFont, 24 )

-- bind the data to the UI elements
local UIdataBinding = {
	sum = sumTxt,
	rand = randTxt,
}

---------------------------------------------------------------------------

-- reference to the original UIdata table
local _uidata = UIdata

-- empty UIdata to make it work with the metatable below
UIdata = {}

-- the metatable defines what to do with access and change to data in UIdata
local UIdataMT = {
	__index = function(t,k)
		return _uidata[k]
	end,

	__newindex = function(t,k,v)
		-- changes to the data is updated in the textfield; other UI elements can be applied according to type
		UIdataBinding[tostring(k)].text = v
		-- update the original data
		_uidata[k] = v
	end
}

setmetatable(UIdata, UIdataMT)

-- single line if you prefer to replace the lines above starting from 'local UIdataMT = {'
--setmetatable(UIdata, {__index=function(t,k) return _uidata[k] end, __newindex=function(t,k,v) UIdataBinding[tostring(k)].text=v;_uidata[k]=v end})

---------------------------------------------------------------------------

-- change and access data

UIdata.sum = 42
print(UIdata.sum)

UIdata.rand = math.random(99)
print(UIdata.rand)
