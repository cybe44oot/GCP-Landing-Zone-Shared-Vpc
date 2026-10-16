# GCP Enterprise Landing Zone

## Objectives

- Build an enterprise-style Google Cloud landing zone.
- Use Terraform for infrastructure as code.
- Separate networking administration from workload administration.
- Apply least-privilege IAM and organization-level guardrails.
- Prepare a design for Shared VPC and VPC Service Controls.
- Avoid provisioning billable resources until costs are reviewed and
  explicit approval is given.

## Existing organization

- Organization ID: {ORG_ID}
- Organization display name: alhobab.site
- Existing validation project: alhobab-f6e0d
- Existing folder: TestEnvironment
- Primary region: me-central2

The existing project and folder are discovery targets. They must not be
modified or repurposed without a reviewed change.

## Proposed logical hierarchy

Organization
  Landing Zone
    Networking
      Shared VPC host project
    Workloads
      Workload service projects
    Security
      Security controls and supporting projects, if required
    Operations
      Centralized observability, if required

The hierarchy above is a proposed design, not deployed infrastructure.

## Network design principles

- Use a Shared VPC host project for centrally managed network resources.
- Attach workload service projects only when required.
- Separate network administration from workload administration.
- Select non-overlapping IP ranges after reviewing existing networks.
- Use explicit firewall rules and least-privilege access.
- Do not expose SSH or RDP broadly to the public internet.
- Keep private workloads private unless a documented requirement says
  otherwise.

## Security principles

- Preserve existing organization policies unless a reviewed change is
  approved.
- Prefer short-lived credentials and supported workload identity
  mechanisms over long-lived service-account keys.
- Review IAM inheritance and domain restrictions before granting access.
- Design VPC Service Controls only after identifying protected services,
  projects, access requirements, and required ingress/egress paths.

## Cost controls

- No VM, Cloud NAT, load balancer, paid storage, or other billable
  infrastructure should be provisioned without cost review and approval.
- A budget is an alerting mechanism, not a guaranteed spending cap.
- Review the Terraform plan before any apply operation.

## Terraform workflow

1. Discover current organization state.
2. Write and review configuration.
3. Run terraform fmt and terraform validate.
4. Run terraform plan.
5. Review the complete plan and dependencies.
6. Obtain approval before applying changes.
7. Verify the resulting cloud resources and record the outcome.
