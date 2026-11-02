# MVP Scope

## 1. MVP objective

Validate the central product behavior: children can initiate requests
for time together, parents can respond, and parents can also initiate
invitations that children can answer.

The MVP is successful when this two-way interaction works reliably and
feels natural to families.

## 2. Included in the MVP

### Child experience

-   A simple child home screen.
-   Choose a connected parent/guardian.
-   Choose an activity from a small predefined list.
-   Review and send a request.
-   View whether the request is pending or has received a response.
-   Receive and respond to parent invitations with simple choices.

### Parent experience

-   A simple parent home screen.
-   View incoming child requests.
-   Accept a child request.
-   Indicate "Not right now" and suggest another time.
-   Initiate an activity invitation to a connected child.
-   View the child's response.

### Shared system capabilities

-   Secure sign-in and approved parent-child association.
-   Request/invitation persistence.
-   Server-side authorization and request state validation.
-   Basic in-app request status updates.
-   Push notifications if the required platform setup is ready; the app
    must still show pending requests if push delivery is unavailable.
-   Basic error handling and operational logging.

## 3. Explicitly out of scope

Do not build these as part of the MVP: - Points, badges, streaks,
rewards, or leaderboards. - Family activity scores or time-spent
metrics. - Social feeds, public profiles, or public discovery. - Chat or
general-purpose messaging. - Photo/video sharing or memory albums. -
AI-generated activity recommendations. - Complex family calendars or
calendar synchronization. - Chore management, allowances, screen-time
controls, or parental monitoring. - Location tracking. - Complex
scheduling, recurring activities, or availability management. - Multiple
themes and extensive personalization. - Analytics dashboards for parents
or children.

## 4. MVP activity catalog

Start with a small set of familiar activities that can be represented
with a title and optional icon: - Play a game. - Play catch / throw a
ball. - Watch a movie. - Read together. - Go outside. - Get ice cream or
a treat. - Do a puzzle. - Draw or make something. - Something else, if
custom text is approved for MVP.

The catalog should be easy to change without rewriting request
workflows. Avoid building a recommendation engine.

## 5. MVP acceptance criteria

The MVP is not ready until: 1. A properly connected child can send a
request to the intended parent. 2. The parent can see the correct sender
and activity. 3. The parent can accept and the child sees the accepted
response. 4. The parent can say "Not right now" and suggest another
time. 5. The child receives that response in understandable, non-shaming
language. 6. A parent can send an invitation to a connected child. 7.
The child can accept or choose "Maybe later." 8. The parent sees the
child's response. 9. Unauthorized accounts cannot read or modify another
family's requests. 10. The core flows have automated tests and have been
manually tested on target devices. 11. Account setup, consent, privacy,
and child-safety requirements are addressed for the intended release
audience.

## 6. Suggested implementation order

1.  Confirm target ages and family/account model.
2.  Define domain concepts and request state transitions.
3.  Build and test the backend use cases and persistence.
4.  Build the child request flow using local/mock data.
5.  Connect the child flow to the API.
6.  Build the parent inbox and response flow.
7.  Build parent-initiated invitations and child responses.
8.  Add push notifications and verify failure/fallback behavior.
9.  Complete security, accessibility, and device testing.

This order is a guide. Keep each implementation story small and
demonstrably testable.
