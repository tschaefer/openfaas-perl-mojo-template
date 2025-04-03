package Handler;

use Mojo::Base -base;

has 'log';

sub run {
    my ($self, $request) = @_;

    return { text => "Perl 🐪 Mojolicious 🚀 and OpenFaaS 🐳", status => 200 };
}

1;
