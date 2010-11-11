# $File: //depot/libOurNet/BBS/lib/OurNet/BBS/CVIC/Session.pm $ $Author: autrijus $
# $Revision: #2 $ $Change: 3792 $ $DateTime: 2003/01/24 19:34:06 $

package OurNet::BBS::CVIC::Session;

use strict;
no warnings 'deprecated';
use base qw/OurNet::BBS::MAPLE2::Session/;
use fields qw/_ego _hash/;
use OurNet::BBS::Base;

sub writeok { 0 };
sub readok { 1 };

1;
