-- Mupen64 LUA RNG bruteforcer aka random inputs spammer
-- By Aurumaker72

target = 2960785408 -- Target RNG
curRNG = 0
iterations = 0
initialised = 0
local ROM
local Regions = {
	addr = 0x802F0000,
	U = 0xC58400A4,
	J = 0x27BD0020
}

function init()
if initialised == 1 then return end
ROM = memory.readdword(Regions.addr)
if ROM == Regions.U then

elseif ROM == Regions.J then
	action_addr = 0x00B39E0C
end
print("ROM Region: " .. (ROM==Regions.U and "USA" or "JAPAN"))
emu.setgfx(0) 
emu.speed(100*10)
emu.pause(0)
end
function stop()
emu.setgfx(1) 
emu.speed(100)
emu.pause(1)
print("---\nStopped at try " .. iterations .. "\n---")
end

-- Speed up emulation
init()
initialised = 1

-- Some code stolen from InputDirection LUA
Joypad = { input = {} }
function Joypad.get()
	Joypad.input = joypad.get(1)
end
function Joypad.send()
	joypad.set(1, Joypad.input)
end
function Joypad.set(key, value)
	Joypad.input[key] = value
end

function updateRNG()
-- Hack kind of because just typing in the hex literal is "malformed"
curRNG = memory.readdword(tonumber("8038EEE0",16))
end

function rngTry()
iterations = iterations + 1
updateRNG()

if(curRNG == target) then
stop()
end

print("[Try " .. iterations .. "] - RNG: " .. curRNG .. " - RNG Target: " .. target)

joy = math.random(-127,127)

Joypad.set("X",joy)
Joypad.set("Y",joy+joy/2)

Joypad.send()

end



emu.atinput(rngTry)
--emu.atvi(drawing,false)
--emu.atinterval(update,false)
emu.atstop(stop)
