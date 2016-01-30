<- puddi

@_register-sound \xp-fail.wav volume: 0.3
@_register-sound \xp-pass.wav volume: 0.5
@_register-sound \xp-overload.wav
@_register-sound \mp-up.wav volume: 0.5
@_register-sound \lv-up.wav volume: 0.5

get-xp-state = (xp = @$xp, level-data = @lv!) ~>
  switch
  | xp < level-data.xp-min  => -1
  | xp < level-data.xp-pass =>  0
  | xp < level-data.xp-max  =>  1
  | _                       =>  2

@tick ~>
  # Calculate xp changes
  delta = it.time-stamp - @$xp-time
  delta |>= Math.floor

  return if delta < 1

  @$xp -= delta
  @$xp >?= 0

  @$xp-time = it.time-stamp

  if it.time-stamp > @$overload-time
    $ \#xp
      ..remove-class \bad
      ..text @$xp
    if @$xp-passing
      $ \#xp .add-class \good
    else
      $ \#xp .remove-class \good
  else
    $ \#xp
      ..add-class \bad
      ..remove-class \good
      ..text <| @$overload-time - it.time-stamp |> (/ 1000) |> (.to-fixed 1)

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
      @$overload-time = it.time-stamp + level-data.overload-wait
      @$xp = 0
      @$hp = 0

  # Update hp
  if @$xp-passing
    @$hp += Math.ceil ((@$xp - level-data.xp-min) * delta) / (level-data.xp-max - level-data.xp-min)
  else
    @$hp -= Math.ceil ((level-data.xp-pass - @$xp) * delta) / (level-data.xp-max - level-data.xp-min)
    @$hp >?= 0

  $ \#hp .text "#{@$hp}/#{@lv!hp-goal}"

  # Update lv / mp
  if @$hp >= level-data.hp-goal
    @_play-sound \mp-up
    @$xp-passing = false
    @$xp = 0
    @$hp = 0
    @$mp++
    @$overload-time = it.time-stamp + 5000

  $ \#mp .text @$mp
  $ \#lv .text @$lv
