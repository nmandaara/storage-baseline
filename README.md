# Storage Baseline

Last year we went through a security review and found the same issues across almost every storage account 
- public access enabled, 
- no encryption enforced, and 
- data sitting in Hot tier for years because lifecycle rules were never set up at creation time.

The fix was not complicated. The problem was just that there was no standard starting point. Every team provisioned storage their own way and the basics kept getting missed.

This is a Terraform module for Azure and AWS that encodes those basics — security hardening and lifecycle tiering out of the box, so every storage account starts from the same baseline.

---

## What it does

Every storage account provisioned with this module gets:
- Public access blocked by default
- Encryption enforced (in transit and at rest)
- Lifecycle rules configured - Hot for 30 days, Cool for 60 days, Archive after that. 

---

## Cloud mapping

| | Azure | AWS |
|---|---|---|
| Storage | Blob Storage | S3 |
| Encryption at rest | Storage Service Encryption | SSE-S3 / SSE-KMS |
| Encryption in transit | HTTPS / TLS enforced | HTTPS / TLS enforced |
| Public access | Disabled by default | Block Public Access enabled |
| Tiers | Hot / Cool / Archive | Standard / IA / Glacier |
| IaC | Terraform azurerm provider | Terraform aws provider |

---

## Usage
### Azure

```hcl
module "storage_baseline" {
    source = "./azure/modules/storage"

    resource_group_name = "my-rg"
    location            = "eastus"
    name                = "mystorageaccount"
    tags = {
        environment = "prod"
        owner       = "team-a"
    }
} 
```

### AWS

```hcl
module "storage_baseline" {
    source = "./aws/modules/storage"

    bucket_name = "my-storage-bucket"
    tags = {
        environment = "prod"
        owner       = "team-a"
    }
}
```
---

## Defaults

Module will apply the following defaults. Everything can be overriden using variables if needed. 

| Setting | Default | Reason |
| --- | --- | --- |
| Public Access | Blocked | To prevent accidental data exposure |
| Encryption at Rest | Enabled |  Protects stored data from unauthorized access |
| Encryption in Transit | Enforced |  Ensures data is protected during transfer |
| Hot tier duration | 30 days | Frequently accessed data |
| Cool tier duration | 60 days | Infrequently accessed data |
| Archive tier duration | After 90 days | Rarely accessed data, long-term storage |

---

## Considerations

We can enable logging and versioning but that incurs some costs, if we are okay with it, we can enable it. 

Few important things worth knowing before you apply this module:

- Once data moves to Archive, getting it back takes hours not minutes or seconds. 
- Do not archive anything you might need quickly. 
- Azure charges a minimum of 180 days even if you delete the data earlier. AWS Glacier has a 90 day minimum. Plan your tiering rules accordingly. 
- Review costs every few months

---

## Resources

- [Azure Blob Storage tiers](https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview)
- [Azure Lifecycle Management](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview)
- [Azure Terraform provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AWS S3 Storage classes](https://aws.amazon.com/s3/storage-classes/)
- [AWS S3 Lifecycle rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html)
- [AWS Terraform provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---

## Progress

Instead of my usual habit of pushing everything at once, I am 
trying to hold myself accountable and push this in batches.

- [x] Checkpoint 1 — Repo scaffold & README
- [x] Checkpoint 2 — Azure Terraform module
- [x] Checkpoint 3 — AWS Terraform module
- [x] Checkpoint 4 — Examples & documentation

---

_Built by Nikhil_

