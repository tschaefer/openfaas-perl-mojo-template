# OpenFaaS Perl Template

OpenFaaS template based on the official
[Perl Docker image](https://hub.docker.com/_/perl/) and the
[web framework Mojolicious](https://mojolicious.org/).

## Usage
Use `faas-cli` to pull, create, build and deploy your Perl function.

```bash
faas-cli template pull https://github.com/tschaefer/openfaas-perl-mojo-template
faas-cli new --lang perl-mojo mojo
faas-cli up -f stack.yml
```

To install further CPAN modules set the build argument in the `stack.yml` file.

```diff
functions:
  mojo:
    lang: perl-http
    handler: ./mojo
+    build_args:
+      ADDITIONAL_CPAN_PACKAGES: "Readonly URI"
```
