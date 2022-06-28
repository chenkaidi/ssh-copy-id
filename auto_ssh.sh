#!/usr/bin/expect  

set timeout 10  
set username [lindex $argv 0]  
set password [lindex $argv 1]  
set hostname [lindex $argv 2]  
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub $username@$hostname
expect {
            #first connect, no public key in ~/.ssh/known_hosts
            # ssh 第一次匹配逻辑
            "Are you sure you want to continue connecting (yes/no)?" {
            send "yes\r"
            expect "*Password:"
                send "$password\r"
            }
            #already has public key in ~/.ssh/known_hosts
            # ssh 第二次配置逻辑，注意 password 还是 Password ？
            "*Password:" {
                send "$password\r"
            }
            "Now try logging into the machine" {
                #it has authorized, do nothing!
            }
        }
expect eof
