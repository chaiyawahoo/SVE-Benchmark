class_name Game
extends Control


var transistor = Product.new("transistor", 40.00, 0.2)


var startup_name := ""
var product: Product # transistor, klystron, integrated cirucit (IC)
var money: float = 0

var research_progress: float = 0
var research_target: float = 50
var research_tick_probability: float = 0.5


func _ready() -> void:
	TickEngine.ticked.connect(research_tick)
	TickEngine.start_ticking()
	
	$ProgressBar.max_value = research_target


func research_tick(_elapsed: int) -> void:
	var random: float = randf()
	if random <= research_tick_probability:
		var increment = 0.5 + abs(log(random))
		print(increment)
		research_progress += increment
	$ProgressBar.value = research_progress
	if research_progress >= research_target:
		TickEngine.ticked.disconnect(research_tick)
		#TickEngine.pause()
		print("Excess: %f" % (research_progress - research_target))
