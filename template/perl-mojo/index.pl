#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/function";

use Mojolicious::Lite -signatures;
use Mojo::Log;

app->log(Mojo::Log->new);
app->log->level('info');

use Handler;

any '/' => sub ($c) {
    my $handler = Handler->new(log => app->log);
    my ($response, $headers) = $handler->run($c->req);

    $c->res->headers->add(%$headers) if $headers;

    $c->render(%$response);
};

app->start;
