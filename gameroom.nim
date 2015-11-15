import player
import logic

type
    Room* = object
        players* : array[1..2, Player]
        game : ref Game 


proc createRoom*(player1: ref Player, player2: ref Player): Room =
    var gameroom = Room()
    gameroom.players[1] = player1[]
    gameroom.players[2] = player2[]

    return gameroom

proc startGame*(gameroom : Room) = 
    gameroom.game.gameStart()

