----
-- Upload MP3 file to CDR Server
----

uuid = argv[1];

api = freeswitch.API();
freeswitch.msleep(2000);
rec_file = "/recordings/"..uuid;
cdr_url = freeswitch.getGlobalVariable("cdr_url");
freeswitch.consoleLog("info", "[RecordUpload.lua]: Session record stopped at "..uuid.."\n");

function shell(c)
  local o, h
  h = assert(io.popen(c,"r"))
  o = h:read("*all")
  h:close()
  return o
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

if (file_exists(rec_file..".mp3") ) then
	r = api:executeString("http_put "..cdr_url.."/api/formLoadFile/"..uuid.."/mp3 "..rec_file..".mp3");
	freeswitch.consoleLog("debug", "[RecordUpload.lua]: "..r);
	if (r:gsub("%s*$", "") == '+OK') then
		del = "/bin/rm -rf "..rec_file..".mp3";
		freeswitch.consoleLog("debug", "[RecordUpload.lua]: "..del.."\n");
		shell(del);
	end
end