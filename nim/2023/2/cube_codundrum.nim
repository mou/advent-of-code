import parseutils, sequtils, strutils

type
  Color = enum
    red = "red"
    green = "green"
    blue = "blue"

  Round = array[Color, int]

  Game = object
    id: int
    rounds: seq[Round]

proc isPossible(game: Game, bag: Round): bool =
  return game.rounds.all(proc(r: Round): bool =
    r.pairs.toSeq.allIt(it.val <= bag[it.key]))


proc updateRound(round: var Round, token: string) =
  var
    next = 0
    count = 0
    colorStr = ""
  next += skipWhitespace(token)
  next += parseInt(token, count, next)
  next += skipWhitespace(token, next)
  next += parseIdent(token, colorStr, next)
  let color = parseEnum[Color](colorStr)
  round[color] = count

proc parseGame(line: string): Game =
  var next = skip(line, "Game ")
  var id: int
  next += parseInt(line, id, next)
  next += skip(line, ":", next)
  var
    rounds: seq[Round] = @[]
    round: Round = [0, 0, 0]
    token = ""
    parsed = 0
    delim: char = '\x00'
  while next < line.high():
    parsed = parseUntil(line, token, {',', ';', '\x00'}, next)
    if parsed > 0:
      updateRound(round, token)
    next += parsed
    parsed = parseChar(line, delim, next)
    if (parsed > 0 and delim == ';') or parsed == 0:
      rounds.add(round)
      round = [0, 0, 0]
    next += parsed

  return Game(id: id, rounds: rounds)

proc cubeCodundrum*() =
  let bag = [12, 13, 14]
  var sum = 0
  while not endOfFile(stdin):
    let line = stdin.readLine()
    let game = parseGame(line)
    if game.isPossible(bag):
      sum += game.id
  echo sum

when isMainModule:
  cubeCodundrum()
