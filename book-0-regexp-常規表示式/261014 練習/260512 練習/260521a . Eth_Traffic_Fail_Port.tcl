set spec 900
if {[info exists ngList]} { unset ngList }
foreach line [regexp -all -inline {\d+\s+0/[ 0-9]+\s+} $get_info] {
	if { [lindex $line end-0] < $spec } {
			set ngPort [lindex $line 0]
			append ngList "$ngPort "
	}
}

if {[info exists ngList]} {
	puts "NG PORT: $ngList"
	return 0
}

set get_info {
[14:59:36:498] root@(none):/diagnostic# traffic_test_1518.sh
[14:59:36:498] Traffic test is running, please wait...
[15:00:31:513] 
[15:00:31:513] spawn telnet 127.0.0.1 12345
[15:00:31:840] Connected to 127.0.0.1
[15:00:31:840] 
[15:00:31:840] Entering character mode
[15:00:31:840] Escape character is '^]'.
[15:00:31:840] 
[15:00:31:840] luaShellExecute: prvTgfSetActiveDevice 0 
[15:00:31:840] return code is 0
[15:00:31:840] Entering LuaCLI took 1446.500800 msec
[15:00:31:840] 
[15:00:31:840]  LUA CLI based on LUA 5.1 from www.lua.org
[15:00:31:849]  LUA CLI uses Mini-XML engine from www.minixml.org
[15:00:31:849] ***************************************************
[15:00:31:851]                LUA CLI shell ready
[15:00:31:851] ***************************************************
[15:00:31:851] 
[15:00:31:851] Console# set output nopause
[15:00:31:851] Console# show interfaces status all
[15:00:31:851] 
[15:00:31:851] Dev/Port     Mode    Link   Speed  Duplex    Loopback      Autoneg      FEC        Link Scan   Port Manager
[15:00:31:851] ---------  --------  -----  -----  ------  -------------  ---------  ----------   -----------  ------------
[15:00:31:851] 
[15:00:31:851] 0/0        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/1        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/2        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/3        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/4        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/5        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/6        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/7        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/8        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/9        USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/10       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/11       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:851] 0/12       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/13       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/14       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/15       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/16       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/17       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/18       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/19       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/20       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/21       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/22       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/23       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/24       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/25       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/26       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:31:859] 0/27       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/28       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/29       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/30       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/31       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/32       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/33       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/34       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/35       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/36       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/37       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/38       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/39       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/40       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/41       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/42       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:194] 0/43       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:204] 0/44       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:204] 0/45       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:204] 0/46       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:206] 0/47       USX_OUSGMII Up     1G     Full        None        No         None          None       Link-Up      
[15:00:32:206] 
[15:00:32:206] 
[15:00:32:206] Console# clear bridge type 0 all
[15:00:32:206] Console# do show mac address-table device all
[15:00:32:206] There is no mac address information to show.
[15:00:32:206] 
[15:00:32:208] Console# shell-execute linespeed_use_pve_set 0
[15:00:32:208] luaShellExecute: linespeed_use_pve_set 0 
[15:00:32:208] return code is 0
[15:00:32:208] Console# shell-execute linespeed_init
[15:00:32:208] luaShellExecute: linespeed_init 
[15:00:32:210] ecs4150_model_id: 11
[15:00:32:210] return code is 0
[15:00:32:210] Console# configure
[15:00:32:210] Console(config)# interface range ethernet 0/0-47
[15:00:32:210] Console(config-if)# switchport allowed vlan add 1 untagged
[15:00:32:216] Console(config-if)# end
[15:00:32:216] Console# shell-execute linespeed_pkt_config_set 1518 0xaa 30 30
[15:00:32:216] luaShellExecute: linespeed_pkt_config_set 1518 0xaa 30 30 
[15:00:32:216] return code is 0
[15:00:32:216] Console# shell-execute linespeed_run
[15:00:32:216] luaShellExecute: linespeed_run 
[15:00:32:216] -------------------------------------------------------------------------------------
[15:00:32:216]     RUNNING TRAFFIC TEST:
[15:00:32:216]         Traffic Configuration (General):
[15:00:32:216]          - Packet Size:       1518 bytes.
[15:00:32:216]          - Pattern:           0xaa.
[15:00:32:216]          - Time:              30 seconds.
[15:00:32:216]          - Number of Packets: 30 packets.
[15:00:32:216]         Traffic Configuration (2.5G Ports):
[15:00:32:216]          - Packet Size:       1500 bytes.
[15:00:32:216]          - Pattern:           0xff.
[15:00:32:216]          - Time:              60 seconds.
[15:00:32:216]          - Number of Packets: 3 packets.
[15:00:32:216]         Traffic Configuration (25G Ports):
[15:00:32:216]          - Packet Size:       1500 bytes.
[15:00:32:216]          - Pattern:           0xff.
[15:00:32:216]          - Time:              60 seconds.
[15:00:32:216]          - Number of Packets: 60 packets.
[15:00:32:216] -------------------------------------------------------------------------------------
[15:00:32:216] Please wait...
[15:00:32:224] return code is 0
[15:00:32:224] Console# configure
[15:00:32:224] Console(config)# interface range ethernet 0/0-47
[15:00:32:224] Console(config-if)# switchport allowed vlan remove 1
[15:00:32:224] Console(config-if)# end
[15:00:32:224] Console# shell-execute linespeed_stop
[15:00:32:224] luaShellExecute: linespeed_stop 
[15:00:32:224] return code is 0
[15:00:32:224] Console# sleep 5000
[15:00:32:550] Console# shell-execute linespeed_show
[15:00:32:550] luaShellExecute: linespeed_show 
[15:00:32:550] 
[15:00:32:550] ------ --------- ------------------ ------------------ ------------------ ------------------ --------------
[15:00:32:550]  Port  Interface      UC Sent           UC Received        Octets Sent      Octets Received      Rate      
[15:00:32:550] ------ --------- ------------------ ------------------ ------------------ ------------------ --------------
[15:00:32:550]    1      0/ 0            3744448            3743512         5699049856         5697625264       987 Mbps 
[15:00:32:550]    2      0/ 1            3743512            3744448         5697625264         5699049856       987 Mbps 
[15:00:32:550]    3      0/ 2            3742776            3741952         5696505072         5695250944       987 Mbps 
[15:00:32:550]    4      0/ 3            3741952            3742776         5695250944         5696505072       987 Mbps 
[15:00:32:550]    5      0/ 4            3741094            3740340         5693945068         5692797480       987 Mbps 
[15:00:32:550]    6      0/ 5            3740340            3741094         5692797480         5693945068       987 Mbps 
[15:00:32:550]    7      0/ 6            3739412            3738561         5691385064         5690089842       987 Mbps 
[15:00:32:550]    8      0/ 7            3738561            3739412         5690089842         5691385064       987 Mbps 
[15:00:32:550]    9      0/ 8            3737834            3736935         5688983348         5687615070       987 Mbps 
[15:00:32:550]   10      0/ 9            3736935            3737834         5687615070         5688983348       987 Mbps 
[15:00:32:550]   11      0/10            3736211            3735387         5686513142         5685259014       987 Mbps 
[15:00:32:550]   12      0/11            3735387            3736211         5685259014         5686513142       987 Mbps 
[15:00:32:550]   13      0/12            3734475            3733705         5683870950         5682699010       987 Mbps 
[15:00:32:560]   14      0/13            3733705            3734475         5682699010         5683870950       987 Mbps 
[15:00:32:560]   15      0/14            3732913            3732044         5681493586         5680170968       987 Mbps 
[15:00:32:560]   16      0/15            3732044            3732913         5680170968         5681493586       987 Mbps 
[15:00:32:560]   17      0/16            3731250            3730440         5678962500         5677729680       987 Mbps 
[15:00:32:560]   18      0/17            3730440            3731250         5677729680         5678962500       987 Mbps 
[15:00:32:560]   19      0/18            3729543            3728748         5676364446         5675154456       987 Mbps 
[15:00:32:560]   20      0/19            3728748            3729543         5675154456         5676364446       987 Mbps 
[15:00:32:560]   21      0/20            3727845            3727073         5673780090         5672605106       987 Mbps 
[15:00:32:560]   22      0/21            3727073            3727845         5672605106         5673780090       987 Mbps 
[15:00:32:560]   23      0/22            3726245            3725482         5671344890         5670183604       987 Mbps 
[15:00:32:560]   24      0/23            3725482            3726245         5670183604         5671344890       987 Mbps 
[15:00:32:560]   25      0/24            3724658            3723765         5668929476         5667570330       987 Mbps 
[15:00:32:560]   26      0/25            3723765            3724658         5667570330         5668929476       987 Mbps 
[15:00:32:560]   27      0/26            3722978            3722197         5666372516         5665183834       987 Mbps 
[15:00:32:560]   28      0/27            3722197            3722978         5665183834         5666372516       987 Mbps 
[15:00:32:560]   29      0/28            3721330            3720549         5663864260         5662675578       987 Mbps 
[15:00:32:560]   30      0/29            3720549            3721330         5662675578         5663864260       987 Mbps 
[15:00:32:560]   31      0/30            3719716            3718857         5661407752         5660100354       987 Mbps 
[15:00:32:571]   32      0/31            3718857            3719716         5660100354         5661407752       987 Mbps 
[15:00:32:576]   33      0/32            3717958            3717123         5658732076         5657461206       987 Mbps 
[15:00:32:727]   34      0/33            3717123            3717958         5657461206         5658732076       987 Mbps 
[15:00:32:727]   35      0/34            3716290            3715582         5656193380         5655115804       987 Mbps 
[15:00:32:730]   36      0/35            3715582            3716290         5655115804         5656193380       987 Mbps 
[15:00:32:730]   37      0/36            3714736            3713819         5653828192         5652432518       987 Mbps 
[15:00:32:730]   38      0/37            3713819            3714736         5652432518         5653828192       987 Mbps 
[15:00:32:730]   39      0/38            3713005            3712215         5651193610         5649991230       987 Mbps 
[15:00:32:730]   40      0/39            3712215            3713005         5649991230         5651193610       987 Mbps 
[15:00:32:730]   41      0/40            3711411            3710575         5648767542         5647495150       987 Mbps 
[15:00:32:730]   42      0/41            3710575            3711411         5647495150         5648767542       987 Mbps 
[15:00:32:730]   43      0/42            3709781            3708880         5646286682         5644915360       987 Mbps 
[15:00:32:730]   44      0/43            3708880            3709781         5644915360         5646286682       987 Mbps 
[15:00:32:730]   45      0/44            3708056            3707335         5643661232         5642563870       987 Mbps 
[15:00:32:730]   46      0/45            3707335            3708056         5642563870         5643661232       987 Mbps 
[15:00:32:730]   47      0/46            3706425            3705659         5641178850         5640012998       987 Mbps 
[15:00:32:730]   48      0/47            3705659            3706425         5640012998         5641178850       987 Mbps 
[15:00:32:730] ------ --------- ------------------ ------------------ ------------------ ------------------ --------------
[15:00:32:730] return code is 0
[15:00:32:730] Console# shell-execute linespeed_end
[15:00:32:742] luaShellExecute: linespeed_end 
[15:00:32:750] return code is 0
[15:00:32:750] Console# CLIexit
[15:00:32:750] Connection closed by foreign host
[15:00:36:846] root@(none):/diagnostic# 
}
