<- puddi

orb-container = new createjs.Container!
  ..x = 700
  ..y = 380

do
  orb-background = new createjs.Shape!
.graphics
  ..set-stroke-style 5
  ..begin-stroke 'rgba(32, 32, 32, 1)'
  ..begin-fill 'rgba(32, 32, 32, 0.5)'
  ..draw-circle 0 0 120

do
  orb-xp = new createjs.Shape!
.graphics
  ..set-stroke-style 3
  orb-xp-command-stroke = ..begin-stroke 'rgba(128, 128, 128, 1)' .command
  orb-xp-command-fill = ..begin-fill  \transparent .command
  orb-xp-command-circle = ..draw-circle 0 0 0 .command

orb-hp = new createjs.Shape!

vector-orb = new createjs.Container!
  ..visible = false
  ..add-child orb-hp
  ..add-child orb-background
  ..add-child orb-xp
orb-container.add-child vector-orb
@stage.add-child orb-container

@tick ~>
  now = it.time-stamp
  if now > @$overload-time and now > @$recover-time
    if !vector-orb.visible
      createjs.Tween.get vector-orb, override: true
        ..to do
          alpha: 0
          scale-x: 0.69
          scale-y: 0.69
          visible: true
        ..to do
          y: 0
          alpha: 1
          scale-x: 1
          scale-y: 1
          3000
          createjs.Ease.elastic-out

    if @$xp-passing
      orb-xp-command-fill.style = 'rgba(128, 128, 128, 0.8)'
    else
      orb-xp-command-fill.style = \transparent

    orb-xp-command-circle.radius = 120 * @$xp / @lv!xp-max

    hp-height = 240 * @$hp / @hp-goal!
    orb-hp
      ..graphics
        ..clear!
        ..begin-fill 'rgba(32, 32, 32, 0.8)'
        ..rect do
          -120
          120 - hp-height
          240
          hp-height
      ..mask = orb-background
  else
    vector-orb.visible = false
