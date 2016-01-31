<- puddi

tutorial-length = 18

tutorial-queue = new createjs.LoadQueue!
last-loaded = tutorial-length

do @tutorial = (level = @$tutorial) ~>
  level |>= Number
  @$tutorial = level

  unless 0 <= level < tutorial-length
    $ \#tutorial-box .remove!
    return

  if level < last-loaded
    tutorial-queue.load-manifest ["img/tutorial/#{file}.png" for file in [level til last-loaded]]
    last-loaded := level

  tutorial-element = $ \#tutorial-box

  if !tutorial-element.length
    tutorial-element = $ '<a href id="tutorial-box">'
      ..click ~>
        it.prevent-default!
        @tutorial ++@$tutorial
      ..append-to \#gaem

  tutorial-element
    ..css \background-image "url(img/tutorial/#{level}.png)"

$ \#help-link .click ~>
  it.prevent-default!
  @tutorial 0
