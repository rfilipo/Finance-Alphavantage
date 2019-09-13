# Finance::AlphaVantage

Simple client for www.alphavantage.co quotes.

It's aimed to be used in the App::Tulip system.

https://github.com/rfilipo/App-Tulip


## Install

```shell

cpanm https://github.com/rfilipo/Finance-Alphavantage.git

```

## Usage

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
    symbol   => 'BTC',
    market   => 'CNY'
);
  
```
For more information use:


```shell

perldoc Finance::AlphaVantage

```

