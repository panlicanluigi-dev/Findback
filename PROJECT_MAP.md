# Project map

## Page 1 — Register
- University-style registration form
- Full name
- University email
- Password
- Confirm password
- Create Account button
- Same clean white/blue visual language as the supplied reference

## Page 2 — Dashboard
- Welcome message
- Search Lost
- Report Item
- Found Items
- My Reports
- Recent Items
- Bottom navigation visual

## Backend
Laravel handles:
- Web registration
- Web session authentication
- Mobile JSON registration
- Mobile token authentication with Sanctum
- Dashboard JSON response

## Deliberately excluded
To keep the research prototype at exactly two pages, this package does not create separate Search, Report, Activity, Profile, or Forgot Password pages. Their dashboard cards are visual placeholders for the future modules.
