# save your key
my_key<-'SIP6S0GG'

# load library
library(threewords)

# package
from_position(key=my_key, positions = c(48.12345, 14.12345))

from_words(key=my_key, words=c("freshen", "combed", "relating"))

from_words(key=my_key, words=c("combed", "freshen", "relating"))

from_words(key=my_key, words=c("table", "chair", "potato"))

# invalid query
from_words(key=my_key, words=c("table", "chair", "potatoes"))

# after my language extension
from_position(key=my_key, positions = c(48.12345, 14.12345), lang="de")
from_words(key=my_key, words=c("table", "chair", "potato"), lang="de")
from_words(key=my_key, words=c("mich", "landesbank", "westlich"), lang="de")
