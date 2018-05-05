extends Node2D

var spawns = []
var activePlayers = [null, null, null]

func _ready():
	spawns = $Spawns.get_children()
	self.spawnPlayer(1)
	self.spawnPlayer(2)
	randomize()

func spawnPlayer(var playerNumber):
	var availableSpawns = []
	for spawn in spawns:
		if spawn.canSpawnPlayer():
			availableSpawns.append(spawn)
	
	if availableSpawns.size() == 0:
		breakpoint
	
	var spawnNumber = randi() % availableSpawns.size()
	activePlayers[playerNumber] = availableSpawns[spawnNumber].spawnPlayer(self, playerNumber)
	
func endGame():
	pass

func notifyPlayerDeath(var playerNumber):
	var scores = get_parent().get_node("Scores")
	scores.setScore(playerNumber, scores.getScore(playerNumber) - 1)
	if scores.getScore(playerNumber) <= 0:
		self.endGame()
		
	activePlayers[playerNumber] = null
	self.spawnPlayer(playerNumber)