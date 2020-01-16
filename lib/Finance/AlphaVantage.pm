package Finance::AlphaVantage;

use 5.006;
use strict;
use warnings;

use LWP::UserAgent;

=head1 NAME

Finance::AlphaVantage - The great new Finance::AlphaVantage!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

 # creates the av object with default values

 $av = new Finance::AlphaVantage;

 # sets values
 $av->{url}      = "https://www.alphavantage.co/query";
 $av->{apikey}   = "demo";
 $av->{datatype} = "json";

 # or construct

 $av = new Finance::AlphaVantage(
    url      =>"https://www.alphavantage.co/query",
    apikey   => "demo",
    datatype => "json"
 );

 # AlphaVantage functions

 # https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo
 $q = $av->process(
    function => 'TIME_SERIES_WEEKLY',
    symbol   => 'MSFT'
 );

 # https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=demo
 $q = $av->process(
   function => 'TIME_SERIES_INTRADAY',
   symbol   => "MSFT",
   interval => "1min"
 );

=cut

=head1 SUBROUTINES/METHODS

=head2 new

Constructor

=cut

my $SINGLETON = undef;

# Access to the Singleton post-construction
sub instance {
    $SINGLETON or Carp::croak('Finance::AlphaVantage->new has not been called yet');
}

# The order of initialisation here is VERY important
sub new {
    Carp::croak('Finance::AlphaVantage->new already called. Use Finance::AlphaVantage->instance') if $SINGLETON;
    my $class = shift;
    my %opt   = @_;

    my $ua = LWP::UserAgent->new;
    $ua->agent("Perl Finance-AlphaVantage/0.1 ");

    # Create the default object
    my $self = $SINGLETON = bless {
        ua       => $ua,
        url      => $opt{url} || "https://www.alphavantage.co/query",
        apikey   => $opt{apikey} || "demo",
        datatype => $opt{datatype} || "json",

        # Parsed command-line options
        opt => \%opt,
    }, $class;
    return $self;
}

=head2 process

 Gets the function desired.

 # Example

 # https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo
 $q = $av->process(
    function => 'TIME_SERIES_WEEKLY',
    symbol   => 'MSFT'
 );


=cut

sub process {
    my $self = shift;
    my %opts = @_;
    my $url  = $self->{url};
    my $op   = "?";
    map { $url .= $op . $_ . "=" . $opts{$_}; $op = "&"; } keys %opts;
    $url .= "&apikey=" . $self->{apikey};
    $self->{lastcall} = $url;
    my $req = HTTP::Request->new( GET => $url );
    my $res = $self->{ua}->request($req);
    if   ( $res->is_success ) { return $res->content; }
    else                      { return $res->status_line, "\n"; }
}

=head1 AUTHOR

Monsenhor, C<< <filipo at kobkob.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-finance-alphavantage at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Finance-AlphaVantage>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Finance::AlphaVantage

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Finance-AlphaVantage>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Finance-AlphaVantage>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Finance-AlphaVantage>

=item * Search CPAN

L<http://search.cpan.org/dist/Finance-AlphaVantage/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Monsenhor.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1;    # End of Finance::AlphaVantage
