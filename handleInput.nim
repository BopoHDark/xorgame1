from strutils import parseInt
from strutils import split

type
  Position = tuple[x: int, y: int]

proc validator(val: int): bool =
  const lowBorder = 0
  const hiBorder = 2
  case val
  of lowBorder..hiBorder : return true
  else: return false

proc handleInput(message: string, wrongInputMessage:string = "Error!", allowMessages: bool = true): Position =
  var pos : Position
  var input: string
  let separators = {' ', ',', ';', '(', ')'}
  var inputSeq : seq[string]
  const seqLen = 2

  while true:
    echo(message)

    try:
      input = readLine(stdin)
      inputSeq = split(input, separators)

      if inputSeq.len == seqLen:
        pos.x = parseInt(split(input, separators)[0])
        pos.y = parseInt(split(input, separators)[1])

        if validator(pos.x) and validator(pos.y):
          return pos
        else:
          if allowMessages: echo(wrongInputMessage)
      else:
          if allowMessages: echo(wrongInputMessage)
    except OverflowError:
      echo ("Overflow Error!")
    except ValueError:
      echo ("Could not convert string to integer.")
    except IOError:
      echo ("IO Error!")
    finally:
      discard

# var pos : Position

# echo(handleInput("Enter valid values:"))

# let str_tmp = readLine(stdin)
