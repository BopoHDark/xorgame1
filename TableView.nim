const ROWS = 3
const FIRSTCOLOR = "[1;32m"
const SECONDCOLOR = "[1;31m"
const STANDARTCOLOR = "[0m"

type
    Field = array[1..ROWS, array[1..ROWS, int]]


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

proc generateTableView(field: Field) : string  = 
    let rowsCount = ROWS
    var result : string

    result = "\n"

    for i in countup(1, rowsCount):
        for j in countup(1, rowsCount):
            var cellValue = getCellStringValue(field[i][j])

            result = result & cellValue
            if j != rowsCount:
                result = result & " | "

        if i != rowsCount:
            result = result & "\n---------\n"

    result = result & "\n"
    return result

# let fieldExample: Field = [[1, 1, 0],
#                         [1, 2, 2],
#                         [0, 1, 0]]
# echo generateTableView(fieldExample)

