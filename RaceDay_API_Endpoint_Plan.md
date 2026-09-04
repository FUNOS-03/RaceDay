# RaceDay API Endpoint Plan
## 1. Authentication

### POST /api/auth/register

- **Description:** Register a new user account
- **Role Required:** Public
- **Request Body:** FirstName, LastName, Email, Password, PhoneNumber, Role
- **Expected Response:** 201 Created

### POST /api/auth/login

- **Description:** Authenticate a user and provide access to the RaceDay system
- **Role Required:** Public
- **Request Body:** Email, Password
- **Expected Response:** 200 OK with authentication token

## 2. User Profile

### GET /api/users/me

- **Description:** Retrieve the profile details of the currently logged-in user
- **Role Required:** Organiser or Participant
- **Request Body:** None
- **Expected Response:** 200 OK with user profile details

### PUT /api/users/me

- **Description:** Update the profile details of the currently logged-in user
- **Role Required:** Organiser or Participant
- **Request Body:** FirstName, LastName, PhoneNumber
- **Expected Response:** 200 OK with updated user profile details

## 3. Event Management

### GET /api/events

- **Description:** Retrieve a list of upcoming events
- **Role Required:** Public
- **Request Body:** None
- **Expected Response:** 200 OK with a list of events

### GET /api/events/{id}

- **Description:** Retrieve detailed information about a specific event
- **Role Required:** Public
- **Request Body:** None
- **Expected Response:** 200 OK with event details

### POST /api/events

- **Description:** Create a new event
- **Role Required:** Organiser
- **Request Body:** EventName, Description, EventDate, Location, RegistrationDeadline
- **Expected Response:** 201 Created with the new event details

### PUT /api/events/{id}

- **Description:** Update an existing event
- **Role Required:** Organiser
- **Request Body:** EventName, Description, EventDate, Location, RegistrationDeadline
- **Expected Response:** 200 OK with updated event details

### DELETE /api/events/{id}

- **Description:** Delete an existing event
- **Role Required:** Organiser
- **Request Body:** None
- **Expected Response:** 204 No Content
## 4. Category Management

### GET /api/events/{eventId}/categories

- **Description:** Retrieve all categories available for a specific event
- **Role Required:** Public
- **Request Body:** None
- **Expected Response:** 200 OK with a list of event categories
### POST /api/events/{eventId}/categories

- **Description:** Create a new category for a specific event
- **Role Required:** Organiser
- **Request Body:** CategoryName, DistanceKm, EntryFee, MaximumParticipants
- **Expected Response:** 201 Created with the new category details

### PUT /api/categories/{id}

- **Description:** Update an existing event category
- **Role Required:** Organiser
- **Request Body:** CategoryName, DistanceKm, EntryFee, MaximumParticipants
- **Expected Response:** 200 OK with updated category details
### DELETE /api/categories/{id}

- **Description:** Delete an existing event category
- **Role Required:** Organiser
- **Request Body:** None
- **Expected Response:** 204 No Content
## 5. Enrolment Management

### POST /api/events/{eventId}/enrolments

- **Description:** Enrol a participant in an event category
- **Role Required:** Participant
- **Request Body:** CategoryID, EmergencyContactName, EmergencyContactPhone
- **Expected Response:** 201 Created with enrolment details
### GET /api/enrolments/me

- **Description:** Retrieve all event enrolments for the currently logged-in participant
- **Role Required:** Participant
- **Request Body:** None
- **Expected Response:** 200 OK with a list of the participant's enrolments
### GET /api/events/{eventId}/enrolments

- **Description:** Retrieve all participant enrolments for a specific event
- **Role Required:** Organiser
- **Request Body:** None
- **Expected Response:** 200 OK with a list of event enrolments
### GET /api/enrolments/{id}

- **Description:** Retrieve details of a specific participant enrolment
- **Role Required:** Participant or Organiser
- **Request Body:** None
- **Expected Response:** 200 OK with enrolment details
## 6. Results Management

### GET /api/enrolments/{enrolmentId}/result

- **Description:** Retrieve the race result for a specific enrolment
- **Role Required:** Participant or Organiser
- **Request Body:** None
- **Expected Response:** 200 OK with result details
### POST /api/enrolments/{enrolmentId}/result

- **Description:** Capture a participant's race result
- **Role Required:** Organiser
- **Request Body:** FinishTime, Position, AveragePace, ResultStatus
- **Expected Response:** 201 Created with result details
### PUT /api/results/{id}

- **Description:** Update a participant's race result
- **Role Required:** Organiser
- **Request Body:** FinishTime, Position, AveragePace, ResultStatus
- **Expected Response:** 200 OK with updated result details
## API Design Notes

All API endpoints will use RESTful conventions and JSON request and response formats.

Authentication and role-based authorisation will be implemented in Part 2 using the Organiser and Participant roles defined in the system planning.
