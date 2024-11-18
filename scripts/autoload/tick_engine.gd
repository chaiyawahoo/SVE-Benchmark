extends Node


signal ticked(elapsed: int)

var ticks_elapsed: int = 0
var tick_rate: int = 2 # per second
var tick_delay: float = 1.0 / float(tick_rate)
var tick_timer: float = 0
var ticking = false


func _process(delta: float) -> void:
	if ticking:
		tick(delta)


func start_ticking() -> void:
	ticks_elapsed = 0
	tick_timer = 0
	ticking = true


func stop_ticking() -> void:
	ticks_elapsed = 0
	tick_timer = 0
	ticking = false


func pause() -> void:
	ticking = false


func unpause() -> void:
	ticking = true


func tick(delta: float) -> void:
	tick_timer += delta
	
	if tick_timer < tick_delay:
		return
	
	tick_timer -= tick_delay
	ticks_elapsed += 1
	ticked.emit(ticks_elapsed)
