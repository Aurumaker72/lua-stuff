-- this is a rewrite for a lua script that does same thing but ported by me  for bizhawk
-- original creator credit: ? idk cant find it

-- for bizhawk only


-- READ BEFORE YOU USE
-- turn this script on after you jumped for one frame,
-- make sure you have enough space between you and wall or it will deadlock
-- this is a wip script

savestate.save("bruteforce.st")
local groundflag
local xvel --0x007B
local yvel --0x007D
groundflag = memory.readbyte(0x0077) --0x0077 grounded variable

xvel = memory.readbyte(0x007B)

yvel = memory.readbyte(0x007D)

local input
local tries = 0
client.invisibleemulation(true)
emu.limitframerate(false)
tryBy() -- enter loop

function tryBY()
	if (yvel~=6 or yvel~=3) and groundflag<=2 then
		if emu.islagged() then
			return -- skip anything if lag frame; cant receive inputs
		end
	emu.frameadvance() -- this isnt a good idea is it
	input = {B=true, Y=true}
	joypad.set(input) 
	while true do
	groundflag = memory.readbyte(0x0077) --reread variables
	xvel = memory.readbyte(0x007B)
	yvel = memory.readbyte(0x007D)
	if(xvel==0) then
		 
		if yvel==6 or yvel==3 then --if cling wall
			emu.limitframerate(true)
			client.invisibleemulation(false)
			console.writeline("success")
			client.pause()
		else --if not cling wall
			tryY()
			savestate.load("bruteforce.st") --load state
		end -- end cling wall check 
	end -- end wall hit check
end -- end loop
end -- end big check
end

function tryY()
	if (yvel~=6 or yvel~=3) and groundflag<=2 then
		if emu.islagged() then
			return -- skip anything if lag frame; cant receive inputs
		end
	emu.frameadvance() -- shit
	input = {B=false, Y=true}
	joypad.set(input) 
	groundflag = memory.readbyte(0x0077) --reread variables
	xvel = memory.readbyte(0x007B)
	yvel = memory.readbyte(0x007D)
	if(xvel==0) then
		 
		if yvel==6 or yvel==3 then --if cling wall
			emu.limitframerate(true)
			client.invisibleemulation(false)
			console.writeline("success")
			client.pause()
		else --if not cling wall
			tryBY()
			savestate.load("bruteforce.st") --load state
		end -- end cling wall check 
	end -- end wall hit check
end -- end loop
end -- end big check
end
