@debug
Feature: Test for the homepage

    Background: Define URL
        Given url apiUrl

    # Scenario: Get all tags
    #     Given url 'https://conduit.productionready.io/api/tags'
    #     When method Get
    #     Then status 200

    # Scenario: Get 10 articles from the page
    #     Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'
    #     When method Get
    #     Then status 200

    # Scenario: Get 10 articles from the page using param
    #     Given param limit = 10
    #     Given param offset = 0
    #     Given url 'https://conduit.productionready.io/api/articles'
    #     When method Get
    #     Then status 200

    # Scenario: Get 10 articles from the page using params
    #     Given params { limit:10, offset: 0}
    #     Given url 'https://conduit.productionready.io/api/articles'
    #     When method Get
    #     Then status 200

    Scenario: Get all tags using path variable
        # Given url 'https://conduit.productionready.io/api/'           It will use path from Background
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'HITLER'                       
        And match response.tags contains ['Gandhi', 'HuManIty']       
        # Testing if any of the value is present in response then fine
        And match response.tags contains any ['Gandhi', 'HuManIty', 'Woodpeckar', 'Chicken']

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
        And match response == {"articles": "#array", "articlesCount": 500}
        And match response.articles[0].createdAt contains '2021'
        And match response.articles[*].favoritesCount contains 1
        And match response.articles[*].author.bio contains null
        #Wildcard and Karate will look for all bio keys in the response
        # And match response..bio contains null
        # And match each response..following == false

        And match each response..following == "#boolean"
        And match each response..favoritesCount == "#number"
        # '##' acceptable value can be string or null and if bio is not present in response test will not fail
        And match each response..bio == "##string"