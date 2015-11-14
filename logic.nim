const mapSize = 10
const winSeqSize = 5

type
    Matrix[W, H: static[int]] = array[1..W, array[1..H, int]]
    Game* = object
        map: Matrix[mapSize, mapSize]
        activePlayer: int
        winner: int


proc gameStart(g: ref Game) =
    if g.activePlayer == 0:
        g.activePlayer = 1


discard """
proc getLongestSequence(g: ref Game, startX, startY: int, endX, endY: int, dX, dY: int): int =
    var x = startX
    var y = startY
    var len = 0
    var maxLen = 0
    while  x != endX  and  y != endY:
        if g.map[x][y] == g.activePlayer:
            len += 1
        else:
            maxLen = max(len, maxLen)
            len = 0
        x += dX
        y += dY
    return maxLen
"""


proc getSequenceLen(g: ref Game, startX, startY: int, dX, dY: int): int =
    var len = 0
    var x = startX
    var y = startY
    while 0 < x  and  x <= mapSize  and  0 < y  and  y <= mapSize  and  g.map[x][y] == g.activePlayer:
        len += 1
        x += dX
        y += dY
    return len

proc checkForWinner(g: ref Game, x, y: int) =
    let horLen = 1 + g.getSequenceLen(x - 1, y, -1, 0) + g.getSequenceLen(x + 1, y, +1, 0)
    let vertLen = 1 + g.getSequenceLen(x, y - 1, 0, -1) + g.getSequenceLen(x, y + 1, 0, +1)
    let diag1Len = 1 + g.getSequenceLen(x - 1, y - 1, -1, -1) + g.getSequenceLen(x + 1, y + 1, +1, +1)
    let diag2Len = 1 + g.getSequenceLen(x + 1, y - 1, +1, -1) + g.getSequenceLen(x - 1, y + 1, -1, +1)
    if max(horLen, vertLen, diag1Len, diag2Len) >= winSeqSize:
        g.winner = g.activePlayer

discard """
    let gap = winSeqSize - 1

    let xL = max(x - gap, 0)
    let xR = min(x + gap, mapSize - 1)

    let yU = max(y - gap, 0)
    let yD = min(y + gap, mapSize - 1)

    let horLen  = g.getLongestSequence(xL, y,  xR, y,    1,  0)
    let vertLen = g.getLongestSequence(x,  yU, x,  yD,   0,  1)
    let diag1Len = g.getLongestSequence(xL, yU, xR, yD,   1,  1)
    let diag2Len = g.getLongestSequence(xR, yU, xL, yD,  -1,  1)
    if max(horLen, vertLen, diag1Len, diag2Len) >= winSeqSize:
        g.winner = g.activePlayer
"""


proc gameMove(g: ref Game, player: int, x, y: int): string =
    if player != g.activePlayer:
        return "invalid player"
    
    if g.map[x][y] != 0:
        return "cell is already filled"
    
    g.map[x][y] = player
    g.checkForWinner(x, y)
    if g.winner > 0:
        g.activePlayer = 3
    else:
        g.activePlayer = (2 + 1) - g.activePlayer
    return ""


proc getWinner(g: ref Game): int =
    return g.winner


var g = new Game
g.gameStart()
discard g.gameMove(1,  1, 2)
echo g.map[1][2]
