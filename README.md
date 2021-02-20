# haproxy-auth-gateway ![Docker Hub](https://img.shields.io/docker/cloud/build/lukasz/haproxy-auth-gateway) ![Docker](https://github.com/lukaszbudnik/haproxy-auth-gateway/workflows/Docker%20Image%20CI/badge.svg)

haproxy-auth-gateway is an authentication and authorization gateway for cloud native apps.

haproxy-auth-gateway features are:

- parsing JWT token from the HTTP Authorization header
- Keycloak realm roles support
- RS256 signature verification
- expiration time verification
- issuer verification
- audience verification

haproxy-auth-gateway can be configured with the following env variables:

- `OAUTH_PUBKEY_PATH` - contains location to issuer public key (mandatory)
- `OAUTH_ISSUER` - contains name of the issuer (optional)
- `OAUTH_AUDIENCE` - contains name of the audience (optional)

# Docker image

haproxy-auth-gateway is available on docker hub:

```
lukasz/haproxy-auth-gateway
```

# Example

A sample JWT token generated by Keycloak looks like this:

```
eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJXejFuaDNCWDI4UHMxVEMzSDRoOW52Q1VWRXpjVVBzQms4Z1NmeEp4ZS1JIn0.eyJleHAiOjE2MTM4NTQ3OTgsImlhdCI6MTYxMzg1Mzg5OCwiYXV0aF90aW1lIjoxNjEzODUzNjk2LCJqdGkiOiIxMmI1YTMxYS1hYjM1LTQxMDMtYTkxNC0wZjRlODUzMzg4ZjUiLCJpc3MiOiJodHRwczovL2F1dGgubG9jYWx0ZXN0Lm1lL2F1dGgvcmVhbG1zL2hvdGVsIiwic3ViIjoiMWE1NWUxMjktZjliYi00ZDYwLWJlZDEtMGJhYmIwOWJlZTNlIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicmVhY3QiLCJub25jZSI6Ijg4NGNiMzY1LTRjMTQtNDZhYS04ZTBjLWViM2Q3ZjBjYTRmMCIsInNlc3Npb25fc3RhdGUiOiI3NDZhNDZhZC1hY2Y3LTRhMTYtYWI2Yy1iMWZhNWE1YTgxZDMiLCJhY3IiOiIwIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiY29jaW5lcmEiLCJkb25jZWxsYSIsImNhbWFyZXJvIl19LCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiQW5nZWxhIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiYW5nZWxhIiwiZ2l2ZW5fbmFtZSI6IkFuZ2VsYSJ9.kkv2K-XYpHexnKmCoyNED_pO7G8hNI8hi2WCUzhpErkvrazNNZmUYZ8ZAjiybpi1u6ouc2EsHGykTNhUBD2jRhb2dWHYqcEEDaIn9MUq62B-nbTIcB-6vf1SrKnY_Vdnq_olmV_MhIJSQjPbDfcCVKKiUxHYmSBc9Vuno-enPehfUb_EpoRaM24SfJ0WDU281rTPxsgAJBdB4Yg0E9KMfCgaXkwRaHXMEGVpzHHqdi8S1lWwxs12Par-Qz4HqP-Tsw6KqNPU11dG3v6H_Q2fWmDsX5vvMqnmWkMQOFzco2fffsx7lcClPxNw3VghSVT-qB_7dMKUoT-DfyIo1Rcbqw
```

When parsed above becomes.

Header:

```json
{
  "alg": "RS256",
  "typ": "JWT",
  "kid": "Wz1nh3BX28Ps1TC3H4h9nvCUVEzcUPsBk8gSfxJxe-I"
}
```

Payload:

```json
{
  "exp": 1613854798,
  "iat": 1613853898,
  "auth_time": 1613853696,
  "jti": "12b5a31a-ab35-4103-a914-0f4e853388f5",
  "iss": "https://auth.localtest.me/auth/realms/hotel",
  "sub": "1a55e129-f9bb-4d60-bed1-0babb09bee3e",
  "typ": "Bearer",
  "azp": "react",
  "nonce": "884cb365-4c14-46aa-8e0c-eb3d7f0ca4f0",
  "session_state": "746a46ad-acf7-4a16-ab6c-b1fa5a5a81d3",
  "acr": "0",
  "allowed-origins": ["http://localhost:3000"],
  "realm_access": {
    "roles": ["cocinera", "doncella", "camarero"]
  },
  "scope": "openid email profile",
  "email_verified": false,
  "name": "Angela",
  "preferred_username": "angela",
  "given_name": "Angela"
}
```

Public key:

```
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyn1SYrKiXgJembEG1emG
lUw/NliK0tOTeKr8eBp7TZxI8D9k9FUkfzEeQyWekShPt3yTG9boZ9Sq/K7FAfs7
vXFG+kTKYYXysvfdkHHKJnPWEAJgqj3vDEpHB/Xqw5OtqOkSNPNYOxJ65ZmmZVNB
77NpGK5xW5s7xc7XXvLuILhfbOQXlObPbMnjVcnQSGHjmfbtTKsQ/im6ayxtShsL
FQgEJycplJU21WRy3T9cDHpGOMF3LehFIOmsxspcuC/idS0Nber3Fuw9QndSHZQL
KPTkDlyacPu9SyOJiMmD9S4QOZo9UVQWA8JlKa+KuL6TXyZ1OZdSkPSX1o1xeH7L
ewIDAQAB
-----END PUBLIC KEY-----
```

haproxy-auth-gateway will verify the above JWT correctly and will:

- set txn.authorized variable to true
- set txn.realm_roles variable to a comma separated list of `realm_access.roles`

Later above variables can be used in haproxy ACLs, for example:

```
http-request deny unless { var(txn.authorized) -m bool }
http-request deny if PATH_camarero ! { var(txn.realm_roles) -m sub camarero }
```

# Original project

haproxy-auth-gateway is based on great project from haproxytech folks: https://github.com/haproxytech/haproxy-lua-jwt

haproxy-auth-gateway contains changes to support Keycloak realm roles out of the box.
