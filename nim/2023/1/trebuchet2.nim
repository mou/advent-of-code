import strutils
import tables

let digits = {'0'..'9'}
let digits_words = {"zero": '0', "one": '1', "two": '2',
                    "three": '3', "four": '4', "five": '5',
                    "six": '6', "seven": '7', "eight": '8',
                    "nine": '9'}.toTable


proc getCalibrationValue(line: string): int =
  var 
    firstDigit, lastDigit: char
    firstDigitIndex, lastDigitIndex: int 
  firstDigitIndex = line.find(digits)
  lastDigitIndex = line.rfind(digits)
  firstDigit =  (if firstDigitIndex != -1: line[firstDigitIndex] else: '0')
  lastDigit =  (if lastDigitIndex != -1: line[lastDigitIndex] else: '0')

  for word, digit in digits_words:
    let firstIndex = line.find(word)
    if firstIndex != -1 and firstIndex < firstDigitIndex or firstDigitIndex == -1:
      firstDigitIndex = firstIndex
      firstDigit = digit

    let lastIndex = line.rfind(word)
    if lastIndex != -1 and lastIndex > lastDigitIndex or firstDigitIndex == -1:
      lastDigitIndex = lastIndex
      lastDigit = digit
     

  result = parseInt($firstDigit & $lastDigit)

proc trebuchet2*() =
  var sum = 0
  while not endOfFile(stdin):
    let line = stdin.readLine()
    sum += getCalibrationValue line

  echo sum

when isMainModule:
  trebuchet2()
