Feature: Articles

    
    Background: Create a new article
        Given url 'https://conduit.productionready.io/api/'
        Given path 'users/login'
        And request {"user": {"email": "test@gs.com","password": "Karate@1"}}
        When method Post
        Then status 200
        * def token = response.user.token
        Given header Authorization = 'Token '+token

    @debug @ignore
    Scenario: Create a new article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "MyArticle","description": "Sunny's Article","body": "My first article"}}
        When method Post
        Then status 200
        And match response.article.title == "MyArticle"

    @delete
    Scenario: Create and delete article
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
        Given header Authorization = 'Token '+token
        Given path 'articles', slug
        When method Delete
        Then status 200

        #Get article and verify article was delete
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'ArticleToBeDelete'