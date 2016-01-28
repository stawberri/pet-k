<- puddi

level-data =
  * xp-min: 500
    xp-pass: 1000
    xp-max: 3000
  ...

level-data-processed = for level, index in level-data
  if index is 0
    level
  else
    level-data-processed[index - 1] with level

@lv = (level = @$lv) ->
  level-data-processed[level]
