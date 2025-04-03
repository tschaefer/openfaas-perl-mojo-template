package Handler;

use strict;
use warnings;

use utf8;

sub new {
    my $class = shift;
    my $self = {};

    return bless $self, $class;
}

sub run {
    my ($self, $body, $headers, $params) = @_;

    return { text => "Perl 🐪 Mojolicious 🚀 and OpenFaaS 🐳", status => 200 };
}

1;
