<- puddi

@stage = new createjs.Stage \game

createjs.Ticker
  ..timing-mode = ..RAF_SYNCHED
  ..add-event-listener \tick ~>
    @stage.update it
