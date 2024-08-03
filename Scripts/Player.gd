### Player.gd
extends CharacterBody2D

# Scene-Tree Node references
@onready var animated_sprite = $AnimatedSprite2D
@onready var interact_ui = $InteractUI
@onready var inventory_ui = $InventoryUI

@onready var inventory_hotbar = $InventoryHotbar
@onready var inventory_craftbar = $InventoryCraftbar

# Variables
@export var speed = 200

func _ready():
	# Set this node as the Player node
	Global.set_player_reference(self)

# Input for movement
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

# Movement & Animation
func _physics_process(_delta):
	get_input()
	move_and_slide()
	update_animation()

# Animation
func update_animation():
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				animated_sprite.play("walk_right")
			else:
				animated_sprite.play("walk_left")
		else:
			if velocity.y > 0:
				animated_sprite.play("walk_down")  
			else:
				animated_sprite.play("walk_up")

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		#get_tree().paused = !get_tree().paused
		
		if !inventory_ui.visible and inventory_hotbar.visible:
			inventory_ui.visible = true
			inventory_craftbar.visible = false
			inventory_hotbar.visible = false
			
			print("inv visible")
			
		elif inventory_ui.visible and !inventory_hotbar.visible and !inventory_craftbar.visible:
			inventory_hotbar.visible = true
			inventory_ui.visible = false
			inventory_craftbar.visible = false
			print("inv hidden")
			
		elif !inventory_ui.visible and !inventory_hotbar.visible and inventory_craftbar.visible:
			inventory_craftbar.visible = false
			inventory_hotbar.visible = false
			inventory_ui.visible = true
			print("inv hidden 2")

		
	if event.is_action_pressed("ui_interact"):
		
		if !inventory_ui.visible and inventory_hotbar.visible:
			inventory_craftbar.visible = true
			inventory_hotbar.visible = false
			print("craft visible")
			
		elif inventory_ui.visible and !inventory_hotbar.visible:
			inventory_hotbar.visible = false
			inventory_ui.visible = false
			inventory_craftbar.visible = true
			print("craft hidden")
			
		elif !inventory_ui.visible and !inventory_hotbar.visible and inventory_craftbar:
			inventory_craftbar.visible = false
			inventory_hotbar.visible = true
			inventory_ui.visible = false
			print("craft hidden 2")

func apply_item_effect(item):
	match item["effect"]:
		"Stamina":
			speed += 50
			print("SPeed BOOST! You got " + str(speed) +  "speed :O")
		"Slot Boost":
			Global.increase_inventory_size(5)
			print("Slots increased to ", Global.inventory.size())
		"":
			print("Just used an item for nothing xd")
		_:
			print(item["effect"])

#hotbar hotkey function
func use_hotbar_item(slot_index):
	if slot_index < Global.hotbar_inventory.size():
		var item = Global.hotbar_inventory[slot_index]
		if item != null and item["effect"] != "":
			#Use the item on the current slot index
			apply_item_effect(item)
			#remove the used item
			item["quantity"] -= 1
			if item["quantity"] <= 0:
				Global.hotbar_inventory[slot_index] = null
				Global.remove_item(item["type"], item["effect"])
			Global.inventory_updated.emit()

#Listeners to keyevents to use the hotbar items

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		for i in range(Global.hotbar_size):
			if Input.is_action_just_pressed("hotbar_"+str(i+1)):
				use_hotbar_item(i)
				break
