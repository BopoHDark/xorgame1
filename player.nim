import asyncnet, asyncdispatch

type
    Player* = object
        connection* : AsyncSocket
        index : int
        

proc processClient(player: Player) {.async.} =
  while true:
    let line = await player.connection.recvLine()
    #for c in clients:
    #  await c.send(line & "\c\L")
    echo "message " & line