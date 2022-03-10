LICENSE = [[
mod_server.lua

Copyright (c) 2013 Phil Hassey
Modifed by: Tycho2

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Galcon is a registered trademark of Phil Hassey
For more information see http://www.galcon.com/
]]
--------------------------------------------------------------------------------
--[[ REQUIRE FILES ]] --
require("compiler")
require("host")
require("menu")
require("clients")
require("params")
require("chat")
require("lobby")
require("classic")
require("register")
require("engine")
require("mod")
require("data")
require("util")

-- Start mod.
mod_init()
