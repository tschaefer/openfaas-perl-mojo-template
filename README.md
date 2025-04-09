# OpenFaaS Perl Template

OpenFaaS template based on the official
[Perl Docker image](https://hub.docker.com/_/perl/) and the
[web framework Mojolicious](https://mojolicious.org/).

## Usage
Use `faas-cli` to pull and create your Perl function.

```bash
faas-cli template pull https://github.com/tschaefer/openfaas-perl-mojo-template
faas-cli new --lang perl-mojo mojo
```

Edit the **run** method in the `mojo/handler.rb` file to return some text /
html.

```perl
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
```

Build and publish the function.

```bash
faas-cli up -f stack.yml
```

To install further OS packages or CPAN modules set the build argument in the
`stack.yml` file.

```diff
functions:
  mojo:
    lang: perl-mojo
    handler: ./mojo
+    build_args:
+      ADDITIONAL_PACKAGES: "build-essential libssl-dev"
+      ADDITIONAL_CPAN_PACKAGES: "Readonly URI"
```

### Example

Publish Minio Bucket Event to Redis Topic.

```perl
package Handler;

use strict;
use warnings;

use utf8;

use Mojo::JSON qw(decode_json encode_json);
use Redis;

sub new {
    my $class = shift;
    my $self = {};

    return bless $self, $class;
}

sub run {
    my $self = shift;
    my ($body, $headers) = @_;

    my $minio_bucket_event = decode_json($body);
    my $message = {
        EventName => $minio_bucket_event->{EventName},
        Key       => $minio_bucket_event->{Key}
    };
    $self->_publish($message);

    return { json => "Ok" , status => 200 };
}

sub _publish {
    my $self = shift;
    my ($message) = @_;

    my $redis = Redis->new(
        server => 'redis.example.com:8888',
        ssl    => 1,
    );
    $redis->auth('password');
    $redis->publish('minio:bucket:event', encode_json($message));

    return;
}

1;

```
