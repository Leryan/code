package main

type Channels struct {
	Id           int    `xmlrpc:"id"`
	Label        string `xmlrpc:"label"`
	Name         string `xmlrpc:"name"`
	ProviderName string `xmlrpc:"provider_name"`
	Packages     int    `xmlrpc:"packages"`
	Systems      int    `xmlrpc:"systems"`
	ArchName     string `xmlrpc:"arch_name"`
}
