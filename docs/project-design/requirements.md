# Product and System Requirements

## 1. Functional requirements

### Family connection

-   **FR-001:** The system shall support an approved relationship
    between a parent/guardian and a child.
-   **FR-002:** A user shall only be able to send requests or
    invitations to an approved family connection.
-   **FR-003:** The MVP shall support the intended parent-child
    relationship model without public user discovery.

### Child-initiated requests

-   **FR-010:** A child shall be able to select an approved
    parent/guardian.
-   **FR-011:** A child shall be able to choose an activity from a small
    curated list.
-   **FR-012:** The system may support a short custom activity
    description if safety and moderation requirements are addressed.
-   **FR-013:** A child shall be able to review the recipient and
    activity before sending.
-   **FR-014:** The system shall create a pending request and associate
    it with its sender and recipient.
-   **FR-015:** The child shall receive clear confirmation that the
    request was sent.

### Parent responses

-   **FR-020:** A parent shall be able to view requests sent by
    connected children.
-   **FR-021:** A parent shall be able to accept a request.
-   **FR-022:** A parent shall be able to indicate that they cannot do
    the activity now.
-   **FR-023:** A parent shall be able to suggest another time when
    responding that they cannot do it now.
-   **FR-024:** The system shall communicate the parent's response to
    the child.

### Parent-initiated invitations

-   **FR-030:** A parent shall be able to select a connected child.
-   **FR-031:** A parent shall be able to select or enter an activity
    and send an invitation.
-   **FR-032:** The child shall be able to view the parent invitation.
-   **FR-033:** The child shall be able to accept or indicate "Maybe
    later."
-   **FR-034:** The system shall communicate the child's response to the
    parent.

### Request lifecycle

-   **FR-040:** Each request or invitation shall have a defined status.
-   **FR-041:** The system shall prevent unauthorized users from viewing
    or changing a request.
-   **FR-042:** The system shall validate state transitions on the
    server, not rely only on mobile UI behavior.
-   **FR-043:** The system shall retain enough information to display
    the current status and response.

## 2. Initial request statuses

Use a small, explicit lifecycle. The final state model should be
validated before implementation.

-   `Pending`: Waiting for the recipient.
-   `Accepted`: Recipient accepted.
-   `LaterSuggested`: Recipient cannot do it now and has suggested
    another time.
-   `MaybeLater`: Recipient is interested but not now, without a
    committed time.
-   `Cancelled`: Sender cancelled, if cancellation is included in the
    MVP.

Do not use `Rejected` as child-facing language. Internal technical
status names should also be chosen carefully to avoid confusing business
semantics.

## 3. Non-functional requirements

-   **NFR-001 Maintainability:** Organize code by feature and
    architectural responsibility. Avoid oversized classes, files, and
    methods.
-   **NFR-002 Testability:** Business rules and use cases shall be
    testable without rendering Flutter screens or requiring a live
    database.
-   **NFR-003 Security:** Enforce authentication, authorization, and
    family relationship checks on the backend.
-   **NFR-004 Privacy:** Keep family requests private to authorized
    family members.
-   **NFR-005 Reliability:** Persist a request before reporting that it
    was successfully sent.
-   **NFR-006 Usability:** Core request flows should be short, clear,
    and usable by the intended child age range.
-   **NFR-007 Accessibility:** Support readable text, adequate contrast,
    screen readers, and appropriately sized touch targets.
-   **NFR-008 Responsiveness:** The app should provide clear loading,
    success, empty, offline, and error states.
-   **NFR-009 Data minimization:** Collect only information necessary to
    operate the family relationship and request workflows.
-   **NFR-010 Observability:** Record operational errors without logging
    sensitive request content unnecessarily.

## 4. Child safety and privacy requirements

These are release gates, not optional polish: - Establish an age policy
and determine applicable child privacy requirements before launch. - Use
a parent/guardian-mediated family setup and verification model
appropriate to the intended audience. - Prevent arbitrary adults from
contacting children through search or discovery. - Restrict request
visibility and notification content to authorized recipients. - Avoid
behavioral advertising and unnecessary third-party tracking. - Review
push notification previews so sensitive content is not exposed on a
locked device. - Define account deletion, data retention, consent, and
support processes before public release. - Obtain qualified
legal/privacy review for applicable laws and app-store policies,
including COPPA where relevant.

## 5. Product language requirements

Prefer warm, clear language: - "Send request" - "Let's do it!" - "Not
right now" - "Maybe later" - "How about tomorrow?"

Avoid: - "Rejected" - "Failed" - "Request denied" - Guilt-inducing
reminders or language that implies a parent or child owes time.

## 6. Open decisions

-   Target child age range.
-   Whether custom activity text is in the first MVP.
-   Whether a parent may suggest a precise time or only a broad option
    such as later today/tomorrow.
-   Child account authentication and device setup.
-   Family invitation and verification process.
-   Push notification provider and delivery behavior.
-   Whether multiple guardians and multiple children are supported in
    the first release.
