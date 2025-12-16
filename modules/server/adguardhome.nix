{config, lib, pkgs, username, ...}: 
{

    networking.firewall.allowedTCPPorts = [ 3003 ];
    services.adguardhome = {
        enable = true;
        # You can select any ip and port, just make sure to open firewalls where needed
        host = "0.0.0.0";
        port = 3003;
        settings = {
            dns = {
                upstream_dns = [
                    # Example config with quad9
                    "9.9.9.9#dns.quad9.net"
                    "149.112.112.112#dns.quad9.net"
                    # Uncomment the following to use a local DNS service (e.g. Unbound)
                    # Additionally replace the address & port as needed
                    # "127.0.0.1:5335"
                ];
            };
            filtering = {
                protection_enabled = true;
                filtering_enabled = true;

                parental_enabled = false;  # Parental control-based DNS requests filtering.
                safe_search = {
                    enabled = false;  # Enforcing "Safe search" option for search engines, when possible.
                };
            };
            # The following notation uses map
            # to not have to manually create {enabled = true; url = "";} for every filter
            # This is, however, fully optional
            filters = map(url: { enabled = true; url = url; }) [
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_4.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_5.txt"
                "https://adguardteam.github. io/HostlistsRegistry/assets/filter_6.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"  # The Big List of Hacked Malware Web Sites
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt"
                "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt"
                "https://easylist.to/easylist/easylist. txt"
                "https://easylist.to/easylist/easyprivacy.txt"
                "https://easylist.to/easylist/fanboy-annoyance.txt"
                "https://easylist.to/easylist/fanboy-social.txt"
                "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
            ];
            users = [
                { 
                    name = "${username}";
                    password = "$2a$12$YJ0BanFAoriEvCsjneCkEO69IpBlZAEUhAhMXjtdBCYNyKGUr3/TC";
                }
            ];
        };
    };

}