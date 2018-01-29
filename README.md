<<<<<<< HEAD
#Finance::AlphaVantage

Simple Perl client for www.alphavantage.co quotes.

##Usage
=======
# Finance::AlphaVantage

Simple client for www.alphavantage.co quotes.

## Usage
>>>>>>> 3f45d94d7a3dded48288d0bcc8e5bb8295ce8654

```perl

use Finance::AlphaVantage;

my $apikey = $ENV{'ALPHAVANTAGE_API_KEY'};

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
  
```
For more information use:


```shell

perldoc Finance::AlphaVantage

```

