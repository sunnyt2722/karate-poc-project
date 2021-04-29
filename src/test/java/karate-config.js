function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: "https://conduit.productionready.io/api/"
  }
  if (env == 'dev') {
    config.userEmail = "test@gs.com";
    config.userPassword = "Karate@1";
  } else if (env == 'e2e') {
    config.userEmail = "test2@gs.com";
    config.userPassword = "Karate@2";
  }

  var accessToken = karate.callSingle('classpath:helpers/Token.feature', config).authToken;
  karate.configure('headers',{Authorization: 'Token '+accessToken});
  return config;
}