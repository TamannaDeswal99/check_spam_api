Phonebook API
A RESTful API built with Ruby on Rails for a mobile application. This API enables users to identify spam numbers, search for individuals by phone number or name, and manage their personal contacts.

Features
User Authentication:

Secure registration with name, phone number, and password (email is optional).
Ensures unique phone numbers for each registered user.
All endpoints require authentication.
Contact Management:

Handles automatic import of user phone contacts (assumed functionality).
Spam Detection:

Mark any phone number as spam.
Calculate and track spam likelihood for phone numbers.
Search Functionality:

Search for individuals by:
Name: Results prioritize names starting with the query, followed by names containing the query.
Phone Number: Retrieve all entries for a specific number, including multiple names if available.
Detailed results display:
Registered users: Full details (email shown only if the searcher is in their contact list).
Non-registered users: Basic details (name, phone number, spam likelihood).
