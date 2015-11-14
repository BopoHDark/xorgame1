import logic

const FIRSTCOLOR = "\e[1;32m"
const SECONDCOLOR = "\e[1;31m"
const STANDARTCOLOR = "\e[0m"

type
    Field = array[1..mapSize, array[1..mapSize, int]]


proc getCellStringValue(value: int) : string = 
    case value
    of 0:
        return " "
    of 1:
      return FIRSTCOLOR & "x" & STANDARTCOLOR
    of 2:
      return SECONDCOLOR & "0" & STANDARTCOLOR
    else:
        discard

proc generateTableView(game: ref Game) : string  = 
    let rowsCount = mapSize
    var result : string

    result = "\n"

    for i in countup(1, rowsCount):
        for j in countup(1, rowsCount):
            var cellValue = getCellStringValue(game.map[i][j])

            result = result & cellValue
            if j != rowsCount:
                result = result & " | "

        if i != rowsCount:
            result = result & "\n---------\n"

    result = result & "\n"
    return result



# test
# var g = new Game
# g.gameStart()
# discard g.gameMove(1, 2, 2)
# discard g.gameMove(2, 1, 1)

# echo generateTableView(g)

