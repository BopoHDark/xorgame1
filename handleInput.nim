from strutils import parseInt
from strutils import split

const LOW_BORDER = 1
const HI_BORDER = 3
const VALID_INPUT_COUNT = 2

type
  Position* = tuple[x: int, y: int]

proc validator(val: int): bool =
  case val
  of LOW_BORDER..HI_BORDER : return true
  else: return false

proc handleInput*(message: string = "Enter valid mark coordinates(1..3):",
                  wrongInputMessage:string = "Error! Wrong input.",
                  allowMessages: bool = true): Position =
  var pos : Position
  var input: string
  let separators = {' ', ',', ';', '(', ')', '\x09', '\x0B', '\x0D', '\x0A', '\x0C'}
  var inputSeq : seq[string]

  while true:
    echo(message)

    try:
      input = readLine(stdin)
      inputSeq = split(input, separators)

      if inputSeq.len == VALID_INPUT_COUNT:
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

# echo(handleInput())

