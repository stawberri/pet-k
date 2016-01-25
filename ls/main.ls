<- puddi

@stage = new createjs.Stage \game
@barn = new Barn local-storage

createjs.Ticker
  ..timing-mode = ..RAF_SYNCHED
  ..add-event-listener \tick ~>
    @stage.update it
