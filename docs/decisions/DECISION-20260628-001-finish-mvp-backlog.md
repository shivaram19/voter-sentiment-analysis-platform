## DECISION-20260628-001: Finish the open MVP backlog by closing already-done issues and implementing the small gaps found in the audit

**Date:** 2026-06-28  
**Proposal:** Close the open GitHub issues (#1–#31, #36, #37) by: (1) closing issues whose acceptance criteria are already satisfied by the current codebase, (2) fixing the small, audit-identified gaps that keep the remaining issues open, and (3) adding the missing devops/testing artifacts (CI workflows, k6 load test, AWS deployment outline, field-test plan, docker-compose smoke tests).  
**Risk Level:** Medium  
**Final Decision:** Approved  

### Council Deliberation

| Persona | Stance | Key Point |
|---|---|---|
| Research Scientist | Endorse | The audit was based on direct source inspection; acceptance criteria are explicit issue bodies. |
| First-Principles Engineer | Endorse | Each fix addresses a concrete, observable gap; no speculative architecture. |
| Distributed Systems Architect | Concern | Refresh-token family invalidation and idempotent sync must be state-machine correct; need tests to prove it. |
| Infrastructure-First SRE | Concern | CI/CD and smoke tests are new; need rollback path and clear failure logs. |
| Diagnostic Problem-Solver | Endorse | Root causes are known (missing generated file, missing calls, wrong return types, POM errors). |
| Ethical Technologist | Endorse | Fixing auth rotation and data-loss sync directly protects surveyor data. |
| Resource Strategist | Concern | Some issues (#29 AWS, #30 load testing, #31 field testing) are broad; deliver minimal viable artifacts, not full production systems. |
| Curious Explorer | Endorse | Each change should be followed by a compile/build check to learn what else breaks. |
| Clarity-Driven Communicator | Endorse | Each issue will be closed with a commit reference and the decision will be logged. |
| Inner-Self Guided Builder | Endorse | Finishing the backlog serves the MVP goal of a working voter-sentiment platform. |

### Rationale
The Council approved because the audit revealed no fundamental design flaws—only implementation gaps and missing operational artifacts. The risk is contained by keeping changes minimal, compiling after backend changes, and documenting the remaining mobile build-step dependency on Flutter code generation.

### Dissent Recorded
- Distributed Systems Architect: wants explicit tests for token family revocation and idempotent sync (tracked in #36).
- Infrastructure-First SRE: wants CI/smoke-test failure logs and rollback notes (tracked in #28/#37).
- Resource Strategist: broad devops issues should be closed with minimal artifacts, not gold-plated solutions.

### Action Items
- [x] Decision log written
- [ ] Implement mobile build-blocker fixes (#11, #14, #19, #20)
- [ ] Implement backend auth correctness (#2) and Excel gaps (#5, #6)
- [ ] Implement devops/testing artifacts (#28, #29, #30, #31, #37)
- [ ] Add integration tests for auth rotation + batch sync (#36)
- [ ] Close verified issues with commit references
