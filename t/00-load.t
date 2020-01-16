#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok('Finance::AlphaVantage') || print "Bail out!\n";
}

diag("Testing Finance::AlphaVantage $Finance::AlphaVantage::VERSION, Perl $], $^X");
