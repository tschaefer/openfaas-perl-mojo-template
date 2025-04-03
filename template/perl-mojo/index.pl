#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/function";

use Mojolicious::Lite -signatures;

use Handler;

any '/' => sub ($c) {
    my $handler = Handler->new;
    my ($response, $headers) = $handler->run($c->req->body, $c->req->headers->to_hash, $c->req->params->to_hash);

    $c->res->headers->add(%$headers) if $headers;

    $c->render(%$response);
};

app->start;
