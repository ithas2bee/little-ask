# Design Structure

## 1. Design direction

The visual direction is modern, friendly, colorful, and calm. The app
should feel welcoming to children without looking overly childish to
parents. Use the approved concept-board direction as the initial visual
reference: soft colors, rounded surfaces, clear icons, generous spacing,
and simple request cards.

The visual design must support the product principle: make it easy and
comfortable for a child to ask for time together.

## 2. Role-aware experience

The app has two related experiences:

-   **Child experience:** Optimized for initiating requests and
    responding to parent invitations.
-   **Parent experience:** Optimized for receiving child requests,
    responding thoughtfully, and initiating invitations.

These are not separate products. They are role-aware views of the same
family connection and request system.

## 3. Child screen structure

### Child home

Primary question: "Who do you want to spend time with?"

-   Show approved parent/guardian choices.
-   Keep the choices visually obvious.
-   Avoid administrative settings on the primary screen.

### Activity selection

Primary question: "What would you like to do?"

-   Show a small set of recognizable activity choices.
-   Use concise labels and supportive icons.
-   Include a simple custom option only if included in the MVP scope.

### Review and send

-   Show the selected parent and activity.
-   Provide one clear send action.
-   Prevent accidental duplicate submission while the request is
    processing.

### Request response

-   Show the parent's response in friendly language.
-   If another time is suggested, make that suggestion easy to
    understand.
-   Do not present a delay as rejection.

### Parent invitation

-   Show who is inviting the child and the proposed activity.
-   Offer simple response actions such as "Yes!" and "Maybe later."

## 4. Parent screen structure

### Parent home / requests

-   Prioritize incoming child requests.
-   Clearly identify the child and requested activity.
-   Show pending status and response actions.

### Request detail / response

-   Accept the request.
-   Or choose "Not right now" and suggest another time.
-   Keep the response process short.

### Send invitation

-   Choose a connected child.
-   Choose an activity.
-   Review and send.

## 5. Interaction and content rules

-   The child-initiated request action should be the most prominent
    child action.
-   Parent initiation should be available but visually secondary in the
    child-first product hierarchy.
-   Use plain, age-appropriate language.
-   Use positive, neutral responses.
-   Never use guilt, urgency, streaks, or pressure to drive engagement.
-   Make pending, accepted, and later-suggested states visually
    distinct.
-   Provide accessible contrast, readable typography, screen-reader
    labels, and touch targets suitable for children.

## 6. Navigation boundaries

Keep navigation shallow. The MVP should not need a large tab bar or a
complex dashboard. Each role should be able to reach its primary action
quickly.

## 7. Visual reference

The previously generated app concept board is the initial visual
reference for the product direction. It is not a complete specification.
Final screen layouts, typography, spacing, colors, and component
behavior should be documented and validated as implementation proceeds.

## 8. Design decisions to validate

-   Exact age range and corresponding reading level.
-   Whether children can read independently or need parent-assisted
    setup.
-   Whether activity selection is one screen or a short sequence.
-   How to display a suggested time without introducing a full calendar.
-   How to handle multiple parents/guardians without adding complexity.
