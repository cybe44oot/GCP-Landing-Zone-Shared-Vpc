# GCP Enterprise Landing Zone Lab

## 1. Objectives

- Build an enterprise-style Google Cloud landing zone through practical implementation.
- Use Terraform for infrastructure as code and repeatable deployments.
- Separate network administration from workload administration.
- Apply least-privilege IAM and organization-level security guardrails.
- Implement and validate Shared VPC networking and firewall controls.
- Design and evaluate VPC Service Controls using dry-run mode before enforcement.
- Deploy a real workload using Compute Engine or Google Kubernetes Engine (GKE) to test the landing zone.
- Validate connectivity, security controls, IAM permissions, monitoring, and logging through practical exercises.
- Keep costs controlled and avoid unnecessary resources.
- Tear down temporary lab resources when testing is complete.

## 2. Existing Organization and Lab Environment

- Organization display name: `alhobab.site`
- Organization ID: `315824375507`
- Existing validation project: `alhobab-f6e0d`
- Existing folder: `TestEnvironment`
- Lab folder: `landing-zone-lab`
- Lab folder ID: `472230761734`
- Billing account: `01F57E-4AA2F9-FD30F7`

The existing validation project and `TestEnvironment` folder are discovery targets. They must not be modified or repurposed without a reviewed change.

### Current lab projects

**Shared VPC host project**
- Project ID: `alhobab-alz-lab-host-2026`
- Project number: `903154668241`
- Responsibility: centrally managed VPC networking, subnets, and firewall rules.

**Workload service project**
- Project ID: `alhobab-alz-lab-workload-2026`
- Project number: `804133814580`
- Responsibility: hosting the test workload and validating network and security controls.

### Primary lab region

- Region: `us-east1`

Subnet creation in `me-central2` was denied even though the effective `gcp.resourceLocations` policy allowed all locations. The lab therefore switched to `us-east1`.

The regional access issue should remain documented rather than being treated as a confirmed organization-policy restriction.

## 3. Proposed Logical Hierarchy

The following is the target design, not a claim that every folder or project has already been created.

Organization: alhobab.site
└── Landing Zone (proposed)
    ├── Networking
    │   └── Shared VPC host project
    ├── Workloads
    │   └── Workload service projects
    ├── Security
    │   └── Security controls and supporting projects (if required)
    └── Operations
        └── Centralized observability (if required)

The current lab uses the `landing-zone-lab` folder and two projects. Additional folders and projects should be introduced when they serve a specific learning objective or operational requirement.

## 4. Current Implementation Status

### Implemented

- Lab folder and host/workload projects created.
- Compute Engine APIs enabled in both projects.
- Custom-mode Shared VPC network created: `alz-shared-vpc`.
- Shared VPC host project enabled.
- Workload service project attached to the host project.
- Application subnet created in `us-east1`:
  - Name: `alz-us-east1-app-01`
  - CIDR: `10.60.0.0/20`
  - Private Google Access enabled.
- Initial firewall rule configured:
  - Name: `alz-allow-web-from-lab-subnet`
  - Direction: ingress
  - Source range: `10.60.0.0/20`
  - Allowed protocols/ports: TCP 80 and 443
  - Target network tag: `alz-web`

### Not yet validated through a real workload

- Actual network connectivity and firewall behavior.
- Positive and negative traffic tests.
- Workload-level IAM and security controls.
- Monitoring and logging from a deployed test workload.

Creating a resource or firewall rule does not prove that traffic will successfully flow or be denied as intended.

## 5. Network Design Principles

- Use Shared VPC to centralize network administration.
- Keep workload deployment and application administration separate from network administration.
- Attach service projects only when required.
- Select non-overlapping IP ranges after reviewing existing networks, VPNs, and peering connections.
- Use explicit firewall rules with narrow sources, ports, and targets.
- Avoid broad public SSH or RDP access.
- Keep private workloads private unless a documented requirement says otherwise.
- Validate effective firewall behavior instead of assuming that one rule determines all traffic.
- Document ingress and egress requirements before introducing additional rules.
- Use network tags or service-account targeting where appropriate, understanding the limitations of each approach.

## 6. Security Principles

- Preserve existing organization policies unless a reviewed change is approved.
- Inspect effective organization policies and inherited IAM bindings before making changes.
- Apply least-privilege access at the narrowest appropriate scope.
- Prefer short-lived credentials and supported workload identity mechanisms over long-lived service-account keys.
- Review domain restrictions and service-account permissions before granting access.
- Design VPC Service Controls only after identifying protected services, projects, access requirements, and required ingress/egress paths.
- Start VPC Service Controls in dry-run mode where supported, review violations, and only consider enforcement after testing.
- Keep organization-wide policy changes separate from lab-specific configuration.

## 7. Mandatory Workload and Validation Phase

A real workload must be deployed to prove that the landing zone works. This phase is required, not optional.

### Workload deployment

Choose one initial approach:

- **Option A — Compute Engine VM:** use a small, temporary VM in the workload project to validate Shared VPC connectivity and firewall behavior.
- **Option B — Google Kubernetes Engine:** deploy a small GKE cluster and test workload networking, service exposure, and applicable firewall controls.

Review expected costs and obtain explicit approval before provisioning billable resources. Choose the simplest option that satisfies the learning objectives.

### Required validation exercises

1. Confirm that the workload uses the intended Shared VPC network and subnet.
2. Verify internal connectivity between the workload and an appropriate test endpoint.
3. Test traffic that should be allowed by the firewall rule.
4. Test traffic that should not be allowed by that rule.
5. Distinguish the effect of the configured rule from the complete effective firewall policy.
6. Verify that administrative access is not unnecessarily exposed to the public internet.
7. Confirm that workload identities and IAM permissions follow least privilege.
8. Review relevant audit logs and workload/network observability data.
9. Record test commands, expected results, actual results, and any corrective actions.

Tests must use a controlled endpoint and appropriate source identities. A denied connection should be attributed to the correct control rather than assumed to prove a particular firewall rule is responsible.

## 8. Security Guardrails Phase

After the networking foundation is validated:

- Inspect and document inherited organization policies.
- Review organization, folder, and project IAM bindings.
- Implement suitable lab-level guardrails without weakening existing organization controls.
- Validate allowed and denied administrative operations where practical.
- Review audit logging and relevant security events.
- Design VPC Service Controls for selected supported services.
- Evaluate VPC Service Controls in dry-run mode and document violations before considering enforcement.

## 9. Observability Phase

Implement enough monitoring and logging to observe the deployed workload and validate operational behavior.

- Collect appropriate workload metrics.
- Configure relevant logs and audit-log visibility.
- Create useful dashboards and basic alerts.
- Generate test traffic and verify that telemetry reflects the workload's behavior.
- Document what each metric, log, or alert proves and its limitations.

The observability implementation should match the chosen workload approach and avoid unnecessary paid infrastructure.

## 10. Cost Controls and Teardown

- No VM, GKE cluster, Cloud NAT, load balancer, paid storage, or other potentially billable infrastructure may be provisioned without cost review and explicit approval.
- Prefer minimal, temporary resources that satisfy the test objectives.
- Review pricing, expected runtime, regional costs, and cleanup requirements before deployment.
- Remember that a budget is an alerting mechanism, not a guaranteed spending cap.
- Review Terraform plans before every apply operation.
- Track resources created manually as well as those managed by Terraform.
- At the end of the lab, remove temporary workloads and supporting resources in dependency order.
- Verify that billable resources have been deleted and review billing for residual charges.
- Preserve any state, documentation, or artifacts required for future exercises.

## 11. Terraform Workflow

1. Discover existing organization, folder, project, IAM, policy, and network state.
2. Confirm resource ownership and identify changes that could affect existing infrastructure.
3. Write Terraform configuration using variables and reusable modules where appropriate.
4. Run `terraform fmt`.
5. Run `terraform validate`.
6. Run `terraform plan` and review the complete plan and dependencies.
7. Review cost implications and obtain explicit approval before applying changes.
8. Apply the reviewed configuration.
9. Verify the resulting resources through Terraform outputs and Google Cloud APIs or Console.
10. Run practical tests against the deployed workload.
11. Document results, failures, fixes, and remaining limitations.
12. Check for configuration drift and reconcile manual changes with Terraform state.
13. Tear down temporary resources safely and verify cleanup.

Terraform state must be protected and managed consistently. Resources created manually should be imported into state when Terraform is intended to manage them.

## 12. Completion Criteria

The lab is complete only when:

- The intended landing-zone hierarchy and network architecture are documented.
- Shared VPC networking and workload attachment are verified.
- Firewall configuration is reviewed and tested against a real workload.
- Expected allowed and denied traffic behavior is demonstrated.
- IAM and organization guardrails are reviewed and validated.
- VPC Service Controls are evaluated in dry-run mode if included in the selected scope.
- Monitoring and logging are demonstrated with workload-generated activity.
- Results and limitations are documented.
- Temporary billable resources are removed and cleanup is verified.

The objective is not merely to create Google Cloud resources. It is to demonstrate, through repeatable implementation and practical tests, that the landing zone is secure, functional, observable, and cost-controlled.