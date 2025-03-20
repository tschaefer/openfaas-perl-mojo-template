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
    my $self = shift;
    my ($body, $headers) = @_;

    return { text => "Perl 🐪 Mojolicious 🚀 and OpenFaaS 🐳", status => 200 };
}

1;
