#!/home/wjrh/.opam/system/bin/liquidsoap

set("log.file",true)
set("log.file.path","/home/wjrh/liquidsoap-daemon/log/wjrh-robodj-run.log")
set("init.daemon",true)
set("init.daemon.change_user",true)
set("init.daemon.change_user.group","wjrh")
set("init.daemon.change_user.user","wjrh")
set("init.daemon.pidfile",true)
set("init.daemon.pidfile.path","/home/wjrh/liquidsoap-daemon/pid/wjrh-robodj-run.pid")
%include "/home/wjrh/liquidsoap-daemon/script/wjrh-robodj.liq"
