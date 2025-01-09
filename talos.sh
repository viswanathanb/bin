ta() {
    talosctl -e 192.168.100.100 -n 192.168.100.101,192.168.100.102 "$@"
}

tag() {
    talosctl -e 192.168.100.100 -n 192.168.100.101,192.168.100.102 get "$@"
}

tn() {
    local ip="192.168.100.$1"
    shift
    talosctl --talosconfig /root/code/talos/talosconfig -e  192.168.100.100 -n "$ip" "$@"
}

etcd() {
    local ip="192.168.100.$1"
    shift
    talosctl --talosconfig /root/code/talos/talosconfig -e  192.168.100.100 -n $ip etcd "$@" 
}

c() {
    local ip="192.168.100.100"
    talosctl --talosconfig /root/code/talos/talosconfig -e  192.168.100.100 -n "$ip" "$@"
}

cg() {
    talosctl --talosconfig /root/code/talos/talosconfig -e  192.168.100.100 -n 192.168.100.100 get "$@"
}

w() {
    talosctl --talosconfig /root/code/talos/talosconfig -e  192.168.100.100 -n 192.168.100.101  "$@"  
}

wg() {
    talosctl --talosconfig /root/code/talos/talosconfig -e  192.168.100.100 -n 192.168.100.101 get "$@"
}