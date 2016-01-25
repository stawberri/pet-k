<- puddi

background = new createjs.Container!
  ..x = 480
  ..y = 270

@stage.add-child background

city-water = new createjs.Bitmap \img/bg/city-water.jpg
  ..reg-x = 640
  ..reg-y = 360

background.add-child city-water
