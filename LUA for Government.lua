script_name("LUA for Government by AD") -- FFD700
script_version("1.0") 
script_author("Anthony_Dwight")

local inicfg = require 'inicfg'
local check_time = false
local time = 0
local check_key = false
local tag = '[LUA by AD] {FFFFFF} ' 
local sampev = require 'lib.samp.events'
local report = 'vk.com/anthonydwight'
local key = require 'vkeys'
local id = 0
local dolzh = {"��������", "��������� ������", "���������", "������� ���������", "�������", "��������", "������� ��������", "�������", "����������� ����", "���"}
local frak = {["301989887"]="�����������", ["-39322"]="{ff6666}������������ ���������������", ["-39424"]="{ff6600}�� � ����� (���)", ["-16776961"]="{0000fe}����������� ���������� ���", ["-6724045"]="{996533}������������ �������", ["-3342592"]="{ccff00}�������������", ["-4521984"]="{bc0000}Yakuza", ["-16747147"]="{017575}Russian Mafia", ["9474192"]="�� �����������", ["-3407617"]="{cc00ff}The Ballas", ["-16724737"]="{00ccff}Varios Los Aztecas", ["-6737050"]="{993365}La Cosa Nostra", ["-10027111"]="������� �� ������", ["2236962"]="������� � �����", ["-10066177"]="{6665ff}The Rifa", ["-16738048"]="{009900}Grove Street", ["-13056"]="{ffcd00}Los Santos Vagos", ["-65536"]="������� �� �������-�����������", ["-16724992"]="������� �� �������-�����������"}
local gmenu = {"{ffffff}1. ��������� ����� ���� ���������\n2. ��������� �������� ������\n3. ������� �������� (��� �������������)", "{ffffff}1. ��������� ����� ���� ���������\n2. ��������� �������� ������\n3. ������� �������� (��� �������������)", "{ffffff}1. ��� ���� ���� �������?\n2. ������ ������� ���������\n3. ������ ������� ����������",  "{ffffff}1. ��� ���� ���� �������?\n2. ������ ������� ���������\n3. ������ ������� ����������", "{ffffff}1. �������� ����� �� ������\n2. �������� ������� ��������\n3. ��������� ��������", "{ffffff}1. ������� �������� �� ������� �����\n2. ������� �������� �� ����. �����\n3. ������� �������� �� ������", "{ffffff}1. ������� �������� �� ������� �����\n2. ������� �������� �� ����. �����\n3. ������� �������� �� ������", "{ffffff}1. �������� �����\n2. �������� �������", "{ffffff}1. ������� � �����������\n2. �������� �����\n3. �������� ����\n4. �������� ����", "{ffffff}1. ������� � �����������\n2. �������� �����\n3. �������� ����\n4. �������� ����"}
local sfrac = {"����� ���-�������", "����� ���-������", "����� ���-���������", "������������� ����������"}
local actmenu = {"{ffffff}1. ������ � ����������� �� ����\n2. ������ � ��������� �����\n3. ������ � ��������� �����", "{ffffff}1. ������ � ����������� �� ����\n2. ������ � ��������� �����\n3. ������ � ��������� �����\n4. ������� ������", "{ffffff}1. ������������. �� �� �������������?\n2. ��������� ����� ����������\n3. ������ ������ ���������� IC\n4. ������ ������ ���������� ���\n5. ������ ������ � IC\n6. ������ ������ � ���\n7. �� ��� ���������\n8. �� ��� �� ���������", "{ffffff}1. ������������. �� �� �������������?\n2. ��������� ����� ����������\n3. ������ ������ ���������� IC\n4. ������ ������ ���������� ���\n5. ������ ������ � IC\n6. ������ ������ � ���\n7. �� ��� ���������\n8. �� ��� �� ���������", "{ffffff}1. ���������� ������ ��������\n2. �������� ������� ��������", "{ffffff}1. ���������� ������ ���������\n2. �������� ������� ��������\n3. ��� ���� ����� ���������� �� �������\n4. ���� ���������\n5. �����/����� �������", "{ffffff}1. ���������� ������ ���������\n2. �������� ������� ��������\n3. ��� ���� ����� ���������� �� �������\n4. ���� ���������\n5. �����/����� �������", "{ffffff}1. ����������� � ������� ����������\n2. ����������� � ��������� � ����������\n3. ����������� � �������� ����� � ������� �����\n4. ����������� � ������� ����� �1\n5. ����������� � ������� ����� �2", "{ffffff}1. ����������� � ������� ����������\n2. ����������� � ��������� � ����������\n3. ����������� � �������� ����� � ������� �����\n4. ����������� � ������� ����� �1\n5. ����������� � ������� ����� �2", "{ffffff}1. ���� ���. ��������\n2. ����������� � ������� ����������\n3. ����������� � ��������� � ����������\n4. ����������� � �������� ����� � ������� �����\n5. ����������� � ������� ����� �1\n6. ����������� � ������� ����� �2"}
local ftag = {"LS", "SF", "LV", "��"}

if not doesDirectoryExist("moonloader\\government") then 
	createDirectory("moonloader\\government") 
end

if not doesFileExist("moonloader\\government\\config.ini") then 
	local f = io.open('moonloader\\government\\config.ini', 'a') 
	f:write("[settings]\nname=None\nrang=1\nsex=�������\nnumber=None\nfraction=����� ���-�������\nnumfr=1") 
	f:close()
	sampAddChatMessage(tag.. "{ff0000}��������! {ffffff}��� ���������� ������ ������� ��������� ��� � {ffd700}/settings", 0xffd700)
end

function main() 
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand("settime", func_stime) 
	sampRegisterChatCommand("setweather", setweather) 
	sampRegisterChatCommand("weatherhelp", weathhelp)
	sampRegisterChatCommand("setskin", setskin)
	sampRegisterChatCommand("cc", ClearChat) 
	sampRegisterChatCommand("luahelp", luahelp)
	sampRegisterChatCommand("checkid", checkid)
	sampRegisterChatCommand("settings", settings)
	sampRegisterChatCommand("rn", rooc)
	sampRegisterChatCommand("fn", fooc)
	sampRegisterChatCommand("ft", tagf)
	sampRegisterChatCommand("ud", udost)
	sampRegisterChatCommand("sobes", sobeska)
	sampRegisterChatCommand("act", menuact)
	sampRegisterChatCommand("uninv", uninvite)
	sampRegisterChatCommand("sud", specud)
	sampRegisterChatCommand("show", showdocs)
	sampAddChatMessage(tag .. "" .. thisScript().name .. " ������� �������. ������: " .. thisScript().version .. ". ����������� �������: {32CD32}Anthony_Dwight", 0xFFD700) 
	sampAddChatMessage(tag .. "������ �� �������: {FFD700}/luahelp{ffffff}. ����� � �������������: {32CD32}" ..report, 0xFFD700)
	thread = lua_thread.create_suspended(thread_function)
	ini = inicfg.load(nil, "moonloader\\government\\config.ini")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/const1.txt", "moonloader\\government\\const1.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/const2.txt", "moonloader\\government\\const2.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/epk1.txt", "moonloader\\government\\epk1.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/epk2.txt", "moonloader\\government\\epk2.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/epk3.txt", "moonloader\\government\\epk3.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/ustaw1.txt", "moonloader\\government\\ustaw1.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/ustaw2.txt", "moonloader\\government\\ustaw2.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/ustaw3.txt", "moonloader\\government\\ustaw3.txt")
	downloadUrlToFile("https://github.com/tsurik/silver/raw/master/version.txt", "moonloader\\government\\version.txt")
	vers = io.open("moonloader\\government\\version.txt", "r+")
	versia = vers:read()
	if versia > thisScript().version then
		local dlstatus = require('moonloader').download_status
		downloadUrlToFile("", thisScript().path, function(id, status)
			if status == dlstatus.STATUSENDDOWNLOADDATA then
				thisScript():reload
			end
		end)
		sampAddChatMessage(tag.. "������ ������� �������� �� ������ " ..versia.. "!")
		return
	end
	vers:close()
	while true do
		wait(0)
		if ini.settings.sex == "�������" then
			peredal = "�������"
			zalomal = "�������"
			povel = "�����"
			postavil = "��������"
			dostal = "������"
			otkril = "������"
			vidal = "�����"
			zapolnil = "��������"
			vzal = "����"
			zakril = "������"
			spratal = "�������"
			zashel = "�����"
			annul = "�����������"
		end
		if ini.settings.sex == "�������" then
			peredal = "��������"
			zalomal = "��������"
			povel = "������"
			postavil = "���������"
			dostal = "�������"
			otkril = "�������"
			vidal = "������"
			zapolnil = "���������"
			vzal = "�����"
			zakril = "�������"
			spratal = "��������"
			zashel = "�����"
			annul = "������������"
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(110)
		if resultMain == true then
			if buttonMain == 1 then
				rang = ini.settings.rang
				if rang == 1 then
					if listMain == 0 then
						postid = "1"
						sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
					end
					if listMain == 1 then
						postid = "2"
						sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
					end
					if listMain == 2 then
						postid = "3"
						sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
					end
				end
				if rang == 2 then
				if listMain == 0 then
						postid = "1"
						sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
					end
					if listMain == 1 then
						postid = "2"
						sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
					end
					if listMain == 2 then
						postid = "3"
						sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
					end
					if listMain == 3 then
						sampSendChat("/r ������ ������. ����������� ������ � ��� �� ����!")
					end
				end
				if rang == 3 then
					if listMain == 0 then
					sampSendChat("������������, �� ������ �� �������������?")
					end
					if listMain == 1 then
						thread:run("doki")
					end
					if listMain == 2 then
						number = math.random(1, 5)
						if number == 1 then
							sampSendChat("����� ��������?")
						end
						if number == 2 then
							sampSendChat("�� ����� ����� �� �������������?")
						end
						if number == 3 then
							sampSendChat("� ����� ������ �� ����������?")
						end
						if number == 4 then
							sampSendChat("������� ��� ���?")
						end
						if number == 5 then
							sampSendChat("��� ��� �����?")
						end
					end
					if listMain == 3 then
						number = math.random(1, 3)
						if number == 1 then
							sampSendChat("/n �������")
						end
						if number == 2 then 
							sampSendChat("/n ��� � ���� � ������ ����?")
						end
						if number == 3 then
							sampSendChat("/n �� �� ������� ��� ���")
						end
					end
					if listMain == 4 then
						number = math.random(1, 5)
						if number == 1 then
							sampSendChat("��� ����� ��?")
						end
						if number == 2 then
							sampSendChat("��� ����� ��?")
						end
						if number == 3 then
							sampSendChat("��� ����� ��?")
						end
						if number == 4 then
							sampSendChat("��� ����� ��?")
						end
						if number == 5 then
							sampSendChat("��� ����� ��?")
						end
					end
					if listMain == 5 then
						number = math.random(1, 5)
						if number == 1 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 2 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 3 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 4 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 5 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
					end
					if listMain == 6 then
						sampSendChat("�������. �� ��� ���������. ������ ������ ��� �����.")
					end
					if listMain == 7 then
						sampShowDialog(101, "{ffd700}" ..tag.. "������� �������", "{ffffff}������� �������", "��", "�����", 1)
					end
				end
				if rang == 4 then 
					if listMain == 0 then
					sampSendChat("������������, �� ������ �� �������������?")
					end
					if listMain == 1 then
						thread:run("doki")
					end
					if listMain == 2 then
						number = math.random(1, 5)
						if number == 1 then
							sampSendChat("����� ��������?")
						end
						if number == 2 then
							sampSendChat("�� ����� ����� �� �������������?")
						end
						if number == 3 then
							sampSendChat("� ����� ������ �� ����������?")
						end
						if number == 4 then
							sampSendChat("������� ��� ���?")
						end
						if number == 5 then
							sampSendChat("��� ��� �����?")
						end
					end
					if listMain == 3 then
						number = math.random(1, 3)
						if number == 1 then
							sampSendChat("/n �������")
						end
						if number == 2 then 
							sampSendChat("/n ��� � ���� � ������ ����?")
						end
						if number == 3 then
							sampSendChat("/n �� �� ������� ��� ���")
						end
					end
					if listMain == 4 then
						number = math.random(1, 5)
						if number == 1 then
							sampSendChat("��� ����� ��?")
						end
						if number == 2 then
							sampSendChat("��� ����� ��?")
						end
						if number == 3 then
							sampSendChat("��� ����� ��?")
						end
						if number == 4 then
							sampSendChat("��� ����� ��?")
						end
						if number == 5 then
							sampSendChat("��� ����� ��?")
						end
					end
					if listMain == 5 then
						number = math.random(1, 5)
						if number == 1 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 2 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 3 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 4 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
						if number == 5 then
							sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
						end
					end
					if listMain == 6 then
						sampSendChat("�������. �� ��� ���������. ������ ������ ��� �����.")
					end
					if listMain == 7 then
						sampShowDialog(101, "{ffd700}" ..tag.. "������� �������", "{ffffff}������� �������", "��", "�����", 1)
					end
				end
				if rang == 5 then
					if listMain == 0 then
						thread:run("advask1")
					end
					if listMain == 1 then
						thread:run("advask2")
					end
				end
				if rang == 6 then
					if listMain == 0 then
						thread:run("predlic")
					end
					if listMain == 1 then
						sampSendChat("�������� �� ������ - 30.000$, ����. ������� ���� - 10.000$, ������� ������� ���� - 1.000$")
					end
					if listMain == 2 then
						thread:run("profprava")
					end
					if listMain == 3 then
						sampSendChat("/s �������� ��������! ������� ��� ������ � �������!")
					end
					if listMain == 4 then
						sampSendChat("/badge")
					end
				end
				if rang == 7 then
					if listMain == 0 then
						thread:run("predlic")
					end
					if listMain == 1 then
						sampSendChat("�������� �� ������ - 30.000$, ����. ������� ���� - 10.000$, ������� ������� ���� - 1.000$")
					end
					if listMain == 2 then
						thread:run("profprava")
					end
					if listMain == 3 then
						sampSendChat("/s �������� ��������! ������� ��� ������ � �������!")
					end
					if listMain == 4 then
						sampSendChat("/badge")
					end
				end
				if rang == 8 then
					if listMain == 0 then
						thread:run"napom1"
					end
					if listMain == 1 then
						thread:run"napom2"
					end
					if listMain == 2 then
						thread:run"napom3"
					end
					if listMain == 3 then
						thread:run"napom4"
					end
					if listMain == 4 then
						thread:run"napom5"
					end
				end
				if rang == 9 then
					if listMain == 0 then
						thread:run"napom1"
					end
					if listMain == 1 then
						thread:run"napom2"
					end
					if listMain == 2 then
						thread:run"napom3"
					end
					if listMain == 3 then
						thread:run"napom4"
					end
					if listMain == 4 then
						thread:run"napom5"
					end
				end
				if rang == 10 then
					if listMain == 0 then
						gosmenu()
					end
					if listMain == 1 then
						thread:run"napom1"
					end
					if listMain == 2 then
						thread:run"napom2"
					end
					if listMain == 3 then
						thread:run"napom3"
					end
					if listMain == 4 then
						thread:run"napom4"
					end
					if listMain == 5 then
						thread:run"napom5"
					end
				end
			end
		end
		local resultInput, buttonInput, listInput, post = sampHasDialogRespond(111)
		if resultInput == true then
			if buttonInput == 1 then
				if #post == 0 then
					sampShowDialog(111, "{ffd700}" ..tag.. "������� �������� �����", "{ffffff}������� �������� �����", "��", "�����", 1)
				else
					if postid == "1" then
						sampSendChat("/r ����������� " ..dolzh[ini.settings.rang].. " " ..ini.settings.name.. " | �������� �� ����: " ..post.. ".")
					end
					if postid == "2" then
						sampSendChat("/r ����������� " ..dolzh[ini.settings.rang].. " " ..ini.settings.name.. " | ����: " ..post.. " | ���������: ����������.")
					end
					if postid == "3" then
						sampSendChat("/r ����������� " ..dolzh[ini.settings.rang].. " " ..ini.settings.name.. " | ������� ����: " ..post.. ".")
					end
				end
			else menuact()
			end
		end
		if isKeyDown(0x12) and isKeyJustPressed(0x31) then 
			menuact()
		end
		if isKeyDown(0x71) then 
			if check_key == "advokat1" then
				check_key = false
				thread:run("advask4")
			end
			if check_key == "advokat2" then
				check_key = false
				thread:run("advask5")
			end
			if check_key == "licer1" then
				check_key = false
				thread:run("licask01")
			end
			if check_key == "licer2" then
				check_key = false
				thread:run("licask02")
			end
		end
		if isKeyDown(0x72) then
			if check_key ~= false then
				sampAddChatMessage(tag.. "�� ������� �������� ��������", 0xffd700)
				check_key = false
			end
		end
		if isKeyDown(2) and isKeyJustPressed(0x47) then
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) 
			if valid and doesCharExist(ped) then 
				result, id = sampGetPlayerIdByCharHandle(ped) 
				if result then 
					nick = sampGetPlayerNickname(id)
					sampShowDialog(5001, "{ffd700}" ..tag .. "�� �������� �� ������ " .. nick .. "[" ..id.. "]", gmenu[ini.settings.rang], "OK", "������", 2)
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(100)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					sampSendChat("������������, �� ������ �� �������������?")
				end
				if listMain == 1 then
					thread:run("doki")
				end
				if listMain == 2 then
					number = math.random(1, 5)
					if number == 1 then
						sampSendChat("����� ��������?")
					end
					if number == 2 then
						sampSendChat("�� ����� ����� �� �������������?")
					end
					if number == 3 then
						sampSendChat("� ����� ������ �� ����������?")
					end
					if number == 4 then
						sampSendChat("������� ��� ���?")
					end
					if number == 5 then
						sampSendChat("��� ��� �����?")
					end
				end
				if listMain == 3 then
					number = math.random(1, 3)
					if number == 1 then
						sampSendChat("/n �������")
					end
					if number == 2 then 
						sampSendChat("/n ��� � ���� � ������ ����?")
					end
					if number == 3 then
						sampSendChat("/n �� �� ������� ��� ���")
					end
				end
				if listMain == 4 then
					number = math.random(1, 5)
					if number == 1 then
						sampSendChat("��� ����� ��?")
					end
					if number == 2 then
						sampSendChat("��� ����� ��?")
					end
					if number == 3 then
						sampSendChat("��� ����� ��?")
					end
					if number == 4 then
						sampSendChat("��� ����� ��?")
					end
					if number == 5 then
						sampSendChat("��� ����� ��?")
					end
				end
				if listMain == 5 then
					number = math.random(1, 5)
					if number == 1 then
						sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
					end
					if number == 2 then
						sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
					end
					if number == 3 then
						sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
					end
					if number == 4 then
						sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
					end
					if number == 5 then
						sampSendChat("/n ��, ��, �� � ��� �� ����� " ..ini.settings.number)
					end
				end
				if listMain == 6 then
					sampSendChat("�������. �� ��� ���������. ������ ������ ��� �����.")
				end
				if listMain == 7 then
					sampShowDialog(101, "{ffd700}" ..tag.. "������� �������", "{ffffff}������� �������", "��", "�����", 1)
				end
			end
		end
		local resultInput, buttonInput, listInput, reason = sampHasDialogRespond(101)
		if resultInput == true then
			if buttonInput == 1 then
				if #reason == 0 then
					sampShowDialog(101, "{ffd700}" ..tag.. "������� �������", "{ffffff}������� �������", "��", "�����", 1)
				else
					sampSendChat("� ���������, �� ��� �� ���������. �������: " ..reason.. ".")
				end
			else sobeska()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(5001)
		if resultMain == true then
			if buttonMain == 1 then
				rang = ini.settings.rang
				if rang == 1 then
					if listMain == 0 then
						thread:run("ohrana1")
					end
					if listMain == 1 then
						thread:run("ohrana2")
					end
					if listMain == 2 then
						thread:run("ohrana3")
					end
				end
				if rang == 2 then
					if listMain == 0 then
						thread:run("ohrana1")
					end
					if listMain == 1 then
						thread:run("ohrana2")
					end
					if listMain == 2 then
						thread:run("ohrana3")
					end
				end
				if rang == 3 then
					if listMain == 0 then
						thread:run("secask1")
					end
					if listMain == 1 then
						thread:run("secask2")
					end
					if listMain == 2 then
						thread:run("secask3")
					end
				end
				if rang == 4 then
					if listMain == 0 then
						thread:run("secask1")
					end
					if listMain == 1 then
						thread:run("secask2")
					end
					if listMain == 2 then
						thread:run("secask3")
					end
				end
				if rang == 5 then
					if listMain == 0 then
						thread:run("advask1")
					end
					if listMain == 1 then
						thread:run("advask2")
					end
					if listMain == 2 then
						thread:run("advask3")
					end
				end
				if rang == 6 then
					if listMain == 0 then
						licid = 1
						thread:run("licask0")
					end
					if listMain == 1 then
						licid = 2
						thread:run("licask0")
					end
					if listMain == 2 then
						licid=3
						thread:run("licask0")
					end
				end
				if rang == 7 then
					if listMain == 0 then
						licid = 1
						thread:run("licask0")
					end
					if listMain == 1 then
						licid = 2
						thread:run("licask0")
					end
					if listMain == 2 then
						licid=3
						thread:run("licask0")
					end
				end
				if rang == 8 then
					if listMain == 0 then
						thread:run("changeskin")
					end
					if listMain == 1 then
						udost()
					end
				end
				if rang == 9 then
					if listMain == 0 then
						thread:run("invite")
					end
					if listMain == 1 then
						thread:run("changeskin")
					end
					if listMain == 2 then
						poviha = "+"
						thread:run("smenarang")
					end
					if listMain == 3 then
						poviha = "-"
						thread:run("smenarang")
					end
				end
				if rang == 10 then
					if listMain == 0 then
						thread:run("invite")
					end
					if listMain == 1 then
						thread:run("changeskin")
					end
					if listMain == 2 then
						poviha = "+"
						thread:run("smenarang")
					end
					if listMain == 3 then
						poviha = "-"
						thread:run("smenarang")
					end
				end
			end
		end
		if isKeyDown(2) and isKeyJustPressed(0x58) then
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) 
			if valid and doesCharExist(ped) then 
				result, id = sampGetPlayerIdByCharHandle(ped) 
				if result then 
					nick = sampGetPlayerNickname(id)
					thread:run("allow")
				end
			end
		end
		if isKeyDown(2) and isKeyJustPressed(0x48) then
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) 
			if valid and doesCharExist(ped) then 
				result, id = sampGetPlayerIdByCharHandle(ped) 
				if result then 
					nick = sampGetPlayerNickname(id)
					sampShowDialog(5000, "{ffd700}" ..tag .. "�� �������� �� ������ " .. nick .. "[" ..id.. "]", "{ffffff}1. �������� �������\n2. �������� ��������\n3. �������� �������� �����\n4. �������� ������� �� ����", "OK", "������", 2)
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(5000)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					sampSendChat("/pass " ..id)
				end
				if listMain == 1 then
					sampSendChat("/lic " ..id)
				end
				if listMain == 2 then
					sampSendChat("/wbook " ..id)
				end
				if listMain == 3 then
					sampSendChat("/skill " ..id)
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(0)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					sampShowDialog(10, "{ffd700}" ..tag.. "������� ������� (��� _)", "{ffffff}��� ������� �������: {ffd700}" ..ini.settings.name, "��", "�����", 1)
				end
				if listMain == 1 then
					sampShowDialog(11, "{ffd700}" ..tag.. "������� ���� �����", "{ffffff}��� ������� �����: {ffd700}" ..ini.settings.number, "��", "�����", 1)
				end
				if listMain == 2 then
					sampShowDialog(12, "{ffd700}" ..tag.. "�������� ���� �������������", "{ffffff}����� ���-�������\n����� ���-������\n����� ���-���������\n������������� ����������", "��", "�����", 2)
				end
				if listMain == 3 then
					sampShowDialog(13, "{ffd700}" ..tag.. "������� ���� ����", "{ffffff}��� ������� ����: {ffd700}" ..ini.settings.rang, "OK", "�����", 1)
				end
				if listMain == 4 then
					sampShowDialog(14, "{ffd700}" ..tag.. "�������� ���", "{ffffff}�������\n�������", "OK", "�����", 4)
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(14)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					ini.settings.sex = "�������"
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
				if listMain == 1 then
					ini.settings.sex = "�������"
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
			else
				settings()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(12)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					ini.settings.fraction = "����� ���-�������"
					ini.settings.numfr = 1
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
				if listMain == 1 then
					ini.settings.fraction = "����� ���-������"
					ini.settings.numfr = 2
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
				if listMain == 2 then
					ini.settings.fraction = "����� ���-���������"
					ini.settings.numfr = 3
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
				if listMain == 3 then
					ini.settings.fraction = "������������� ����������"
					ini.settings.numfr = 4
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
			else
				settings()
			end
		end
		local resultInput, buttonInput, listInput, inputrang = sampHasDialogRespond(13)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputrang == 0 then
					sampShowDialog(13, "{ffd700}" ..tag.. "������� ���� ����", "{ffffff}��� ������� ����: {ffd700}" ..ini.settings.rang, "OK", "�����", 1)
				else
					inputrang = tonumber(inputrang)
					if type(inputrang) ~= "number" then
						sampShowDialog(13, "{ffd700}" ..tag.. "������� ���� ����", "{ffffff}��� ������� ����: {ffd700}" ..ini.settings.rang, "OK", "�����", 1)
					else
						if inputrang < 1 or inputrang > 10 then
							sampShowDialog(13, "{ffd700}" ..tag.. "������� ���� ����", "{ffffff}��� ������� ����: {ffd700}" ..ini.settings.rang, "OK", "�����", 1)
						else
							ini.settings.rang = inputrang
							inicfg.save(ini, "moonloader\\government\\config.ini")
							settings()
						end
					end
				end
			else settings()
			end
		end
		local resultInput, buttonInput, listInput, inputname = sampHasDialogRespond(10)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputname == 0 then
					sampShowDialog(10, "{ffd700}" ..tag.. "������� ������� (��� _)", "{ffffff}��� ������� �������: {ffd700}" ..ini.settings.name, "��", "�����", 1)
				else
					ini.settings.name = inputname
					inicfg.save(ini, "moonloader\\government\\config.ini")
					settings()
				end
			else settings()
			end
		end
		local resultInput, buttonInput, listInput, inputnumber = sampHasDialogRespond(11)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputnumber == 0 then
					sampShowDialog(11, "{ffd700}" ..tag.. "������� ���� �����", "{ffffff}��� ������� �����: {ffd700}" ..ini.settings.number, "��", "�����", 1)
				else
					inputnumber = tonumber(inputnumber)
					if type(inputnumber) ~= "number" then
						sampShowDialog(11, "{ffd700}" ..tag.. "������� ���� �����", "{ffffff}��� ������� �����: {ffd700}" ..ini.settings.number, "��", "�����", 1)
					else
						ini.settings.number = inputnumber
						inicfg.save(ini, "moonloader\\government\\config.ini")
						settings()
					end
				end
			else settings()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(1000)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					gosfrac = 1
					gosmenu1()
				end
				if listMain == 1 then
					gosfrac = 2
					gosmenu1()
				end
				if listMain == 2 then
					gosfrac = 3
					gosmenu1()
				end
				if listMain == 3 then
					gosfrac = 4
					gosmenu1()
				end
			else
				menuact()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(1001)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					if gosfrac == 1 then
						thread:run("gos01")
					end
					if gosfrac == 2 then
						thread:run("gos02")
					end
					if gosfrac == 3 then
						thread:run("gos03")
					end
					if gosfrac == 4 then
						thread:run("gos04")
					end
				end
				if listMain == 1 then
					if gosfrac == 1 then
						sampSendChat("/gnews ������������� � ����� �.���-������ ������������. ���� ���. GPS 1-2.")
					end
					if gosfrac == 2 then
						sampSendChat("/gnews ������������� � ����� �.���-������ ������������. ���� ���. GPS 1-3.")
					end
					if gosfrac == 3 then
						sampSendChat("/gnews ������������� � ����� �.���-�������� ������������. ���� ���. GPS 1-4.")
					end
					if gosfrac == 4 then
						sampSendChat("/gnews ������������� � ���. ���������� ������������. ���� ���. GPS 1-5.")
					end
				end
				if listMain == 2 then
					if gosfrac == 1 then
						sampSendChat("/gnews ������������� � ����� �.���-������ ��������. ���� �������.")
					end
					if gosfrac == 2 then
						sampSendChat("/gnews ������������� � ����� �.���-������ ��������. ���� �������.")
					end
					if gosfrac == 3 then
						sampSendChat("/gnews ������������� � ����� �.���-�������� ��������. ���� �������.")
					end
					if gosfrac == 1 then
						sampSendChat("/gnews ������������� � ���. ���������� ��������. ���� �������.")
					end
				end
			else
				menuact()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2000)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					showustaw()
				end
				if listMain == 1 then
					showconst()
				end
				if listMain == 2 then
					showepk()
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2001)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					ustaw1 = io.open("moonloader\\government\\ustaw1.txt", "r+") 
					var = "" 
					for line in ustaw1:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2004, "{ffd700}" ..tag.. "����� ������������� (1 ��������)", var, "�����", "�������") 
					ustaw1:close()
				end
				if listMain == 1 then
					ustaw2 = io.open("moonloader\\government\\ustaw2.txt", "r+")
					var = "" 
					for line in ustaw2:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2004, "{ffd700}" ..tag.. "����� ������������� (2 ��������)", var, "�����", "�������")
					ustaw2:close()
				end
				if listMain == 2 then
					ustaw3 = io.open("moonloader\\government\\ustaw3.txt", "r+")
					var = "" 
					for line in ustaw3:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2004, "{ffd700}" ..tag.. "����� ������������� (3 ��������)", var, "�����", "�������")
					ustaw3:close()
				end
			else
				showdocs()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2002)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					const1 = io.open("moonloader\\government\\const1.txt", "r+") 
					var = "" 
					for line in const1:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2005, "{ffd700}" ..tag.. "����������� ����� (1 ��������)", var, "�����", "�������") 
					const1:close()
				end
				if listMain == 1 then
					const2 = io.open("moonloader\\government\\const2.txt", "r+")
					var = "" 
					for line in const2:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2005, "{ffd700}" ..tag.. "����������� ����� (2 ��������)", var, "�����", "�������")
					const2:close()
				end
			else
				showdocs()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2003)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					epk1 = io.open("moonloader\\government\\epk1.txt", "r+") 
					var = "" 
					for line in epk1:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2006, "{ffd700}" ..tag.. "������ �������������� ������ (1 ��������)", var, "�����", "�������") 
					epk1:close()
				end
				if listMain == 1 then
					epk2 = io.open("moonloader\\government\\epk2.txt", "r+")
					var = "" 
					for line in epk2:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2006, "{ffd700}" ..tag.. "������ �������������� ������ (2 ��������)", var, "�����", "�������")
					epk2:close()
				end
				if listMain == 2 then
					epk3 = io.open("moonloader\\government\\epk3.txt", "r+")
					var = "" 
					for line in epk3:lines() do 
						var = var .. "\n" .. line 
					end 
					sampShowDialog(2006, "{ffd700}" ..tag.. "������ �������������� ������ (3 ��������)", var, "�����", "�������")
					epk3:close()
				end
			else
				showdocs()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2004)
		if resultMain == true then
			if buttonMain == 1 then
				showustaw()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2005)
		if resultMain == true then
			if buttonMain == 1 then
				showconst()
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(2006)
		if resultMain == true then
			if buttonMain == 1 then
				showepk()
			end
		end
		if check_time then
			writeMemory(0xB70153, 1, time, 1) 
		end
	end
end

function gosmenu1()
	sampShowDialog(1001, "{ffd700}" ..tag.. "���� ���. ��������", "{ffffff}1. ��������� 3 ������\n2. ��������� ���. ������� � �����������\n3. ��������� ���. ������� �� ���������", "��", "�����", 2)
end

function gosmenu()
	sampShowDialog(1000, "{ffd700}" ..tag.. "���� ���. ��������", "{ffffff}1. ����� ���-�������\n2. ����� ���-������\n3. ����� ���-���������\n4. ������������� ����������", "��", "�����", 2)
end	

function menuact()
	sampShowDialog(110, "{ffd700}" ..tag.. "�������� ����", actmenu[ini.settings.rang], "OK", "������", 2)
end

function func_stime(arg) 
	if #arg == 0 then 
	sampAddChatMessage(tag .. "������� /settime [0-23]", 0xFFD700) 
	else 
		arg = tonumber(arg) 
		if type(arg) ~= "number" then
		sampAddChatMessage(tag .. "������� /settime [0-23]", 0xFFD700) 
		else 
			if arg < 0 or arg > 23 then 
			sampAddChatMessage(tag .. "������� /settime [0-23]", 0xFFD700) 
			else 
				sampAddChatMessage(tag .. "����� ������� ���������� (" .. arg .. ":00)", 0xFFD700) 
				check_time = true
				time = arg 
			end 
		end
	end
end

function specud()
	thread:run("secask1")
end

function setweather(id) 
	if #id == 0 then
	sampAddChatMessage(tag.. "������� /setweather [0-45]", 0xFFD700) 
	else 
		id = tonumber(id) 
		if type(id) ~= "number" then
		sampAddChatMessage(tag.. "������� /setweather [0-45]", 0xFFD700) 
		else 
			if id < 0 or id > 45 then
			sampAddChatMessage(tag .. "������� /setweather [0-45]", 0xFFD700) 
			else 
				sampAddChatMessage(tag.. "������ ������� ���������� (id " .. id .. ")", 0xFFD700) 
				writeMemory(0xC81320, 1, id, 1) 
			end 
		end 
	end
end

function ClearChat() 
	local memory = require "memory" 
	memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200, false) 
	setStructElement(sampGetChatInfoPtr() + 306, 25562, 4, true, false) 
	memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1, false) 
	sampAddChatMessage(tag.. "��� ��� ������� ������", 0xffd700) 
end

function setskin(skinId)
	local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	if #skinId == 0 then
	sampAddChatMessage(tag .. "������� /setskin [id �����]", 0xFFD700)
	else
		skinId = tonumber(skinId) 
		if type(skinId) ~= "number" then
		sampAddChatMessage(tag .. "������� /setskin [id �����]", 0xFFD700)
		else
			if skinId < 1 or skinId > 311 or skinId == 74 then
			sampAddChatMessage(tag .. "{ff0000}������. {ffffff}ID ����� ������ ���� �� 1 �� 311 � �� ���� ����� 74", 0xFFD700)
			else
				sampAddChatMessage(tag .. "���� ������� ������� (id " .. skinId .. ")", 0xFFD700)
				changeSkin(id, skinId)
			end
		end
	end
end

function changeSkin(id, skinId) 
	bs = raknetNewBitStream() 
	if id == -1 then _, id = sampGetPlayerIdByCharHandle(PLAYER_PED) end
	raknetBitStreamWriteInt32(bs, id) 
	raknetBitStreamWriteInt32(bs, skinId) 
	raknetEmulRpcReceiveBitStream(153, bs) 
	raknetDeleteBitStream(bs) 
end

function rooc(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "������� /rn [�����]", 0xffd700)
	else
		sampSendChat("/r (( " ..arg.. " ))")
	end
end

function udost()
	thread:run("udost")
end

function fooc(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "������� /fn [�����]", 0xffd700)
	else
		sampSendChat("/f (( " ..arg.. " ))")
	end
end

function checkid(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "������� /checkid [id]", 0xffd700)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "������� /checkid [id]", 0xffd700)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "������� /checkid [id]", 0xffd700)
			else
				if sampIsPlayerConnected(arg) then
					clr = sampGetPlayerColor(arg)
					clr = tostring(clr)
					sampAddChatMessage(tag.. "ID: " .. arg .. " | ���: " .. sampGetPlayerNickname(arg) .. " | �������: " .. sampGetPlayerScore(arg) .. " | Ping: " .. sampGetPlayerPing(arg) .. " | �����������: " ..clr, 0xffd700)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������", 0xffd700)
				end
			end
		end
	end
end

function uninvite(arg)
	rang = ini.settings.rang
	if rang < 8 then
		sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ ������� �������� � 8 �����", 0xffd700)
	else
		if #arg == 0 then
			sampAddChatMessage(tag.. "������� /uninv [id] [�������]", 0xffd700)
		else
			id, reason = string.match(arg, "(.+) (.+)")
			id = tonumber(id)
			if type(id) ~= "number" then
				sampAddChatMessage(tag.. "������� /uninv [id] [�������]", 0xffd700)
			else
				if #reason == 0 then
					sampAddChatMessage(tag.. "������� /uninv [id] [�������]", 0xffd700)
				else
					if sampIsPlayerConnected(id) then
						thread:run("uval")
					else
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������", 0xffd700)
					end
				end
			end
		end
	end
end

function tagf(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "������� /ft [�����]", 0xffd700)
	else
		sampSendChat("/f " ..ftag[ini.settings.numfr].. " | " ..arg)
	end
end

function luahelp()
	sampShowDialog(10000, "{ffd700}" ..tag.. "������ �� �������", "{ffd700}/settings - {ffffff}��������� �������\n{ffd700}/act {ffffff}| {ffd700}Alt + 1 - {ffffff}�������� ����\n{ffd700}��� + G - {ffffff}�������� ���� �������������� � ����������\n{ffd700}/show - {ffffff}�������� ���������� (����� � �.�.)\n{ffd700}/sobes - {ffffff}�������� �� �������������\n{ffd700}/ud - {ffffff}�������� �������������\n{ffd700}/sud - {ffffff}����������� ����������� �����\n{ffd700}/uninv - {ffffff}������� ���������� � �� ����������\n{ffd700}/rn {ffffff}| {ffd700}/fn - {ffffff}��������� � ����� �����\n{ffd700}/ft - {ffffff}��������� � /f � �����\n{ffd700}��� + H - {ffffff}���� �������� ��������������\n{ffd700}��� + X - {ffffff}�������� ����� �� ����������\n{ffd700}/settime - {ffffff}�������� ����� � ����\n{ffd700}/setweather - {ffffff}�������� ������ � ����\n{ffd700}/weatherhelp - {ffffff}id ����� � �� ��������\n{ffd700}/setskin - {ffffff}��������� �������� ���� (������ ������ ��)\n{ffd700}/checkid - {ffffff}������ ���������� � ������\n{ffd700}/cc - {ffffff}�������� ���", "OK")
end

function weathhelp()
	sampShowDialog(10002, "{FFD700}" ..tag.. "ID ����� � �� ��������", "{32CD32}��� ID ����� ������������ � ������� SetWeather\n{FFD700}0 - 7 = {FFFAFA}������ ������ ����� �����/�������\n{FFD700}08 = {FFFAFA}�����\n{FFD700}09 = {FFFAFA}�������� � �����\n{FFD700}10 = {FFFAFA}����� ����� ���� (������ � ��������� 0-7)\n{FFD700}11 = {FFFAFA}���������� ������\n{FFD700}12 - 15 = {FFFAFA}����� �������, ����������, �������\n{FFD700}16 = {FFFAFA}�������, �������, ���������\n{FFD700}17 - 18 = {FFFAFA}�������� �������\n{FFD700}19 = {FFFAFA}�������� ����\n{FFD700}20 = {FFFAFA}��������/�����������\n{FFD700}21 = {FFFAFA}����� ������, gradiented ���������, ���������\n{FFD700}22 = {FFFAFA}����� ������, gradiented ���������, �������\n{FFD700}23 � 26 = {FFFAFA}��������� �������� ���������\n{FFD700}27 � 29 = {FFFAFA}��������� ������ �����\n{FFD700}30 � 32 = {FFFAFA}��������� �������, ��������, �����\n{FFD700}33 = {FFFAFA}������, �������, ����������\n{FFD700}34 = {FFFAFA}�����/���������, ����������\n{FFD700}35 = {FFFAFA}������� ����������\n{FFD700}36 � 38 = {FFFAFA}�����, ��������, ��������\n{FFD700}39 = {FFFAFA}����������� �����\n{FFD700}40 � 42 = {FFFAFA}�����/��������� �������\n{FFD700}43 = {FFFAFA}������ ��������� ������\n{FFD700}44 = {FFFAFA}������/����� ����\n{FFD700}45 = {FFFAFA}������/��������� ����", "OK")
end

function settings()
	sampShowDialog(0, "{ffd700}" ..tag.. "��������� �������", "{ffffff}��������\t{ffd700}��������\n{ffffff}1. �������:\t{ffd700}" ..ini.settings.name.. "\n{ffffff}2. ����� ��������:\t{ffd700}" ..ini.settings.number.. "\n{ffffff}3. �����������:\t{ffd700}" ..ini.settings.fraction.. "\n{ffffff}4. ����:\t{ffd700}" ..ini.settings.rang.. "\n{ffffff}5. ���:\t{ffd700}" ..ini.settings.sex.. "", "�������", "������", 5)
end

function sobeska()
	sampShowDialog(100, "{ffd700}" ..tag.. "���� �������������", "{ffffff}1. ������������. �� �� �������������?\n2. ��������� ����� ����������\n3. ������ ������ ���������� IC\n4. ������ ������ ���������� ���\n5. ������ ������ � IC\n6. ������ ������ � ���\n7. �� ��� ���������\n8. �� ��� �� ���������", "�������", "������", 2)
end

function showdocs()
	sampShowDialog(2000, "{ffd700}" ..tag.. "������ ���������", "{ffffff}1. ����� �������������\n2. ����������� �����\n3. ������ �������������� ������", "��", "������", 2)
end

function showustaw()
	sampShowDialog(2001, "{ffd700}" ..tag.. "����� �������������", "{ffffff}1 �������� (1-4 �������)\n2 �������� (5-8 �������)\n3 �������� (9-12 �������)", "��", "�����", 2)
end

function showconst()
	sampShowDialog(2002, "{ffd700}" ..tag.. "����������� �����", "{ffffff}1 �������� (1-3 �����)\n2 �������� (4-7 �����)", "��", "�����", 2)
end

function showepk()
	sampShowDialog(2003, "{ffd700}" ..tag.. "���", "{ffffff}1 �������� (1-3 �����)\n2 �������� (4-6 �����)\n3 �������� (7-8 �����)", "��", "�����", 2)
end

function thread_function(option)
	if option == "ohrana1" then
		sampSendChat("C��, ������ ���� ����� ��������, ����� ��� �������� ��������� ����!'")
	end
	if option == "ohrana2" then
		sampSendChat("���, ���������� �������� ������!")
		wait(1000)
		sampSendChat("� ������ ������ ��� �������� ��������� ����.")
	end
	if option == "ohrana3" then
		nick = nick:gsub("_", " ")
		sampSendChat("/me " ..zalomal.. " ���� " ..nick)
		wait(1000)
		sampSendChat("/me " ..povel.. " ���������� � ������")
	end
	if option == "secask1" then
		sampSendChat("������������, � " ..dolzh[ini.settings.rang].. " " ..sfrac[ini.settings.numfr].. " " ..ini.settings.name.. ".")
		wait(1000)
		sampSendChat("���������� �� �� � ���� ������?")
	end
	if option == "secask2" then
		nick = nick:gsub("_", " ")
		sampSendChat("/me " ..peredal.. " ������� ��������� " ..nick)
		wait(1000)
		sampSendChat("/n /adlist")
	end
	if option == "secask3" then
		nick = nick:gsub("_", " ")
		sampSendChat("/me " ..peredal.. " ������� ���������� " ..nick)
		wait(1000)
		sampSendChat("/n /liclist")
	end
	if option == "advask1" then
		sampSendChat("������������, � " ..dolzh[ini.settings.rang].. " " ..sfrac[ini.settings.numfr].. " " ..ini.settings.name.. ".")
		wait(1000)
		sampSendChat("� ��������� ������������� ��������� �� ���. ���������� �� �� � ���� �������?")
	end
	if option == "advask2" then
		sampSendChat("���� ���� ����� ���������� 9.000$.")
	end
	if option == "advask3" then
		sampSendChat("/me " ..otkril.. " ��������")
		wait(1000)
		sampSendChat("/me " ..dostal.. " ����� ''������������ ������������''")
		wait(1000)
		sampSendChat("����� ���� ��� � �������?")
		sampAddChatMessage(tag.. "��� ����������� ��������� ������� {ffd700}F2 {ffffff}��� {ffd700}F3 {ffffff}��� ������", 0xffd700)
		check_key = "advokat1"
	end
	if option == "advask4" then
		sampSendChat("/me ���������� � �����")
		wait(1000)
		sampSendChat("����������� ���������� ����� ������.")
		wait(1000)
		sampSendChat("/n /me ����������(-���)")
		sampAddChatMessage(tag.. "��� ����������� ��������� ������� {ffd700}F2 {ffffff}��� {ffd700}F3 {ffffff}��� ������", 0xffd700)
		check_key = "advokat2"
	end
	if option == "advask5" then
		sampSendChat("/me " ..postavil.. " ������")
		wait(1000)
		sampSendChat("/free " ..id.. " 9000")
	end
	if option == "licask0" then
		sampSendChat("/me " ..dostal.. " �����")
		wait(1000)
		sampSendChat("/me " ..vzal.. " ����� � �����")
		wait(1000)
		sampSendChat("/me ��������� ����� ��������")
		wait(1000)
		sampSendChat("������ ����� ���� ��� � �������.")
		sampAddChatMessage(tag.. "��� ����������� ��������� ������� {ffd700}F2 {ffffff}��� {ffd700}F3 {ffffff}��� ������", 0xffd700)
		check_key = "licer1"
	end
	if option == "licask01" then
		sampSendChat("/me " ..zapolnil.. " ����� ��������")
		wait(1000)
		sampSendChat("/do ����� ��������.")
		wait(1000)
		sampSendChat("�������� �����, ��������� ��� �����.")
		wait(1000)
		sampSendChat("/me " ..peredal.. " �����")
		wait(1000)
		sampSendChat("/n /me ����������(-���)")
		sampAddChatMessage(tag.. "��� ����������� ��������� ������� {ffd700}F2 {ffffff}��� {ffd700}F3 {ffffff}��� ������", 0xffd700)
		check_key = "licer2"
	end
	if option == "licask02" then
		sampSendChat("/me " ..vidal.. " ��������")
		wait(1000)
		if licid == 1 then
			sampSendChat("/givelic " ..id.. " 1 1000")
		end
		if licid == 2 then
			sampSendChat("/givelic " ..id.. "1 10000")
		end
		if licid == 3 then
			sampSendChat("/givelic " ..id.. " 2 30000")
		end
	end
	if option == "changeskin" then
		nick = nick:gsub("_", " ")
		sampSendChat("/me " ..otkril.. " �������, ����� ���� " ..dostal.. " �����")
		wait(1000)
		sampSendChat("/me " ..peredal.. " ����� " ..nick)
		wait(1000)
		sampSendChat("/changeskin " ..id)
	end
	if option == "invite" then
		nick = nick:gsub("_", " ")
		sampSendChat("/do ������� � ����� ����")
		wait(1000)
		sampSendChat("/me " ..otkril.. " �������")
		wait(1000)
		sampSendChat("/me " ..dostal.. " ����� � �������")
		wait(1000)
		sampSendChat("/me " ..peredal.. " " ..nick.. " ����� � �������")
		wait(1000)
		sampSendChat("/me ������ �������")
		wait(1000)
		sampSendChat("/invite " ..id)
	end
	if option == "smenarang" then
		nick = nick:gsub("_", " ")
		sampSendChat("/do ����� ������� ���������� � ������ �������.")
		wait(1000)
		sampSendCHat("/me " ..dostal.. " ����� ������� �� �������")
		wait(1000)
		sampSendChat("/me " ..peredal.. " ����� ������� " ..nick)
		wait(1000)
		sampSendChat("/rang " ..id.. " " ..poviha)
	end
	if option == "udost" then
		sampSendChat("/do ������������� ����� � �������.")
		wait(1000)
		sampSendChat("/me " ..dostal.. " ������������� � �������, ����� ���� " ..peredal.. " ���")
		wait(1000)
		sampSendChat("/do � ������������� ��������: " ..ini.settings.name.. " | " ..ini.settings.number)
		wait(1000)
		sampSendChat("/do " ..ini.settings.fraction.. " | " ..dolzh[ini.settings.rang])
		wait(1000)
		sampSendChat("/me " ..spratal.. " ������������� � ������")
	end
	if option == "doki" then
		hhh, mid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat("���������� ��������� ���� ���������. � ������:")
		wait(1000)
		sampSendChat("�������, ��������, �������� ����� � ������� �� ����.")
		wait(1000)
		sampSendChat("/n /pass " ..mid.. " | /lic " ..mid.. " | /wbook " ..mid.. " | /skill " ..mid)
	end
	if option == "predlic" then
		sampSendChat("������������, � " ..dolzh[ini.settings.rang].. " " ..sfrac[ini.settings.numfr].. " " ..ini.settings.name.. ".")
		wait(1000)
		sampSendChat("���������� �� �� � ���� �������?")
	end
	if option == "profprava" then
		sampSendChat("����. ����� ����� ��� ��� ���������� ������ � ������ ������ ����������.")
		wait(1000)
		sampSendChat("������� ����� �� ���� ����� ���������� ������ �� ���������� � ���������.")
		wait(1000)
		sampSendChat("��� ������� ����. ���� � ��� ��� ������ ���� �������.")
	end
	if option == "napom1" then
		sampSendChat("/r ��������� ����������, ��������� ���.")
		wait(1000)
		sampSendChat("/r ������� ��������� ����� ����� ������ � ���������� �������.")
		wait(1000)
		sampSendChat("/r ��� ������ ��� ���������� - ����� ������.")
	end
	if option == "napom2" then
		sampSendChat("/r ��������� ����������,��������� ��������.")
		wait(1000)
		sampSendChat("/r ���������, ���� �� ��������� ���������� ��� ������ �����...")
		wait(1000)
		sampSendChat("/r �� ������ ������� � �������� � ��.")
	end
	if option == "napom3" then
		sampSendChat("/r ��������� ����������, ���� ��������� ���:")
		wait(1000)
		sampSendChat("/r ������ � �������� ���� ��������� ������������� ��� ������� �����")
		wait(1000)
		sampSendChat("/r ���������� ���������� � ������ � ������� ����� - ����� �������!")
	end
	if option == "napom4" then
		sampSendChat("/r �� ������� ����� ������ �����. ����� � ������� ����� �����.")
		wait(1000)
		sampSendChat("/r ��������� ���� ����������� �����������, ��� ���� �������� �������� �...")
		wait(1000)
		sampSendChat("/r ��������� ������������. ���� ����������� �������� � ����������.")
		wait(1000)
		sampSendChat("/r ��������� �������� ������� �� ���������.")
		wait(1000)
		sampSendChat("/r ����������� ��� ������ � ����������� ������� � ��������� �� ������.")
	end
	if option == "napom5" then
		sampSendChat("/r ��� ��������� �������� ������ �����.")
		wait(1000)
		sampSendChat("/r ������������ ������ � ������ �����, ��������� ����������.")
		wait(1000)
		sampSendChat("/r ������������ ��������� ��������� � ������ ����� ��� ���������� ������� �� ���������.")
		wait(1000)
		sampSendChat("/r �������� �� ����� ���� ������. �������, �������������� ���� ����������� ������������� ��������.")
	end
	if option == "gos01" then
		sampSendChat("/gnews ��������� ������ �����, ������ �������� ������������� � ����� ��.")
		wait(700)
		sampSendChat("/gnews ����������: ��������� 3 ���� � �����, ���� ���������������.")
		wait(700)
		sampSendChat("/gnews ������������� ������� � ����� ����� ��. GPS 1-2.")
	end
	if option == "gos02" then
		sampSendChat("/gnews ��������� ������ �����, ������ �������� ������������� � ����� ��.")
		wait(700)
		sampSendChat("/gnews ����������: ��������� 3 ���� � �����, ���� ���������������.")
		wait(700)
		sampSendChat("/gnews ������������� ������� � ����� ����� ��. GPS 1-3.")
	end
	if option == "gos03" then
		sampSendChat("/gnews ��������� ������ �����, ������ �������� ������������� � ����� ��.")
		wait(700)
		sampSendChat("/gnews ����������: ��������� 3 ���� � �����, ���� ���������������.")
		wait(700)
		sampSendChat("/gnews ������������� ������� � ����� ����� ��. GPS 1-4.")
	end
	if option == "gos04" then
		sampSendChat("/gnews ��������� ������ �����, ������ �������� ������������� � ���. ����������.")
		wait(700)
		sampSendChat("/gnews ����������: ��������� 3 ���� � �����, ���� ���������������.")
		wait(700)
		sampSendChat("/gnews ������������� ������� � ����� ���. ����������. GPS 1-5.")
	end
	if option == "allow" then
		nick = nick:gsub("_", " ")
		sampSendChat("/me " ..peredal.. " ����� �� ���������� " ..nick)
		wait(700)
		sampSendChat("/allow " ..id)
	end
	if option == "uval" then
		sampSendChat("/do � ������� ����� ���.")
		wait(1000)
		sampSendChat("/me " ..dostal.. " ��� �� �������")
		wait(1000)
		sampSendChat("/me " ..zashel.. " �� ������ �����")
		wait(1000)
		sampSendChat("/me " ..annul.. " �������� ����������")
		wait(1000)
		sampSendChat("/uninvite " ..id.. " " ..reason)
		wait(1000)
		sampSendChat("/me " ..spratal.. " ��� � ������")
	end
end