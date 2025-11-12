FROM ghcr.io/openfaas/of-watchdog:0.10.12 AS watchdog

FROM perl:5.43.4-slim

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

ARG ADDITIONAL_PACKAGES
RUN apt update \
    && apt install --no-install-recommends --yes ${ADDITIONAL_PACKAGES} \
    && apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives

ARG ADDITIONAL_CPAN_PACKAGES
RUN cpanm -n Mojolicious ${ADDITIONAL_CPAN_PACKAGES} \
    && mkdir -p /home/app

WORKDIR /home/app

COPY index.pl .
COPY function function

RUN groupadd --system app \
    && useradd --system --gid app app \
    && chown -R app:app /home/app

USER app

ENV fprocess="perl index.pl daemon -l http://127.0.0.1:5000"
EXPOSE 8080

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

ENV upstream_url="http://127.0.0.1:5000"
ENV mode="http"

CMD ["fwatchdog"]
