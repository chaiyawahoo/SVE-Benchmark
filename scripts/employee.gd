class_name Employee
extends RefCounted


var first_names: Array[String] = [
	"Robert", "Mary", "James", "Betty", "John", "Barbara", "William", "Shirley", "Richard", "Patricia", 
	"Charles", "Dorothy", "Donald", "Joan", "George", "Margaret", "Thomas", "Nancy", "Joseph", "Helen"
]
var last_names: Array[String] = [
	"Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson",
	"Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Martinez"
]
var salary_cap: float = 1000 # monthly
var skill_floor: int = 1
var skill_ceiling: int = 10

var name: String
var salary: float = 250
var skill_level: int = 3 # 10 is max
var years_experience: int = 0


func _init(location: Location, iap := false) -> void:
	var skill_variance: int = randi_range(1,2) * 2 - 3
	self.skill_level += skill_variance
	self.salary += skill_variance * 10
	if not location.is_stanford:
		self.salary += 50 # worse relationship with nearby unis, non-compete clauses mean employee needs more incentive
	if iap and location.is_stanford: # better relationship with stanford, iap also increased quality of education. ban on non-compete clauses in CA means more experienced workers
		var iap_boost: int = randi_range(1, 2)
		self.skill_level += iap_boost
		self.salary += iap_boost * 10
	self.name = "%s %s" % [first_names.pick_random(), last_names.pick_random()]


func _to_string() -> String:
	return "%s: Level %d employee, $%.2f monthly salary" % [name, skill_level, salary]
