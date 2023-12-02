import strutils

let digits = {'0'..'9'}

proc getCalibrationValue(line: string): int =
  let firstDigit = line[line.find(digits)]
  let lastDigit = line[line.rfind(digits)]

  result = parseInt($firstDigit & $lastDigit)

proc trebuchet*() =
  var sum = 0
  while not endOfFile(stdin):
    let line = stdin.readLine()
    sum += getCalibrationValue line

  echo sum

when isMainModule:
  trebuchet()
