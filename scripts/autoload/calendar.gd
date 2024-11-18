extends Node


signal month
signal year

var ticks_per_month: int = 60


func _ready() -> void:
	TickEngine.ticked.connect(_on_ticked)


func _on_ticked(elapsed: int) -> void:
	if elapsed % ticks_per_month == 0:
		month.emit()
