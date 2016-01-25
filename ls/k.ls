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
    exclaim: 2
|> new createjs.Sprite _
  ..x = 69
  ..y = 49

@stage.add-child k
