package Handler;

use strict;
use warnings;

use utf8;

sub new {
    my $class = shift;
    my $self = {};

    return bless $self, $class;
}

##
# This is the function that will be called on any request, receiving the
# following parameters:
#
# $body    Contains any HTTP content.
# $headers Hash reference of HTTP headers.
# $params  Hash reference of URL parameters.
#
# The return value is a hash reference containing the response content to be
# rendered and the HTTP status code. Optionally, it returns a hash reference
# of custom HTTP headers.
sub run {
    my ($self, $body, $headers, $params) = @_;

    return { text => "Perl 🐪 Mojolicious 🚀 and OpenFaaS 🐳", status => 200 };
}

1;
