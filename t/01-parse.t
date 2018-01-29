#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 2;

use Finance::AlphaVantage;

my $apikey = $ENV{'ALPHAVANTAGE_API_KEY'};

<<<<<<< HEAD
print "Using apikey ".$apikey."\n";
=======
print "Using apikey ".$apikey;
>>>>>>> 3f45d94d7a3dded48288d0bcc8e5bb8295ce8654

my $av = new Finance::AlphaVantage(
   url      =>"https://www.alphavantage.co/query",
   apikey   => $apikey,
   datatype => "json"
);

my $q = $av->process(
    function => 'TIME_SERIES_WEEKLY',
<<<<<<< HEAD
		symbol   => 'BTC',
    market   => 'CNY'
		);
=======
    symbol   => 'BTC',
    market   => 'CNY'
);
>>>>>>> 3f45d94d7a3dded48288d0bcc8e5bb8295ce8654

ok( $av->{lastcall} =~ /function=TIME_SERIES_WEEKLY/, "Verify URL" );

ok( $av->{lastcall} =~ /apikey=/, "Verify apikey" );

