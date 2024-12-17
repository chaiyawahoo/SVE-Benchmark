extends Node


signal ticked(elapsed: int)
signal day_ticked(days_elapsed: int)
signal month_ticked(months_elapsed: int)
signal year_ticked(years_elapsed: int)

var ticks_elapsed: int = 0
var tick_rate: int = 10 # per second
var tick_delay: float = 1.0 / float(tick_rate)
var tick_timer: float = 0
var ticking := false

var ticks_per_day: int = 1
var days_per_month: int = 30
var ticks_per_month: int = ticks_per_day * days_per_month
var months_per_year: int = 12
var ticks_per_year: int = ticks_per_month * months_per_year


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
	
	if ticks_elapsed % ticks_per_day == 0:
		day_ticked.emit(ticks_elapsed / ticks_per_day)
	if ticks_elapsed % ticks_per_month == 0:
		month_ticked.emit(ticks_elapsed / ticks_per_month)
	if ticks_elapsed % ticks_per_year == 0:
		year_ticked.emit(ticks_elapsed / ticks_per_year)
