Feature: User can grant other users permission to view his upload

  Scenario: Adding a viewer of Upload
    Given User is signed in
    And   There are other users - potential viewers
    And   Signed in user has an upload
    And   User visits Edit Upload page
    And   User selects Access by Other Users tab
    When  Another existing user has been designated as a viewer
    Then  Viewer's email is shown in the list of viewers
    And   Delete button is displayed next to the viewer's email
