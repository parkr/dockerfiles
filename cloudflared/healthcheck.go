package main

import (
	"context"
	"fmt"
	"net"
	"os"
)

var dialer = net.Dialer{}
var customDnsServer = fmt.Sprintf("127.0.0.1:%s", os.Getenv("TUNNEL_DNS_PORT"))
var hostQuery = "github.com"

func CustomDNS(ctx context.Context, network, address string) (net.Conn, error) {
	return dialer.DialContext(ctx, "udp", customDnsServer)
}

func main() {
	fmt.Println("dns server:", customDnsServer)
	resolver := net.Resolver{
		PreferGo: true,
		Dial:     CustomDNS,
	}
	addrs, err := resolver.LookupIPAddr(context.Background(), hostQuery)
	if err != nil {
		fmt.Printf("unable to resolve %s: %+v\n", hostQuery, err)
		os.Exit(1)
	}
	if len(addrs) == 0 {
		fmt.Printf("no records for %s\n", hostQuery)
		os.Exit(1)
	}
	fmt.Printf("%s addrs: %v\n", hostQuery, addrs)
}
