class_name Product


var name: String
var market_price: float
var consistency: float


func _init(name: String, market_price: float, consistency: float) -> void:
	self.name = name
	self.consistency = consistency
	self.market_price = market_price
