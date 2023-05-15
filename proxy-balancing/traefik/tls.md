https://doc.traefik.io/traefik/https/tls/

Dynamic file cfg - only way to cfg certificates (with exception of kuber).

```yaml

# Dynamic configuration

tls:
  certificates:
    - certFile: /path/to/domain.cert
      keyFile: /path/to/domain.key
    - certFile: /path/to/other-domain.cert
      keyFile: /path/to/other-domain.key
```

If no default certificate is provided, Traefik generates and uses a self-signed certificate.

min max tls version

https://doc.traefik.io/traefik/https/tls/#client-authentication-mtls

mTLS

```
tls:
  options:
    default:
      clientAuth:
        # in PEM format. each file can contain multiple CAs.
        caFiles:
          - tests/clientca1.crt
          - tests/clientca2.crt
        clientAuthType: RequireAndVerifyClientCert
```

