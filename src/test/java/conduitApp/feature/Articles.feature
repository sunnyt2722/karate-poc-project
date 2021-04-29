Feature: Articles

    
    Background: Create a new article
        Given url apiUrl

        #Will call feature file everytime before executing scenario
        # * def tokenResponse = call read('classpath:helpers/Token.feature')

        #Will call feature only once at begining after that it will use cached value
        # * def tokenResponse = callonce read('classpath:helpers/Token.feature')
        # * def token = tokenResponse.authToken

    @ignore
    Scenario: Create a new article
        # Given header Authorization = 'Token '+token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "MyArticle","description": "Sunny's Article","body": "My first article"}}
        When method Post
        Then status 200
        And match response.article.title == "MyArticle"

    @delete
    Scenario: Create and delete article
        # Given header Authorization = 'Token '+token
        Given path 'articles'
        #Create article
        And request {"article": {"tagList": [],"title": "ArticleToBeDelete","description": "Sunny's Article","body": "My first article"}}
        When method Post
        Then status 200
        And match response.article.title == "ArticleToBeDelete"
        * def slug = response.article.slug

        #Get article and verify article is there
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'ArticleToBeDelete'

        #Delete article
        # Given header Authorization = 'Token '+token
        Given path 'articles', slug
        When method Delete
        Then status 200

        #Get article and verify article was delete
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'ArticleToBeDelete'