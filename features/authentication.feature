Feature: Authentication

Scenario: Existing User Sign-in
  Given The current session logged out
  When An existing user with email test@test.com and password 123456 logs in
  Then The home page is displayed

