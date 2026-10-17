# GCP Enterprise Landing Zone — Terraform Lab

A hands-on Google Cloud Platform (GCP) Enterprise Landing Zone built with Terraform. This project explores foundational cloud governance, project separation, Shared VPC networking, security guardrails, and operational practices while preparing for the **Google Cloud Professional Cloud Architect (PCA)** certification.

> **Status:** Foundation and networking phases implemented. Security guardrails, workload validation, and observability are planned.

## Objectives

- Build a repeatable GCP landing zone using Terraform.
- Organize resources under a Google Cloud organization and dedicated folder.
- Separate network administration from workload deployment.
- Implement Shared VPC networking with custom subnets.
- Apply least-privilege IAM and organization policy controls.
- Validate infrastructure through real workload testing.
- Develop practical knowledge aligned with GCP PCA architecture scenarios.

## Architecture

```text
Google Cloud Organization
└── Landing Zone Folder
    ├── Network Host Project
    │   ├── Shared VPC: network-shared-vpc
    │   ├── Subnet: app-01
    │   └── Firewall rules
    └── Workload Service Project
        └── Application workload (planned)
```

The host project owns the Shared VPC network and subnet. The workload project is attached to the host project as a Shared VPC service project, allowing eligible workloads to use centrally managed networking.

The architecture separates networking from workloads without requiring every functional domain to have its own project.

## Current Configuration

| Component              | Configuration                                                             |
| ---------------------- | ------------------------------------------------------------------------- |
| Infrastructure as Code | Terraform                                                                 |
| Cloud provider         | Google Cloud                                                              |
| Network model          | Shared VPC                                                                |
| Network mode           | Custom-mode VPC                                                           |
| Routing mode           | Regional                                                                  |
| Region                 | `us-east1`                                                                |
| Subnet CIDR            | `10.60.0.0/20`                                                            |
| Private Google Access  | Enabled on the application subnet                                         |
| Firewall               | Ingress TCP 80/443 from the configured lab subnet to VMs tagged `alz-web` |
| State                  | Local Terraform state per root configuration                              |

The firewall rule is scoped to the configured source CIDR and matching VM network tags. It does not by itself expose an application to the public internet.

## Repository Structure

```text
.
├── bootstrap/
├── design/
│   └── architecture.md
├── docs/
├── environments/
│   ├── dev/
│   ├── foundation/
│   ├── networking/
│   └── prod/
└── modules/
    ├── folders/
    ├── iam/
    ├── org-policies/
    ├── projects/
    ├── shared-vpc/
    └── vpc-sc/
```

- `bootstrap/` — initial Terraform provider and configuration validation.
- `environments/foundation/` — landing zone folder and host/workload project configuration.
- `environments/networking/` — API activation, Shared VPC configuration, workload project attachment, and firewall rules.
- `modules/shared-vpc/` — reusable Terraform resources for the VPC and subnet.
- `design/` — architecture documentation.
- Other environment and module directories are reserved for future implementation; their presence does not mean those components are already deployed.

## Prerequisites

- A Google Cloud organization with appropriate permissions.
- Billing configured for the intended lab projects.
- Google Cloud CLI authenticated to the intended account.
- Terraform installed.
- The required Google Cloud APIs and IAM permissions.
- Access to the GitHub repository.

Use a dedicated lab environment and verify organization policies, billing, and permissions before applying changes.

## Working with Terraform

Run Terraform commands from the appropriate environment directory.

### Foundation

```bash
cd environments/foundation

terraform init
terraform fmt -check
terraform validate
terraform plan
```

Review the plan before applying any changes.

### Networking

```bash
cd environments/networking

terraform init
terraform fmt -check
terraform validate
terraform plan
```

Inspect the proposed changes carefully, especially any resource replacement or destruction. Apply only after explicitly reviewing and approving the plan.

> Each environment is a separate Terraform root configuration with its own state. Initialize and plan each root independently.

## Security and State Management

- Do not commit Terraform state files, state backups, saved plans, credentials, or live `.tfvars` files.
- Keep `.terraform.lock.hcl` tracked when present.
- Use `.tfvars.example` files for safe configuration examples.
- Review Terraform plans before applying changes.
- Prefer least-privilege IAM permissions.
- Avoid broad organization-level permissions unless required and justified.
- Treat local state and saved plans as potentially sensitive artifacts.
- Remember that `.gitignore` does not remove files already tracked in Git history.

## Implementation Roadmap

- [ ] Phase 1 — Foundation: folder and project configuration.
- [ ] Phase 2 — Networking: Shared VPC, subnet, and initial firewall configuration.
- [ ] Phase 3 — Security guardrails: IAM review and organization policy controls.
- [ ] Phase 4 — Workload deployment and network validation.
- [ ] Phase 5 — Logging, monitoring, and alerting.
- [ ] Phase 6 — Architecture review, testing, and safe cleanup.

The completed phases represent configuration and infrastructure work; end-to-end workload connectivity still needs to be tested.

## Learning Outcomes

This lab is intended to build practical understanding of:

- Resource hierarchy and organization policies.
- Shared VPC host and service projects.
- Terraform modules, dependencies, outputs, and state separation.
- Network CIDR planning and firewall target tags.
- Private Google Access and workload connectivity.
- Least-privilege IAM and infrastructure validation.
- Operational visibility, reliability, and cost awareness.

## Cost Awareness

This lab is designed to minimize unnecessary cloud spending. Resources such as VMs, load balancers, NAT gateways, and observability services may incur charges. Check current pricing and billing before deploying additional infrastructure, and clean up temporary resources when they are no longer required.

## Disclaimer

This is a personal learning lab and is not a production-ready enterprise landing zone. Production adoption requires additional design, security review, operational controls, and validation against organizational requirements.
