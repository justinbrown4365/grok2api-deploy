FROM ghcr.io/chenyme/grok2api:latest

COPY --chmod=0755 railway-entrypoint.sh /usr/local/bin/railway-entrypoint

ENTRYPOINT ["/usr/local/bin/railway-entrypoint"]

CMD ["/app/grok2api", "--config", "/app/config.yaml", "--listen", "0.0.0.0:8000"]
