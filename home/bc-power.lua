local term = require"term"
local component = require"component"
local event = require"event"
local color = require"colors"
local side = require"sides"

local gpu = component.gpu
local redstone = component.redstone


--custom functions
--local bc_lib1 = require"bc-power-lib"


--vars
local name = "BeriCo Industries Power Manager"
local version = "0.1.4435"

local run = true
local screenSet = "main"
local cursorPos = {1,3}

local option = {
  main={
    PowerStorage={x=4,y=3},
    PowerProduction={x=4,y=4},
    Config2={x=4,y=5},
    Config3={x=4,y=6},
    Config4={x=4,y=7},
    Config5={x=4,y=8},
    Config={x=4,y=9},
    Shutdown={x=4,y=10}
  }
}

--functions

function menu(screen)

  if screen == "main" then

    gpu.set(cursorPos[1],cursorPos[2],"->")

    gpu.set(4,3,"Power Storage")
    gpu.set(4,4,"Power Production")
    gpu.set(4,5,"Power Storage")
    gpu.set(4,6,"Power Storage")
    gpu.set(4,7,"Power Storage")
    gpu.set(4,8,"Power Storage")
    gpu.set(4,9,"Config")
    gpu.set(4,10,"Shutdown")

  elseif screen == "config" then

    gpu.set(cursorPos[1],cursorPos[2],"->")

    gpu.set(4,3,"Power Storage")
    gpu.set(4,4,"Power Production")
    gpu.set(4,5,"Power Storage")
    gpu.set(4,6,"Power Storage")
    gpu.set(4,7,"Power Storage")
    gpu.set(4,8,"Power Storage")
    gpu.set(4,9,"Config")
    gpu.set(4,10,"<- Back")--to main

  end

end


--touch
function touchCheck(_,_,x,y,button,_)

  for k,v in pairs(option[screenSet]) do
    if x >= option[screenSet][k]["x"] and x <= option[screenSet][k]["x"]+24 and option[screenSet][k]["y"] == y then
      cursorPos[2] = option[screenSet][k]["y"]
      if k == "Shutdown" then
        exit()
      end
    end

  end

end


function exit()

  run = false

end


--pre init
term.clear()
event.listen("interrupted", exit)
event.listen("touch",touchCheck)


--post init


term.clear()

while run do

  term.clear()
  gpu.set(1,1,name.." v"..version)
  menu(screenSet)

  os.sleep(0.05)

end


--exit
term.clear()
event.ignore("interrupted", exit)
event.ignore("touch",touchCheck)
