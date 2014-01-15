# Access Control List for Allowed/Denied Clients
#
# If Client.IP does NOT match any of the rules, it will be REJECTED!
# If Client.IP matches both a Deny rule and an Allow rule, it will be REJECTED!
#
# Example Rule:
#	Allow IP:	"192.168.2.3"/32;
#	Allow Net:	"192.168.0.0"/16;
#	Deny IP:	! "192.168.255.255";
#	Allow All:	"0.0.0.0"/0;
acl secure {
	# Only 1 and 1 of these Rules MUST be enabled at a time
	#
	# BlackList: Allow All(Same as Apache Order Deny,Allow):
	"0.0.0.0"/0;
	#
	# WhiteList: Deny All(Same as Apache Order Allow,Deny):
	#! "0.0.0.0"/0;

	# Allow Local Access
	#"localhost";
	#"127.0.0.0"/8;

	# Other Allow or Deny Rules:

}
