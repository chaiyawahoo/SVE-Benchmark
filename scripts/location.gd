class_name Location
extends RefCounted


static var stanford_industrial_park = Location.new("Stanford Industrial Park", 70000, 30000, true) # 40k to 100k
static var east_coast = Location.new("East Coast", 28000, 10000) # 18k to 38k

var name: String
var median_cost: float
var cost_range: float
var is_stanford := false


func _init(name: String, median_cost: float, cost_range: float, is_stanford := false) -> void:
	self.name = name
	self.median_cost = median_cost
	self.cost_range = cost_range
	self.is_stanford = is_stanford


func get_random_cost() -> float:
	return randf_range(median_cost - cost_range, median_cost + cost_range)
