#!/usr/bin/perl
# $File: //depot/libOurNet/BBS/Makefile.PL $ $Author: autrijus $
# $Revision: #7 $ $Change: 8637 $ $DateTime: 2003/10/30 11:42:45 $

use 5.006001;
use inc::Module::Install;

use strict;
use warnings;

my @ciphers = map { "Crypt::$_" } (
    qw/Rijndael Twofish2 Twofish Blowfish IDEA DES/,
    qw/TEA GOST Rijndael_PP Blowfish_PP DES_PP/,
);

my ($have_ciph, @cipher_module);
foreach my $cipher (@ciphers) {
    ++$have_ciph and last if eval "use $cipher (); 1";
}

unless (!$have_ciph) {
    @cipher_module = (
	can_cc() ? ('Crypt::Rijndael' => '0.03')
		 : ('Crypt::Rijndael_PP' => '0.01')
    );
}

requires(
    'Date::Parse'		=> '2.20',	# RAM, MAPLE2, MELIX, NNTP
    'Date::Format'		=> '0.01',	# RAM, MAPLE2, MELIX, NNTP
    'Digest::MD5'		=> '2.10',	# Server, Client, Utils
    'File::Temp'		=> '0.12',	# Test scripts
    'Mail::Address'		=> '1.17',	# BBSAgent, MAPLE2, MELIX
    'Test::Harness'		=> '1.23',
    'File::Spec'		=> '0.6',
    'Hook::LexWrap'		=> '0.01',
    'enum'			=> '1.016',	# MAPLE3
    'if'			=> '0.04',
);
build_requires( 'Test::More'	=> '0.31' );

features(
    'OurNet Server (bbscomd)'	=> [
	-tests   		=> [ <t/*-OurNet-*.t> ],
	recommends(
	    'Storable'		=> '1.011',
	    'Net::Daemon'	=> '0.13',
	    'RPC::PlServer'	=> '0.2013',
	    @cipher_module,
	),
    ],
    'OurNet Client'		=> [
	recommends(
	    'Storable'		=> '1.011',
	    'RPC::PlClient'	=> '0.2013',
	    @cipher_module,
	),
    ],
    'GnuPG Encryption'		=> [ 
	-default		=> (
	    (can_run('gpg') and can_cc()) ? 1 : 0
	),
	recommends(
	    'Class::MethodMaker'=> '1.00',
	    'GnuPG::Interface'	=> '0.31',
	    'Term::ReadKey'	=> '2.13',
	),
    ],
    'Usenet News (NNTP)'	=> [
	recommends(
	    'Net::NNTP'		=> '2.19',
	),
    ],
    'Mailbox File (MailBox)'	=> [
	-default 		=> 0,
	-tests   		=> [ 't/6-MailBox.t' ],
	recommends(
	    'Mail::Internet'	=> '1.0',
	    'MIME::Tools'	=> '5.0',
	    'IO::Scalar'	=> '1.0',
	    'Mail::Box'		=> '1.0',
	),
    ],
    'Telnet BBS (BBSAgent)'	=> [
	-tests   		=> [ 't/5-BBSAgent.t' ],
	recommends(
	    'Net::Telnet'	=> '3.02',
	    'OurNet::BBSAgent'	=> '1.55',
	),
    ],
);

WriteMakefile(
    AUTHOR          => 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT        => 'Component Object Model for BBS systems',
    NAME            => 'OurNet::BBS',
    VERSION_FROM    => 'lib/OurNet/BBS.pm',
    DISTNAME        => 'OurNet-BBS',
    BINARY_LOCATION => 'x86/OurNet-BBS.tar.gz',
    EXE_FILES       => [ <script/*> ],

    dist            => {
        COMPRESS    => 'gzip',
        SUFFIX      => '.gz',
    }
);

sign(1);
check_nmake();
include('ExtUtils::AutoInstall');
auto_install();

