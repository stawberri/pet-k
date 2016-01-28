<- puddi

Sound = createjs.Sound
@_register-sound = (sound, config) ->
  name = sound / \.
  name.pop!
  name *= \.
  Sound.register-sound sound, name,, \snd/, config

@_play-sound = -> Sound.play it if Sound.load-complete it
