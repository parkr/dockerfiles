package main

import (
	"context"
	"fmt"
	"net"
	"os"
)

var dialer = net.Dialer{}
var customDnsServer = fmt.Sprintf("127.0.0.1:%s", os.Getenv("TUNNEL_DNS_PORT"))

func main() {
	fmt.Println("dns server:", customDnsServer)
	addrs, err := resolv("github.com")
	if err != nil {
		fmt.Println("unable to resolve github.com:", err)
		os.Exit(1)
	}
	if len(addrs) == 0 {
		fmt.Println("no records for github.com")
		os.Exit(1)
	}
	fmt.Println("github.com addrs:", addrs)
}

func CustomDNS(ctx context.Context, network, address string) (net.Conn, error) {
	return dialer.DialContext(ctx, "udp", customDnsServer)
}

func resolv(host string) ([]net.IPAddr, error) {
	resolver := net.Resolver{
		PreferGo: true,
		Dial:     CustomDNS,
	}
	return resolver.LookupIPAddr(context.Background(), host)
}
