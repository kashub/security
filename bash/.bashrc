# A shell function to super quickly block IP or CIDR with iptables
# Just add it to your .bashrc
#
# Examples:
#
# Block quickly 1 IP address without providing a reason, to just block ASAP (will provide default reason "quick block"):
# b 103.54.154.222
# Output:
# Blocked 103.54.154.222 with reason: quick block
#
# Block the whole CIDR and provide a reason:
# b 101.16.0.0/12 "Script kiddies from some Chinease ISP"
# Output:
# Blocked 101.16.0.0/12 with reason: Script kiddies from some Chinease ISP
#
# Enjoy!

b() {
  if [ -z "$1" ]; then
    echo "Usage: b <IP> [reason]"
    return 1
  fi

  local ip="$1"
  local reason="${2:-quick block}"

  sudo iptables -I INPUT -s "$ip" -j DROP -m comment --comment "$reason"
  echo "Blocked $ip with reason: $reason"
}

