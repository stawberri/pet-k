<- puddi

@_register-sound \xp-fail.wav volume: 0.3
@_register-sound \xp-pass.wav volume: 0.5
@_register-sound \xp-overload.wav

get-xp-state = (xp = @$xp) ~>
  switch
  | xp < @lv!xp-min   => -1
  | xp < @lv!xp-pass  =>  0
  | xp < @lv!xp-max   =>  1
  | _                 =>  2

last-xp = @$xp

@tick ~>
  # Calculate xp changes
  delta = it.time-stamp - @$xp-time
  delta |>= Math.floor

  return if delta < 1

  @$xp -= delta
  @$xp >?= 0

  @$xp-time = it.time-stamp

  if it.time-stamp > @$overload-time
    $ '#xp'
      ..remove-class \bad
      ..text @$xp
    if @$xp-passing
      $ '#xp' .add-class \good
    else
      $ '#xp' .remove-class \good
  else
    $ '#xp'
      ..add-class \bad
      ..remove-class \good
      ..text <| @$overload-time - it.time-stamp |> (/ 1000) |> (.to-fixed 1)

  # Check xp status
  switch get-xp-state!
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
      @$overload-time = it.time-stamp + 5000
      @$xp = 0

  last-xp := @$xp
