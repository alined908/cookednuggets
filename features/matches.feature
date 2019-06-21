Feature: Matches

    As a user
    I want to add my matches
    So that I can view statistics

    Background: User logged in
      Given a registered user with email "daniel@gmail.com" with password "password" exists
      When I login as user with email "daniel@gmail.com" and password "password"
      Then I should see "Signed in successfully"
      When I follow "Matches"
      And a match with map "Lijiang Tower" and left_team "NYE" and right_team "LDN" exists

    Scenario: Create new match
      When I follow "New Match"
      And I press "Submit"
      Then I should see "Date can't be blank Left team can't be blank Right team can't be blank Map can't be blank"
      And I create a match with map "Rialto" and left_team "SFS" and right_team "DAL"
      Then I should see "Match successfully created! Upload compositions, fights, and general statistics!"

    Scenario: Edit match
      When I follow "Matches"
      When I follow "Edit Match"
      And I fill in "Map" with ""
      And I press "Submit"
      Then I should see "Map can't be blank"
      And I fill in "Map" with "Oasis"
      And I press "Submit"
      Then I should see "Match was successfully updated."

    Scenario: Delete match
      When I follow "Matches"
      When I follow "Delete Match"
      Then I should see "Match successfully destroyed."

    Scenario: Upload CSVs
      When I follow "Matches"
      When I follow "Match Details"
      When I upload a composition csv
      And I press "Upload Comps"
      Then I should see "Successfully imported compositions"
      When I upload a general csv
      And I press "Upload General"
      Then I should see "Successfully imported general statistics"
      When I upload a fight csv
      And I press "Upload Fights"
      Then I should see "Successfully imported fight statistics"
