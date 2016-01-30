<- puddi

level-data =
  * xp-min: 500
    xp-pass: 1000
    xp-max: 3000
    hp-goal: 3000
    overload-wait: 1000
    cooldown: 1000
  ...

var last-level
level-data-processed = for level, index in level-data
  last-level = if index is 0
    level
  else
    last-level with level

@lv = (level = @$lv) ->
  level-data-processed[level]

@$lv = level-data-processed.length - 1 unless @lv!?
