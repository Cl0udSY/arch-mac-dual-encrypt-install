# For tui
layout asm
layout reg

# Functions
define setldp
	set environment LD_PRELOAD /root/Security/Tools/LD_PRELOAD_HOOK/$arg0
end

define sl
	tbreak +1
	jump +1
end

define npc
	set $pc = $arg0
end

define hts
	shell (echo -n "0x" && echo -n $arg0 | xxd -r)
end

define sth
	shell (echo -n arg0 | xxd)
end
