#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 2;

use Finance::AlphaVantage;

my $apikey = $ENV{'ALPHAVANTAGE_API_KEY'};

print "Using apikey ".$apikey."\n";

my $av = new Finance::AlphaVantage(
    url      => "https://www.alphavantage.co/query",
    apikey   => $apikey,
    datatype => "json"
);

my $q = $av->process(
    function => 'TIME_SERIES_WEEKLY',
    symbol   => 'BTC',
    market   => 'CNY'
);

ok( $av->{lastcall} =~ /function=TIME_SERIES_WEEKLY/, "Verify URL" );

ok( $av->{lastcall} =~ /apikey=/, "Verify apikey" );

