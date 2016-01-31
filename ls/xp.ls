<- puddi

@_register-sound \xp-fail.mp3 volume: 0.3
@_register-sound \xp-pass.mp3 volume: 0.5
@_register-sound \xp-overload.mp3
@_register-sound \mp-up.mp3 volume: 0.5
@_register-sound \lv-up.mp3 volume: 0.5

get-xp-state = (xp = @$xp, level-data = @lv!) ~>
  switch
  | xp < level-data.xp-min  => -1
  | xp < level-data.xp-pass =>  0
  | xp < level-data.xp-max  =>  1
  | _                       =>  2

@hp-goal = ~> Math.ceil (1 + (@$mp / 69)) * @lv!hp-goal

@tick ~>
  # Calculate xp changes
  delta = it.time-stamp - @$xp-time
  delta |>= Math.floor

  return if delta < 1

  @$xp -= delta
  @$xp >?= 0

  @$xp-time = it.time-stamp

  level-data = @lv!

  # Check xp status
  switch get-xp-state @$xp, level-data
  | -1
    if @$xp-passing
      @_play-sound \xp-fail
      @$xp-passing = false
  | 0
    void
  | 1
    if !@$xp-passing
      @_play-sound \xp-pass
      @$xp-passing = true
  | 2
    if it.time-stamp > @$overload-time
      @_play-sound \xp-overload
      @$xp-passing = false
      @$overload-time = it.time-stamp + (level-data.overload-wait * (1 + (@$mp / 69)))
      @$xp = 0
      @$hp = 0

  # Update hp
  if @$xp-passing
    @$hp += Math.ceil ((@$xp - level-data.xp-min) * delta) / (level-data.xp-max - level-data.xp-min)
  else
    @$hp -= Math.ceil ((level-data.xp-pass - @$xp) * delta) / (level-data.xp-max - level-data.xp-min)
    @$hp >?= 0

  # Update lv / mp
  if @$hp >= @hp-goal!
    @$xp-passing = false
    @$xp = 0
    @$hp = 0
    @$overload-time = 0

    if @lv @$lv + 1 |> (?)
      @_play-sound \lv-up
      @$mp = 0
      @$lv++
    else
      @_play-sound \mp-up
      @$mp++

    @$recover-time = it.time-stamp + (@lv!cooldown * (1 + (@$mp / 69)))
