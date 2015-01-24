----
-- Record Session to MP3 file
----

uuid = session:getVariable("uuid");
session:setVariable("RECORD_MIN_SEC", "3");
session:setVariable("RECORD_STEREO", "true");
session:setVariable("RECORD_BRIDGE_REQ", "true");
--session:setVariable("media_bug_answer_req", "true");
session:setVariable("record_post_process_exec_api", "luarun:RecordUpload.lua "..uuid);
-- START RECORD
session:execute("record_session", "/recordings/" ..uuid.. ".mp3");
freeswitch.consoleLog("info", "[RecordSession.lua]: Session record started at "..uuid.."\n");