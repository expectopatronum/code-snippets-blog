# https://datatweet.wordpress.com/2014/05/14/reading-data-from-github-api-using-r/
# http://stackoverflow.com/questions/16882011/strsplit-error-when-attempting-to-access-fitbit-with-roauth
# http://stackoverflow.com/questions/12212958/oauth-authentification-to-fitbit-using-httr/12218175

library(httr)

key <- Sys.getenv('fitbit_key')
secret <- Sys.getenv('fitbit_secret')
fbr <- oauth_app('FitteR',key,secret)

accessTokenURL <-  'https://api.fitbit.com/oauth2/token'
authorizeURL <- 'https://www.fitbit.com/oauth2/authorize'
fitbit <- oauth_endpoint(authorize = authorizeURL, access = accessTokenURL)

token <- oauth2.0_token(fitbit,fbr, scope=c("activity", "heartrate", "sleep"), use_basic_auth = TRUE)
conf <- config(token = token)

# https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html

resp <- GET("https://api.fitbit.com/1/user/-/sleep/date/2016-06-30.json", config=conf)
cont <- content(resp, "parsed")
str(cont)

