# RaceDay Data Model

## 1. User

- UserID (PK)
- FirstName
- LastName
- Email (UNIQUE)
- PasswordHash
- PhoneNumber
- Role
- CreatedAt

## 2. Event

- EventID (PK)
- OrganiserID (FK → User.UserID)
- EventName
- Description
- EventDate
- Location
- RegistrationDeadline
- CreatedAt

## 3. Category

- CategoryID (PK)
- EventID (FK → Event.EventID)
- CategoryName
- DistanceKm
- EntryFee
- MaximumParticipants

## 4. Enrolment

- EnrolmentID (PK)
- ParticipantID (FK → User.UserID)
- CategoryID (FK → Category.CategoryID)
- EnrolmentDate
- EmergencyContactName
- EmergencyContactPhone
- Status

## 5. Result

- ResultID (PK)
- EnrolmentID (FK → Enrolment.EnrolmentID)
- FinishTime
- Position
- AveragePace
- ResultStatus
- RecordedAt

## 6. Route

- RouteID (PK)
- EventID (FK → Event.EventID)
- RouteName
- DistanceKm
- ElevationGain
- MapUrl
- Description

## 7. Weather

- WeatherID (PK)
- EventID (FK → Event.EventID)
- ForecastDate
- Temperature
- WeatherCondition
- WindSpeed
- RainProbability

## 8. EventImage

- ImageID (PK)
- EventID (FK → Event.EventID)
- ImageUrl
- BlobName
- UploadedAt
- ## Design Notes

The User entity stores both Organiser and Participant accounts using the Role attribute.

OrganiserID in the Event entity identifies the user responsible for managing an event, while ParticipantID in the Enrolment entity identifies the participant entering an event.

This approach avoids unnecessary duplicate user tables while maintaining clear relationships between users, events and enrolments.
