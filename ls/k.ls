<- puddi

k = new createjs.Sprite-sheet do
  images:
    \img/k/0.png
    \img/k/1.png
    \img/k/2.png
  frames:
    width: 368
    height: 492
  animations:
    idle: 0
    alert: 1
    exclaim:
      frames: [2 1 2 1]
      next: \exclaimAfter
    exclaim-after: 2
|> new createjs.Sprite _
  ..x = 69
  ..y = 49

petting-k = false
var last-local
$ window
  ..on 'mousedown touchstart' ->
    petting-k := true
  ..on 'mouseup touchend' ->
    petting-k := false
    last-local := void

pet-cooldown = 0
@stage
  ..add-child k
  ..add-event-listener \stagemousemove ~>
    now = $.now!
    if petting-k and now > pet-cooldown and now > @$overload-time and now > @$recover-time
      pet-cooldown := $.now! + 50
      local = k.global-to-local it.stage-x, it.stage-y
      local.hit = k.hit-test local.x, local.y
      if last-local?hit or local.hit
        # If this isn't true, player just clicked, and there would be no point anyways
        if last-local?
          distance = ((local.x - last-local.x) ^ 2 + (local.y - last-local.y) ^ 2) ^ 0.5
          distance = Math.ceil distance

          @$xp += distance
      last-local := local

current-animation = \idle
@tick ~>
  now = it.time-stamp
  switch current-animation
  | \idle
    k.goto-and-play current-animation := \exclaim if @$xp-passing
    k.goto-and-stop current-animation := \alert unless now > @$recover-time
  | \exclaim
    k.goto-and-stop current-animation := \idle if !@$xp-passing
    k.goto-and-stop current-animation := \alert unless now > @$recover-time
  | \alert
    k.goto-and-stop current-animation := \idle if now > @$recover-time
