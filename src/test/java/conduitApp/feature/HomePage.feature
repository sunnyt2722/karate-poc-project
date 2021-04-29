Feature: Test for the homepage

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    Scenario: Get all tags
        Given url 'https://conduit.productionready.io/api/tags'
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page
        Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page using param
        Given param limit = 10
        Given param offset = 0
        Given url 'https://conduit.productionready.io/api/articles'
        When method Get
        Then status 200

    Scenario: Get 10 articles from the page using params
        Given params { limit:10, offset: 0}
        Given url 'https://conduit.productionready.io/api/articles'
        When method Get
        Then status 200

    @debug
    Scenario: Get all tags using path variable
        # Given url 'https://conduit.productionready.io/api/'           It will use path from Background
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'HITLER'                       
        And match response.tags contains ['Gandhi', 'HuManIty']
        And match response.tags !contains ['Sunny']
        # '==' is used for assertions
        # Testing response is array
        And match response.tags == "#array"
        # Testing response is not a string
        And match response.tags != "#string"
        # Checking elements returned by tags is string
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page using path variable
        Given params { limit:10, offset: 0}
        # Given url 'https://conduit.productionready.io/api/'           It will use path from Background
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == "#[10]"
        And match response.articles != "#[9]"
        And match response.articlesCount == 500
