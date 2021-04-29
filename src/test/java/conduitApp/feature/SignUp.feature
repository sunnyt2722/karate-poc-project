@ignore
Feature: Sign Up user

    Background: Preconditions
        Given url apiUrl 
        
        Scenario: Sign up for a new user
        Given def userData = {"email": "email@gs.cd", "username": "sudnf23"}

        Given path 'users'
        # And request {"user":{"email":"#(userData.email)","password":"Test@123","username":"#(userData.username)"}}
        And request
        """
            {
                "user": {
                        "email": "#(userData.email)",
                        "password": "Test@123",
                        "username": "#(userData.username)"
                }               
            }
        """
        When method Post
        Then status 200