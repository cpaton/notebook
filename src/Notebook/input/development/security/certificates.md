---
layout: page
title: Certificates
---

TLS certificates are x.509 which bind a name and public key together

Valid chain must be formed for a certificate to be trusted.  
Two types of certificate form the chain CA certificates and end entity certificate
There maybe more than one CA certificate in the chain.  Root CA and intermediate CA

x.509 v3 certificates have properties, constraints and extensions.  Extensions are named by Object Identifiers (OIDs) standardised by International Telecommunications Union (ITU).  Extensions are can be marked critical to denote they must be understood and processed for the certificate to be considered valid.  Commonly the intermediate CA will restrict the length of the validation chain to prevent other intermediate CAs being added to the chain e.g.

* RootCA no path length restriction
* Intermediate CA path length of 0 - denotes no more CAs allowed in chain
* End entity certificate - path length restriction not supported

Servers should send the full certificate chain during the TLS handshake.  Its possible intermediate certificates are not included in which case the CA Issuers URL can be used to locate those certificates - this is stored under the Authority Information Access

Its possible for multiple certificates with the same subject and public key to be created.  Each of those will have unique signatures as the issuing certificate will have different private keys.  But this allows multiple valid chains to exist for a single end entity certificate.  This supports more advanced scenarios like cross business trust relationships and rotating of intermediate CA certificates (https://en.m.wikipedia.org/wiki/X.509#Certificate_chains_and_cross-certification)

When forming a chain the certificate specifies an authority identitifier which should match the subject identifier on the issuing certificate.  Once you have the issuing certificate you can use its public key to verify the signature on the current certificate being validated.  This continues recusively until you reach the root CA certificate which is self signed and has to be explicitly trusted. 


## Resources 

* https://en.m.wikipedia.org/wiki/X.509