Feature: Articles

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    @debug @ignore
    Scenario: Create a new article
        Given path 'users/login'
        And request {"user": {"email": "test@gs.com","password": "Karate@1"}}
        When method Post
        Then status 200
        * def token = response.user.token

        Given header Authorization = 'Token '+token
        
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "MyArticle","description": "Sunny's Article","body": "My first article"}}
        When method Post
        Then status 200
        And match response.article.title == "MyArticle"
