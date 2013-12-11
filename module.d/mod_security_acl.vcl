# Access Control List for Allowed/Denied Clients
# Example:
#	Allow IP:	"192.168.2.3";
#	Allow Net:	"192.168.0.0"/16;
#	Deny IP:	! "192.168.255.255"
acl secure {
	"localhost";
	"127.0.0.0"/8;
}
