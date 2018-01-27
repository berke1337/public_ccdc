#!/usr/bin/env ruby

# Cisco VLAN creation script
# Starts from the enabled "Switch#" prompt
# Competition switch will only have 24 ports. Likey 23 & 24 are fiber ports!
# Also - likely the modern switches would not be user FastEthernet but GigaEthernet interfaces.

[true, false].each do |practice|
    type = practice ? "practice" : "competition"
    File.open("setup_switch_#{type}.txt", "w") do |file|
        ports = practice ? 48 : 24
        file.puts "# #{type} script, run from serial or the last port"

        file.puts "configure terminal"
        file.puts "vtp mode transparent"
        file.puts "no spanning-tree vlan 1-4094"
        file.puts "no cdp run"
        file.puts "no snmp-server"

        # Assign each port to a VLAN
        # Note: we're skipping port 0/2 because it's the bastion.
        ([1] + (3..(ports - 1)).to_a).each do |port|
            file.puts "interface FastEthernet 0/#{port}"
            file.puts "switchport mode access"
            file.puts "switchport nonegotiate"
            file.puts "switchport access vlan 1#{port.to_s.rjust(2, "0")}"
            file.puts "exit"
        end

        if practice
            file.puts "interface GigabitEthernet 0/2"
            file.puts "switchport mode access"
            file.puts "switchport nonegotiate"
            file.puts "switchport access vlan 149"
            file.puts "exit"

            # file.puts "interface vlan 149"
            # file.puts "ip address 10.42.43.253 255.255.255.0"
            # file.puts "no shutdown"
            # file.puts "exit"

            # file.puts "interface vlan 1"
            # file.puts "no ip address"
            # file.puts "exit"
        else
            # Disable HTTP server of switch.
            file.puts "no ip http server"
            file.puts "no ip http secure-server"
        end

        # Setup Trunk
        file.puts "interface FastEthernet 0/2"
        file.puts "switchport mode trunk"
        file.puts "switchport nonegotiate"
        file.puts "switchport trunk encapsulation dot1q" if practice
        file.puts "switchport trunk allowed vlan all"
        file.puts "switchport trunk native vlan 100"
        # Covered by 'no spanning-tree' above
        #file.puts "spanning-tree bpdufilter enable"
        file.puts "exit"
        file.puts "exit"
        file.puts "write"
        file.puts "copy running-config startup-config"

        puts "Writing #{type} script complete."
    end
end
