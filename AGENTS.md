# Independent verification policy for Quando

## Authority and evidence
GitHub commits and workflow results are authoritative for source and CI, not assistant summaries. User approval is required for merges, scope expansion, costs, and destructive actions. Keep PR #8 closed; do not reuse its branch as a baseline.

Every development report must name the exact head SHA and classify claims as VERIFIED (direct evidence), FAILED (direct failure), or NOT VERIFIED (missing evidence). Never say that a test passed merely because test code exists. CI success does not prove physical-device behavior. Cite links to PRs, commits and workflow runs. If evidence is unavailable, explicitly say so.

## PR review checklist
- Compare the PR against the current main branch and check changed files for unrelated formatting or feature changes.
- Inspect security, persistence compatibility, scheduling, and offline alarm behavior when relevant.
- Confirm formatting, static analysis, tests and builds independently using actual CI results for the exact SHA.
- If a step is skipped, mark it NOT VERIFIED, not passed.
- Require targeted regression tests for behavioral changes and record what is not covered.
- Flag any unexpected permissions, writable workflow tokens, external network calls or generated-file churn.
- Do not merge or approve on behalf of the owner.

## Reviewer independence
The automated PR verification workflow is a deterministic guardrail, **not** an AI agent and not a proof of functionality. It independently checks PR diff metadata and highlights risk; a human or separate reviewer must examine semantics and test evidence. A passing verification workflow is necessary only where configured as a required status check; branch protection is managed separately in GitHub settings.
