# $File: //depot/libOurNet/BBS/lib/OurNet/BBS/Firebird3/Article.pm $ $Author: autrijus $
# $Revision: #5 $ $Change: 3815 $ $DateTime: 2003/01/25 00:54:33 $

package OurNet::BBS::Firebird3::Article;

use if $OurNet::BBS::Encoding, 'encoding' => 'big5', STDIN => undef, STDOUT => undef;

use strict;
no warnings 'deprecated';
use base qw/OurNet::BBS::MAPLE2::Article/;
use fields qw/_ego _hash/;
use OurNet::BBS::Base (
    '$HEAD_REGEX' => qr/�o�H�H: ([^ \(]+)\s?(?:\((.+?)\) )?[^\015\012]*\015?\012��  �D: (.*?)\015?\012�o�H��: [^(]+\((.+?)\)[^\015\012]*\015?\012.*\015?\012/,
);

sub writeok { 0 };
sub readok { 1 };

1;
