import asyncnet, asyncdispatch
import strutils
import gameroom
import player

#var clients {.threadvar.}: seq[AsyncSocket]
var players {.threadvar.}: seq[Player]
let port = 12345
var waitingRoom : ref Room

proc processClient(gameroom: ref Room, playerIndex : int) {.async.} =
  while true:
    var line = await gameroom.players[playerIndex].connection.recvLine()
    #for c in clients:
    #  await c.send(line & "\c\L")
    echo "message " & line

proc serve() {.async.} =
  players = @[]
  var server = newAsyncSocket()
  server.bindAddr(Port(port))
  server.listen()
  
  while true:
    let connection = await server.accept()
    var newPlayer = Player()
    newPlayer.connection = connection
    #clients.add client
    players.add newPlayer
    var playerIndex = 1

    if waitingRoom == nil:
        waitingRoom = new(Room)
        waitingRoom.players[playerIndex] = newPlayer
    else:
        playerIndex += 1
        waitingRoom.players[playerIndex] = newPlayer
        waitingRoom[].startGame()
        
    asyncCheck processClient(waitingRoom, playerIndex)
    
    if playerIndex == 2:
      waitingRoom = nil

echo "Start server at port " & intToStr(port)
asyncCheck serve()
runForever()