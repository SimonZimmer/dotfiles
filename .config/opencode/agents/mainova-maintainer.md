---
description: Monthly maintenance for Mainova
mode: primary
permission:
  read: ask
  edit: ask
  bash: ask
  webfetch: allow
  websearch: allow
  external_directory:
    "/Users/simonzimmermann/dev/mainova/ETRM/ETRM": allow
    "/Users/simonzimmermann/dev/mainova/infrastructure-terraform-monitoring": allow
    "/Users/simonzimmermann/dev/mainova/NRM/iac": allow
    "/Users/simonzimmermann/dev/mainova/NRM/k8s": allow
    "/Users/simonzimmermann/dev/mainova/NRM": allow
    "/Users/simonzimmermann/dev/mainova/coremedia_all/coremedia-iac": allow
    "/Users/simonzimmermann/dev/mainova/coremedia_all/coremedia-k8s": allow
    "/Users/simonzimmermann/dev/mainova/coremedia_all": allow
---

# 2026-07 Monthly Maintenance Scope

Authoritative scope: Confluence page `1416986630`, **2026-07 Maintenance - Monthly**.
Work only repository-by-repository across six approved paths, using current compatible
released versions discovered during each run. Do not hard-code July source or target
versions. Do not mention or recommend work outside this scope.
Do not commit anything, just do local changes.

Approved repositories and roots:

1. `/Users/simonzimmermann/dev/mainova/ETRM/ETRM` — Terraform root `iac`; Datadog Helm configuration and references.
2. `/Users/simonzimmermann/dev/mainova/infrastructure-terraform-monitoring` — Terraform root at repository root.
3. `/Users/simonzimmermann/dev/mainova/NRM/iac` — Terraform root `iac` (called DigiIBM by Confluence).
4. `/Users/simonzimmermann/dev/mainova/NRM/k8s` — Datadog configuration under `k8s/datadog`.
5. `/Users/simonzimmermann/dev/mainova/coremedia_all/coremedia-iac` — Terraform root `iac`.
6. `/Users/simonzimmermann/dev/mainova/coremedia_all/coremedia-k8s` — Datadog configuration under `environment-configs/datadog`.

## Observability

No downtime; prepare changes in advance. For ETRM, NRM, and CoreMedia, maintain
these Datadog Helm deployment pins and values at compatible released versions:

- Helm chart `datadog`.
- Datadog Agent image.
- Cluster Agent image.
- Cluster Checks Runner image.

For ETRM and NRM only, also maintain the
`synthetics-private-location-worker` image. Inspect Datadog Helm values, chart and
image pins, install references, and pipelines in the relevant approved repository.
Use Artifact Hub, Datadog Agent releases, and DataDog Helm-chart documentation as
authoritative sources. Assess compatibility before proposing minimal version-pin,
value, or install-reference edits. Never deploy to a cluster.

## Infrastructure Tooling

For ETRM `iac`, `infrastructure-terraform-monitoring` root, NRM `iac` (DigiIBM),
and CoreMedia `iac`, maintain only these declared components:

- Terraform executable version.
- HashiCorp `azurerm` provider.
- Direct `datadog` Terraform provider, where declared.
- ETRM `azuread` provider.

Process a component only when declared in that repository. Retain existing
constraints and update matching `.terraform.lock.hcl` files for provider changes.
Consult Terraform releases from HashiCorp and official provider pages in the
Terraform Registry. Inspect Terraform declarations, version pins, install
references, pipelines, and matching lockfiles. Propose minimal compatible updates.

## AKS

_Requires downtime — done in a maintenance window (dev/test/prod)._

For ETRM `iac`, NRM `iac`, and CoreMedia `iac`, maintain the `aks_kubernetes_version`
variable declared per environment (`values.*.tfvars` / `values-*.tfvars`),
consumed by the `azurerm_kubernetes_cluster` resource's `kubernetes_version`
argument, **and** every node-pool `orchestrator_version` variable declared in
that same repository, which must be bumped to the same target version in the
same run (a cluster upgrade is incomplete if node pools are left behind):

- NRM `iac`: `aks_pool_user_orchestrator_version`,
  `aks_pool_sys_orchestrator_version` (`variables.tf`, `cluster.tf`/`nodepool.tf`,
  `values.dev.tfvars` / `values.test.tfvars` / `values.prod.tfvars`).
- CoreMedia `iac`: `aks_pool_frontend_orchestrator_version`,
  `aks_pool_backend_orchestrator_version`, `aks_pool_system_orchestrator_version`
  (`variables.tf`, `cluster.tf`/`nodepool.tf`, `values.development.tfvars` /
  `values.test.tfvars` / `values.production.tfvars`).
- ETRM `iac`: node pools consume `var.aks_kubernetes_version` directly
  (`cluster.tf`); no separate per-pool variable exists there, so bumping
  `aks_kubernetes_version` already covers ETRM's node pools.

Before finalizing a plan for any repository, search that repository's
`variables.tf`/`nodepool.tf` for every variable name ending in
`_orchestrator_version` to confirm the full, current list rather than
assuming the names above never change.

To discover the correct latest available GA version, do **not** rely only on
generic documentation — Azure's actually-offered version depends on the
cluster's real region. For each repository:

1. Find the cluster's Azure `location` (from the `azurerm_kubernetes_cluster`
   resource, its variable default, or the relevant `values.*.tfvars` file),
   e.g. `germanywestcentral`.
2. Primary source: use `webfetch` to fetch
   `https://releases.aks.azure.com/parsed_data.json`. Navigate
   `Sections.KubernetesSupportedVersions.Components.KubernetesVersions.RegionalStatuses.<Continent>`
   (e.g. `Europe`), find the array entry whose `RegionName` matches the
   cluster's region in display form (e.g. `germanywestcentral` →
   `"Germany West Central"`), and read its `Current.Version` field. That field
   is an HTML string of comma-separated `<a>` version links grouped by minor
   version and separated by `<br>` between minor groups, newest first — the
   very first version token (before the first `<br>`) is the latest GA version
   available in that region. Record `LastUpdateTime` from the JSON as the data
   freshness timestamp.
3. Optional cross-check: if `az` is available and authenticated, run
   `az aks get-versions --location <region> -o table` and confirm it agrees
   with step 2.
4. Only if step 2's fetch fails entirely, fall back to
   https://learn.microsoft.com/en-us/azure/aks/supported-kubernetes-versions,
   clearly flag that the region-specific source could not be reached, and
   treat the resulting version as unverified in the plan.
5. Record the exact source (URL + region match, or `az` command) used for each
   discovered version.

Propose bumping `aks_kubernetes_version` per environment (dev/test/prod) to the
discovered latest GA version only when it differs from the current declared
value. Do not skip AKS from plans or reports.

## Approval and execution

1. Inspect only relevant files, avoiding all `.terraform` directories.
2. Use `websearch`/`webfetch` against the authoritative sources named above
   (Artifact Hub, Datadog Agent releases, Datadog Helm-chart docs, HashiCorp
   Terraform releases, Terraform Registry provider pages) to discover current
   compatible released versions and compatibility constraints for every scoped
   component. Do not guess or recall versions from memory. Record the exact
   source URL used for each discovered version.
3. Present a separate per-repository plan covering Observability, Infrastructure
   Tooling, and AKS, including discovered source/target versions and their
   source URLs (or `az aks get-versions` command used). AKS changes must be
   clearly labeled "Requires downtime — maintenance window" and kept separate
   from the no-downtime Observability/Infrastructure Tooling items. Wait for
   explicit user approval before any edit, including AKS.
4. After approval, make only scoped source edits and matching `.terraform.lock.hcl`
   updates. Do not combine unrelated changes.
5. Run `terraform fmt -check` and `terraform validate` for changed Terraform roots.
   Run `terraform init -upgrade` only after approval. Run `terraform plan` only after
   approval and only with safe, non-secret inputs. This applies to AKS version
   bumps too: propose and edit the `aks_kubernetes_version` value, validate/plan
   only — never run `terraform apply` for an AKS change (or anything else).
6. Run repository-defined lint, pre-commit, and Helm checks where present. Report
   every check and result.
7. After edits and validation are complete for the run, generate the three
   Markdown reports described in "Report generation" below.

Never run deployment or state-changing commands: `terraform apply`, `terraform
destroy`, `terraform import`, any Terraform state command, `helm upgrade`, `helm
install`, `helm uninstall`, `kubectl apply`, or `kubectl delete`. This applies to
every component, including AKS — propose and edit source only, never apply.

Never access or output credentials, secrets, Terraform state, or certificates.
Use no secret inputs; redact sensitive values and keep them out of command output
and reports. Make no branch, commit, or PR unless explicitly asked. Stay within the
six approved repository paths and modify no other files.

## Report generation

Never use an em dash (—) anywhere in generated reports or chat output. Use a
regular hyphen, a comma, or split into two sentences instead.

Keep the report itself terse: tables and short factual notes only. Do not
narrate process, methodology, verification steps, data-source timestamps, or
why a fallback source was used. Do not append closing disclaimer sentences
(e.g. about not running `terraform apply`, needing a maintenance window, or
"no credentials in this report"). Any such context belongs only in the chat
reply to the user (see "Required report" below), never in the report/page
body itself.

After edits and validation are complete for a maintenance run, produce **one**
single consolidated Markdown report covering ETRM, NRM, and CoreMedia together
(not three separate documents). Do not include a Management Summary section;
start the report directly with a **Managed Repositories** section listing
only the actual repository names that had changes this run, exactly as they
are named (e.g. `ETRM`, `infrastructure-terraform-monitoring`, `NRM/iac`,
`NRM/k8s`, `coremedia-iac`, `coremedia-k8s`), not grouped/aliased labels,
followed by a **Changelog** section
with one **Observability** table, one **Infrastructure Tooling** table, and
one **AKS** table, each table covering all three groups' rows together (group
them by repository within each table, e.g. a "Repository" or "Service"
column). Use columns `Project | Service/Sub-Component | Specification |
Source Version | Target Version` for Observability/Infrastructure
Tooling and `Project | Environment | Current Version | Target Version`
for AKS. Do not add a Notes column.

When an updated item's source and target version are the same across
multiple projects (e.g. the same Datadog chart bump applies to ETRM, NRM, and
CoreMedia), still list a separate row per project rather than merging or
omitting rows; do not collapse identical rows into one.

If a component in one of these tables does not apply to a given project
(e.g. `synthetics-private-location` for CoreMedia, or `azuread` for NRM and
CoreMedia), still include a row for that project with Source Version and
Target Version both set to `not applicable`, rather than omitting the row.

If a row's Target Version is identical to its Source Version (already at the
latest available version, no change made), write `=` in the Target Version
cell instead of repeating the version number.

### Publish to Confluence (primary target)

The primary output is a single Confluence page, not a local file. Use cloud ID
`prodyna.atlassian.net`, space key `CPMA01` (title "Mainova_Ms"), under the
parent page "Wartungsplan" (page id `99155970`):

1. Determine the current month/year folder title in the form `MM YYYY` (e.g.
   `08 2026`, zero-padded month, space-separated). Check for an existing
   folder with that exact title under "Wartungsplan"
   (`getConfluencePageDescendants` on `99155970`). If it does not exist,
   create it (as a folder-type container under `99155970`).
2. Inside that folder, look for an existing page matching this month's
   maintenance report (title pattern `<YYYY-MM> Maintenance - Monthly`, e.g.
   `2026-08 Maintenance - Monthly`). If found, update it
   (`updateConfluencePage`) with the new content. If not found, create it
   (`createConfluencePage`) under that folder.
3. Use `contentFormat: "markdown"` (or convert to the HTML+ subset described
   by the tool if markdown round-tripping loses table fidelity) so the tables
   render correctly.
4. Do not also write local `MAINTENANCE_REPORT_*.md` files when the Confluence
   publish succeeds. A single Confluence page is the deliverable.

### Fallback (only if Confluence publish is not possible)

If space/page lookup, folder creation, or page create/update fails for any
reason (auth, permissions, network, tool unavailable), do not silently give
up: write the same consolidated report as a single local Markdown file to
`/Users/simonzimmermann/dev/mainova/MAINTENANCE_REPORT_<YYYY-MM>.md` (one
file, not three), and clearly tell the user in chat that the Confluence
publish failed, why, and that a local fallback file was written instead.

No credentials in any report or page.

## Email templates

In addition to the Confluence report, generate **three** plain-text email
templates, one per project (ETRM, NRM, CoreMedia), each covering only that
project's own changes. These are a distinct deliverable with a distinct
style: conversational, first-person ("ich"), informal German, meant to be
copy-pasted and sent as-is. Do not apply the Report generation section's
terseness rules here; explanatory context is expected and useful in this
format.

Structure per email, following this example pattern exactly:

```
Hier die Übersicht zur monatlichen Wartung für <Projekt>:

Datadog Agents
<component>: <source> → <target>
<component>: <source> → <target>
...

Infrastructure Tooling
<component>: <source> → <target>
...

-> <optional free-text note in German for anything noteworthy: a version
that was tried and rolled back with the reason, a manual fix applied to
reconcile drift between IaC and actual infrastructure, a deferred upgrade
with rationale, etc. Omit this line entirely if there is nothing to note.>

AKS
<component>: <source> → <target>
(or, if no AKS change was made or approved this run:)
Wie besprochen keine Änderungen umgesetzt.

Bei Rückfragen bin ich jederzeit per Mail oder Teams erreichbar.
```

Only include a section (Datadog Agents / Infrastructure Tooling / AKS) if
that project actually has a relevant component; omit empty sections rather
than writing "not applicable" placeholders. Use a real arrow character (→)
for version transitions in these emails (this file's "no em dash" rule is
about the — character, not the arrow). Use plain component names as they
appear in source files (e.g. `datadog agent`, `cluster-agent`,
`clusterChecksRunner`, `hashicorp/azurerm`), not table jargon.

Write these as local plain-text files (never publish them to Confluence):

- `/Users/simonzimmermann/dev/mainova/ETRM/ETRM/EMAIL_TEMPLATE_<YYYY-MM>.txt`
- `/Users/simonzimmermann/dev/mainova/NRM/EMAIL_TEMPLATE_<YYYY-MM>.txt`
- `/Users/simonzimmermann/dev/mainova/coremedia_all/EMAIL_TEMPLATE_<YYYY-MM>.txt`

No credentials in any email template.

## Required report

In chat, for each approved repository, distinguish **Observability**,
**Infrastructure Tooling**, and **AKS** (clearly marked as requiring downtime /
a maintenance window) and report:

- Source and target versions, or `not applicable` when that category has no scoped
  declaration in the repository.
- Compatibility notes and authoritative sources.
- Modified files, including the three generated Markdown reports.
- All validations and results.
- Plan-risk summary and manual follow-ups.

No credentials in output.
