<- puddi

@$ = new Barn local-storage

# Numbers
for let name in <[xp lv hp xpTime overloadTime]>
  @ <<< "$#{name}":~
    ~>
      @$.get name
      |> -> it ? 0
    (it) ~>
      value = parse-int it, 10
      unless isNaN value
        @$.set name, value
      else
        @$.del name

# Everything else
for let name in <[xpPassing]>
  @ <<< "$#{name}":~
    ~> @$.get name
    (it) ~>
      if it?
        @$.set name, it
      else
        @$.del name
