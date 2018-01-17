#!/bin/env adedit
package require ade_lib
#requires one arg - domain user name to bind with
#example:
# ./create_user.sh a058384-aa
bind harlandclarke.local $argv

#define user details
set sam_name "a059420@harlandclarke.local"
set login_name "a059420"
set uid_val "59420"
set gid_val "10000"
set def_home "/home/a059420"
set def_shell "/bin/bash"

#open zone file
set zones [open "./zone_group"]
set zone_data [read $zones]
#close file
close $zones
set list [split $zone_data "\n"]

foreach zone $list {
    if { $zone ne "" } {
      puts "============================================================================="
      puts "starting on zone $zone"
      select_zone $zone
      #full user name (sam name)
      new_zone_user $sam_name
      #login name
      set_zone_user_field uname $login_name
      #uid (last 5 of a#)
      set_zone_user_field uid $uid_val
      #primary group (aixadmins)
      set_zone_user_field gid $gid_val
      #home dir
      set_zone_user_field home $def_home
      #shell
      set_zone_user_field shell $def_shell
      #enabled
      set_zone_user_field enabled "1"
      #save
      save_zone_user
      #list_zone_users
      show
    }
}
quit
