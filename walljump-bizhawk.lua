-- this is a rewrite for a lua script that does same thing but ported by me  for bizhawk
-- original creator credit: ? idk cant find it

-- for bizhawk only


-- READ BEFORE YOU USE
-- turn this script on after you jumped for one frame,
-- make sure you have enough space between you and wall or it will deadlock
-- this is a wip script

savestate.save("bruteforce.st")
local groundflag
groundflag = memory.readbyte(0x0077) --0x0077 grounded variable
local xvel --0x007B
xvel = memory.readbyte(0x007B)
local yvel --0x007D
yvel = memory.readbyte(0x007D)
local input
local tries = 0
while (yvel~=6 or yvel~=3) and groundflag<=2 do --stupid code!!!!!!!!!
	emu.frameadvance()
	ran=math.random(2) -- 1-2
	if(ran~=1) then --if it's 1
		input = {B=true, Y=true} --press B,Y
	else --if not
		input = {Y=true} -- press Y
	end
	joypad.set(input) -- lol shut up
	groundflag = memory.readbyte(0x0077) --reread variables
	xvel = memory.readbyte(0x007B)
	yvel = memory.readbyte(0x007D)
	if(xvel==0) then --if hit wall
		if yvel==6 or yvel==3 then --if cling wall
			console.writeline("success")
			client.pause()
			break

		else --if not cling wall
			tries = tries + 1
			console.writeline(tostring(tries))
			savestate.load("bruteforce.st") --load state
		end
	end
end
