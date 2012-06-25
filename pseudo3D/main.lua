-- view in iPad Retina mode

local cube = display.newGroup()

cube:insert(display.newImageRect("cubetop.png",200,200))
cube:insert(display.newImageRect("cubetop.png",200,200))
cube:insert(display.newImageRect("cubeside.png",200,200))
cube:insert(display.newImageRect("cubeside.png",200,200))
cube[4]:setFillColor(200,200,200)
cube:insert(display.newImageRect("cubeside.png",200,200))
cube[5]:setFillColor(150,150,150)
cube:insert(display.newImageRect("cubeside.png",200,200))
cube[6]:setFillColor(200,200,200)

cube.state = 3
for i=1,6 do
	if i ~= 3 then
		cube[i].isVisible = false
	end
	cube[i]:translate(100-cube[i].x,100-cube[i].y)
end

cube.x, cube.y = display.contentWidth/2, display.contentHeight/2
cube.dX,cube.dY = 50,500
cube.rotindex = 1
cube.rot={cube.dX,-cube.dY,-cube.dX,cube.dY}

local index = 0

local function off(obj)
	obj.xScale = 1
	obj.isVisible = false
end

local function spin(cube)
	local _current = cube.state
	local _next = _current + 1
	
	if _next > 6 then _next = 3 end
	cube.state = _next
	
	cube[_next].isVisible = true
	cube[_next].x = 200
	cube[_next].xScale = 0.001
	transition.to(cube[_next],{time = 1000, x=100,xScale = 1, transition=easing.outQuad})
	transition.to(cube[_current],{time=1000,x=0,xScale = 0.001,transitioni=easing.outQuad,onComplete=off})
end

local function rotate(cube)
	local pivot = cube.x-cube.rot[cube.rotindex]
	cube.rotindex = cube.rotindex + 1
	if cube.rotindex >4 then
		cube.rotindex = 1
	end
	local finalX = pivot+cube.rot[cube.rotindex]
	transition.to(cube,{time = 1000, x=finalX,transition=easing.outQuad})
end

local function onFrame(e)
	if math.floor(e.time/1500) > index then
		index = index+1
		spin(cube)
		rotate(cube)
		print("text")
	end
end

Runtime:addEventListener("enterFrame",onFrame)