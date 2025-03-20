#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/function";

use Mojolicious::Lite -signatures;
use Mojo::Log;

use Handler;

app->log(Mojo::Log->new);

any '/' => sub ($c) {
    my $handler = Handler->new;
    my ($response, $headers) = $handler->run($c->req->body, $c->req->headers);

    $c->res->headers->add(%$headers) if $headers;

    $c->render(%$response);
};

app->start;
