# Design Decisions

## Default network rules should be Deny

Allowing by default means somebody might forget to disable.
This has happened before. Denying by default implies you have 
to open the access consciously — that's how it should be.

---

## Minimum TLS version is 1.2

TLS 1.0 and 1.1 are obsolete. There's no reason to support them.

---

## Versioning is disabled by default

This costs extra. And everybody doesn't need it. Enable 
versioning yourself when required — set versioning_enabled 
to true.

---

## Default replication for storage account is LRS

Works for most use cases. If you want zone redundancy — 
switch to ZRS. If regionality is essential — pick GRS.
But do not go overboard with replication until you need to.

---

## Default lifecycle policy uses modification time

Azure requires last access time tracking enabled manually 
in each storage account. Given we cannot ensure it's enabled,
we should stick with modification. Change this flag yourself
if you enable last access time tracking.

---

## SSE-C disabled on AWS

AWS is going to block it from April 2026. Instead of SSE-C
we will use AES256 encryption. Simpler and no key management.