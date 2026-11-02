# End Users

## 1. Overview

The product serves a private family relationship between a child and one
or more trusted parent or guardian accounts. The child is the primary
experience to design around. Parents and guardians manage the family
connection and participate in both directions of the request flow.

## 2. Primary end user: Child

### Role

The child uses the app primarily to initiate requests for time together
with a connected parent or guardian. The child can also receive and
respond to invitations from a parent.

### Needs

-   A simple interface with clear language.
-   Large, easy-to-understand activity choices.
-   A way to express an activity not listed.
-   Confidence that asking is welcome.
-   A kind, understandable response when the parent is busy.
-   No pressure, public exposure, or performance scoring.

### Design considerations

-   Use age-appropriate language and visual design.
-   Minimize typing and the number of steps.
-   Make the intended recipient clear before sending.
-   Avoid emotionally loaded labels such as "rejected."
-   Do not expose the child to unrelated adult account settings or
    administration.

## 3. Secondary end user: Parent or guardian

### Role

The parent receives child requests, responds to them, and can initiate
invitations to a child.

### Needs

-   A clear view of who sent a request and what they want to do.
-   A quick way to accept.
-   A considerate way to say "not right now" and suggest another time.
-   A simple way to invite a child to an activity.
-   Confidence that only approved family members can interact.

### Design considerations

-   Make incoming child requests prominent.
-   Keep response actions direct and unambiguous.
-   Do not make parents feel judged by response time or activity counts.
-   Provide appropriate account and family-connection management outside
    the core child flow.

## 4. Family relationship and account roles

The system should distinguish: - **Parent/guardian account:** An adult
account responsible for establishing and managing family connections. -
**Child profile/account:** A child-facing identity associated with an
approved parent or guardian. - **Family relationship:** An explicitly
established association that determines which users may exchange
requests.

The exact account model, including whether a child has independent
credentials or uses a parent-managed sign-in method, must be decided
during security and platform design. Do not assume that a standard adult
self-registration flow is appropriate for children.

## 5. MVP audience assumptions

The first release is intended for a child and parent/guardian who
already know one another and have an established family relationship. It
is not intended for strangers, public communities, school groups, or
general social networking.

Age bands and applicable child privacy obligations must be established
before public release. The interface should be tested with
representative families and age groups before finalizing reading level,
navigation, and account setup.
