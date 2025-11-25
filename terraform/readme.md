# Confluent Private Cloud POC – Terraform

This project provisions a **private Confluent Cloud Kafka cluster** reachable only via **Azure private networking**, plus:

- 2 topics: `orders`, `payments`
- 1 service account
- 1 Kafka API key
- ACLs granting that identity **produce & consume** rights on both topics

The code is organised into:

- `azure/Modules` – Azure Resource Group + VNet, subnets, Private Endpoint, Private DNS zone
- `confluent/Modules` – Confluent Environment, PrivateLink Network, Kafka Cluster + Topics + IAM
- `Environments/{dev,qa,prod}` – per-environment composition and configuration

**Note:** I don't have Azure subscription or confluent cloud to test this out and assuming this should work fine by just updating the Azure Subscription id and Confluent API key and secret. But this is the structure I will design for provisioning terraform resources

## How to Run (dev example)

```bash
cd terraform/Environments/dev

1. Update terraform.tfvars with:
    - Confluent Cloud API key/secret
    - Azure subscription ID
    - (optional) custom names

2. Initialize
terraform init

3. Review plan
terraform plan

4. Apply (in your environment)
terraform apply

