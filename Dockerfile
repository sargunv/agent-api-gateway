# syntax=docker/dockerfile:1

FROM gcr.io/distroless/static-debian12

ARG TARGETPLATFORM

COPY ${TARGETPLATFORM}/codex-gateway /codex-gateway

# Run as root so rootless engines map us to the host uid that owns auth.json
# (0600), and so the file is reachable without --user/--userns overrides.
# CODEX_HOME=/ makes the binary default to /auth.json.
# Listen on 0.0.0.0 so port-forwarded traffic reaches us; the -p mapping
# controls host-side exposure.
ENV CODEX_HOME=/
EXPOSE 8080
ENTRYPOINT ["/codex-gateway"]
CMD ["serve", "--addr", "0.0.0.0:8080"]