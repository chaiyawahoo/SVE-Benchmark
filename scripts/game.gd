class_name Game
extends Control


var iap := false  # iap is Industrial Associates Program
var iap_cost: float = 5000

var startup_name := ""
var product: Product # transistor, klystron, integrated cirucit (IC)
var location: Location
var employees: Array[Employee]
var money: float = 150000

var research_progress: float = 0
var research_target: float = 50
var base_research_tick_probability: float = 0.35
var research_tick_probability: float = 0.5


func _ready() -> void:
	product = Product.g_transistor
	location = Location.stanford_industrial_park
	
	money -= location.get_random_cost()
	
	if product.solid_state and location.is_stanford:
		enroll_in_iap()
		pass # offer iap enrollment
	
	for i in range(10):
		employees.append(Employee.new(location, iap))
		print(employees[i])
	
	research_tick_probability = calculate_research_tick_probability()
	print("Probability: %.2f%%" % research_tick_probability)
	
	TickEngine.ticked.connect(research_tick)
	TickEngine.day_ticked.connect(_on_day_ticked)
	TickEngine.month_ticked.connect(_on_month_ticked)
	TickEngine.year_ticked.connect(_on_year_ticked)
	TickEngine.start_ticking()
	
	$ProgressBar.max_value = research_target


func enroll_in_iap() -> void:
	iap = true
	money -= iap_cost


func research_tick(_elapsed: int) -> void:
	var random: float = randf()
	var bonus: int = int(research_tick_probability) - 1 # bonus when probability > 1
	var mantissa: float = research_tick_probability - int(research_tick_probability)
	var increment: float = 0
	while bonus > 0:
		increment += (0.5 + abs(log(random)))
		bonus -= 1
	if random <= mantissa:
		increment += (0.5 + abs(log(random)))
		print(increment)
		research_progress += increment
	$ProgressBar.value = research_progress
	if research_progress >= research_target:
		TickEngine.ticked.disconnect(research_tick)
		#TickEngine.pause()
		print("Excess: %f" % (research_progress - research_target))
		product.times_researched += 1


func production_tick(_elapsed: int) -> void:
	var random: float = randf()


func money_format(number: float) -> String:
	var output: String = "%.2f" % number
	var working_size: int = output.length()
	var mod: int = working_size % 3
	if mod == 0:
		mod = 3
	while working_size > 6:
		output = output.insert(mod, ",")
		working_size -= 3
		mod += 4
	return output


func calculate_research_tick_probability() -> float:
	var output: float = base_research_tick_probability
	var skill_sum: float
	for employee in employees:
		skill_sum += employee.skill_level
	output += skill_sum / 100
	output += product.times_researched / 50
	return output


func _on_day_ticked(_days_elapsed: int) -> void:
	money -= 0
	#print("== DAY ELAPSED: $%s IN ACCOUNT ==" % money_format(money))


func _on_month_ticked(_months_elapsed: int) -> void:
	for employee in employees:
		money -= employee.salary
	print("==== MONTH ELAPSED: $%s IN ACCOUNT ====" % money_format(money))


func _on_year_ticked(_years_elapsed: int) -> void:
	for employee in employees:
		employee.years_experience += 1
		employee.salary += 125
	if iap and location.is_stanford:
		money -= iap_cost
	print("======== YEAR ELAPSED: $%s IN ACCOUNT ========" % money_format(money))
