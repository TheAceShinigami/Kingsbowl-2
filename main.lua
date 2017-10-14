local server, server_update
local client, client_update
local gamestate
local keydowntable, keyuptable = unpack(require "keytable")
local menu_update = require "menu"
local gui_update, gui_draw, gui_mousepressed, gui_textinput, gui_keypressed, gui, gui, menus

keydowntable['1'] = function()
  create_server()
end
keydowntable['2'] = function()
  create_client()
end

local create_server = function()
  server, server_update = unpack(require("server"))
  gamestate = "server"
  new_gui(menus[2])
end

local create_client = function()
  gamestate = "client"
  client, client_update = unpack(require("client"))
  local success, err = client:connect("127.0.0.1", 25565)
  print(success, err)
  if success then
      new_gui(menus[3])
  end
end

love.load = function()
  font = love.graphics.newImageFont("font.png",
    " ABCDEFGHIJKLMNOPQRSTUVWXYZ" ..
    "abcdefghijklmnopqrstuvwxyz" ..
    "0123456789!?.:", 1)
  love.graphics.setFont(font)
  gamestate = "menu"

  gui_update, gui_draw, gui_mousepressed, gui_textinput, gui_keypressed, gui, gui = unpack(require("gui"))
  menus = {}
  menus[1] = {buttons = {{x = 200, y = 275, w = 100, h = 50, txt = "server", func = create_server, args = {}}, {x = 500, y = 275, w = 100, h = 50, txt = "client", func = create_client, args = {}}}}
  menus[2] = {}
  menus[3] = {}

  new_gui(menus[1])
end

love.update = function(dt)
  if gamestate == "server" then
    server_update(dt)
  elseif gamestate == "client" then
    client_update(dt)
  elseif gamestate == "menu" then
    menu_update(dt)
  end
  gui_update(dt)
end

love.draw = function()
  gui_draw()
end

love.mousepressed = function(x, y, button)
  gui_mousepressed(x, y, button)
end

love.textinput = function(t)
  gui_textinput(t)
end

love.keypressed = function(key)
  keyuptable[key]()
  gui_keypressed(key)
end

love.keyreleased = function(key)
  keydowntable[key]()
end
