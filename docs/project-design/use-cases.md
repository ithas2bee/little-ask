# Use Cases

## UC-01: Child sends a request to a parent

**Primary actor:** Child\
**Goal:** Ask a parent to spend time doing an activity.

### Preconditions

-   The child is signed in or otherwise securely identified.
-   At least one parent/guardian relationship has been established.
-   The selected parent is an approved recipient.

### Main flow

1.  Child opens the app.
2.  Child chooses the parent they want to spend time with.
3.  Child selects an activity or enters a short custom activity, if
    custom text is enabled for the MVP.
4.  App displays a clear review of the recipient and activity.
5.  Child sends the request.
6.  System records the request and makes it available to the parent.
7.  Parent receives a notification when notification permissions and
    delivery are available.
8.  Child sees a simple confirmation that the request was sent.

### Alternate flows

-   If the request cannot be sent, explain the problem in child-friendly
    language and allow retry.
-   If the parent is unavailable or notifications are disabled, preserve
    the request for the parent to see in the app.
-   If the child changes their mind before sending, allow them to go
    back without creating a request.

### Outcome

A pending request is associated with the child and selected parent.

## UC-02: Parent responds to a child request

**Primary actor:** Parent/guardian\
**Goal:** Accept a request or communicate that another time would work
better.

### Main flow

1.  Parent opens the request.
2.  Parent sees the child, requested activity, and request status.
3.  Parent chooses to accept.
4.  System updates the request status.
5.  Child receives an in-app update and, where available, a push
    notification.

### Alternate flow: Parent cannot do it now

1.  Parent chooses "Not right now" or equivalent wording.
2.  Parent is offered a simple way to suggest another time.
3.  Parent selects or enters a suggested time, or sends a kind response
    without a specific time if the product design allows it.
4.  System updates the request.
5.  Child receives the response in clear, reassuring language.

### Outcome

The child receives a clear response. The system does not label the child
or the request as rejected.

## UC-03: Parent sends an invitation to a child

**Primary actor:** Parent/guardian\
**Goal:** Invite a child to share an activity.

### Preconditions

-   Parent is connected to the child through an approved family
    relationship.

### Main flow

1.  Parent opens the parent invitation flow.
2.  Parent selects the child.
3.  Parent selects or enters an activity.
4.  Parent reviews and sends the invitation.
5.  System records the invitation and makes it available to the child.
6.  Child receives an in-app update and, where available, a push
    notification.

### Outcome

A pending parent-initiated invitation is associated with the parent and
child.

## UC-04: Child responds to a parent invitation

**Primary actor:** Child\
**Goal:** Accept an invitation or indicate that another time may work
better.

### Main flow

1.  Child opens the invitation.
2.  Child sees which parent sent it and what activity was suggested.
3.  Child chooses "Yes!" or an equivalent positive response.
4.  System updates the invitation status.
5.  Parent receives the response.

### Alternate flow

-   Child chooses "Maybe later."
-   The system communicates that response neutrally and lets the parent
    know.
-   Any rescheduling behavior should remain simple and must not pressure
    the child.

### Outcome

The parent receives the child's response.

## UC-05: User views request status

**Primary actors:** Child and parent/guardian\
**Goal:** Understand whether a request or invitation is pending or has
received a response.

### Main flow

1.  User opens the relevant request or invitation.
2.  App displays its current status and latest response.
3.  User can take only the actions permitted for that status.

### MVP boundary

A simple current/pending request view is sufficient. A historical
activity feed, analytics dashboard, or family memory timeline is not
required.
