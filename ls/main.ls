<- puddi

@stage = new createjs.Stage \game
createjs.Touch.enable @stage

tick-actions = $.Callbacks 'memory unique'
@tick = -> tick-actions.add it

createjs.Ticker
  ..framerate = 30
  ..timing-mode = ..RAF_SYNCHED
  ..add-event-listener \tick tick-actions.fire

@tick ~> @stage.update it
