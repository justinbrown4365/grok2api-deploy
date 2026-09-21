FROM ghcr.io/chenyme/grok2api:latest

COPY --chmod=0755 railway-entrypoint.sh /usr/local/bin/railway-entrypoint

ENTRYPOINT ["/usr/local/bin/railway-entrypoint"]
