class_name Product
extends RefCounted


static var g_transistor = Product.new("Germanium transistor", 5.00, 0.4, true) # 1/30th price of silicon transistor
static var s_transistor = Product.new("Silicon transistor", 150.00, 0.2, true) # fairchild silicon transistor cost around $150!


var name: String
var market_price: float
var consistency: float
var solid_state: bool
var times_researched: int = 0


func _init(name: String, market_price: float, consistency: float, solid_state := false) -> void:
	self.name = name
	self.consistency = consistency
	self.market_price = market_price
	self.solid_state = solid_state
