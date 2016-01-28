<- puddi

background = new createjs.Container!
  ..x = 480
  ..y = 270

@stage.add-child background

city-water = new createjs.Bitmap \img/bg/city-water.jpg
  ..reg-x = 640
  ..reg-y = 360

background.add-child city-water

@tick ~>
  scale = @$xp
  scale /= @lv!xp-max

  city-water-scale = -scale * 0.05 + 1
  city-water-blur = scale * 10
  city-water-blur = new createjs.BlurFilter city-water-blur, city-water-blur, 1

  city-water
    ..scale-x = city-water-scale
    ..scale-y = city-water-scale
    ..filters =
      city-water-blur
      ...
    ..cache 0 0 1280 720
