#!/usr/bin/perl -w
#
#	$Id$
#	$Author: jeff $
#
# Package: Remitt::Plugin::Transport::FreeClaims
#
#	FreeClaims transport plugin. This allows claims to be sent to the
#	freeclaims.com clearinghouse transparently.
#

package Remitt::Plugin::Transport::FreeClaims;

use Remitt::Utilities;
use File::Temp ();	# comes with Perl 5.8.x
use WWW::Mechanize;
use Data::Dumper;

sub Transport {
	my ( $input ) = @_;

	# Here's the cluster-fsck ...
	#
	# 	When dealing with a multi-user environment, there isn't a
	# 	good way to centrally store the username and password
	# 	that is to be used. Going to hack a temporary solution, but
	# 	that isn't going to fly with HIPAA regulations, methinks.
	#
	my $c = Remitt::Utilities::Configuration ();
	my $username = $c->val('freeclaims', $user.'-username');
	my $password = $c->val('freeclaims', $user.'-password');

	# Have to write input to temporary bill file ...
	# name should be stored in "$tempbillfile"
	my $fh = new File::Temp ( UNLINK => 1 );
	my $tempbillfile = $fh->filename;

	# Put date into file
	open TEMP, '>'.$tempbillfile or die("$!");
	print TEMP $input;
	close TEMP;

	# Login to FreeClaims
	my $url = 'https://secure.freeclaims.com/docs/login.asp';
	my $m = WWW::Mechanize->new();
	print " * Getting initial logon page ... ";
	$m->get($url);
	print "[done]\n";

	print " * Logging in ... ";
	$m->submit_form(
		form_name => 'loginForm',
		fields => {
			username => $username,
			userpassword => $password
		}
	);
	print "[done]\n";
	syslog('notice', 'FreeClaims transport| Logged into freeclaims.com with username '.$username);

	# Upload claim file
	print " * Fetching upload form ... ";
	$m->get('https://secure.freeclaims.com/docs/upload.asp');
	print "[done]\n";
	
	print " * Uploading $tempbillfile to server ... ";
	$m->submit_form(
		form_name => 'Upload',
		fields => {
			file1 => $tempbillfile
		}
	);
	print "[done]\n";

	return Remitt::Utilities::StoreContents ( $input, 'plaintext', 'txt');
} # end method Transport

# Method: Config
#
# 	Return configuration hash for this plugin.
#
# Returns:
#
# 	Hash containing the configuration information
#
sub Config {
	return +{
		'InputFormat' => [ 'text', 'x12' ]
	};
} # end sub Config

sub test {
	print "\nNo test for FreeClaims transport yet ... \n";
	print "\n---\n";
} # end sub test

1;

