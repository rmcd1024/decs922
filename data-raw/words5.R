library(words)

words5 <- words[words$word_length ==  5, 'word']

usethis::use_data(words5)
