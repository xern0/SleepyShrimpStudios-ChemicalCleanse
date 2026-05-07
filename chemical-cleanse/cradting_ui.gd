extends PanelContainer
class_name CraftingUI

@export var inventory_slot : PackedScene = null
@export var recipe_array : Array[ItemRecipes] = []

@onready var tree : Tree = %Tree
@onready var title_label : Label = %TitleLabel
@onready var grid_container : GridContainer = %GridContainer
@onready var item_texture : TextureRect = %ItemTexture

var recipe_material_dictionary : Dictionary = {}
var player_inventory : Inv = preload("res://assets/Items/playerinv.tres")
var current_recipe : ItemRecipes = null


func _ready() -> void:
	build_recipe_tree()

func build_recipe_tree() -> void:
	tree.hide_root = true
	var tree_root : TreeItem = tree.create_item()
	for recipe in recipe_array:
		var new_recipe_slot : TreeItem = tree.create_item(tree_root)
		new_recipe_slot.set_icon(0, recipe.recipe_final_name.texture)
		new_recipe_slot.set_text(0, recipe.recipe_final_name.name)




func _on_tree_cell_selected() -> void:
	var cell_recipe_name : String = tree.get_selected().get_text(0)
	print(cell_recipe_name)
	for recipe in recipe_array:
		if recipe.recipe_final_name.name == cell_recipe_name:
			build_recipe_material_window(recipe)
			return


	
func build_recipe_material_window(selected_recipe: ItemRecipes) -> void:
	title_label.text = selected_recipe.recipe_final_name.name
	item_texture.texture = selected_recipe.recipe_final_name.texture
	recipe_material_dictionary.clear()
	for child in grid_container.get_children():
		child.queue_free()

	for recipe_material in selected_recipe.recipe_material_array:
		var new_slot = inventory_slot.instantiate()
		grid_container.add_child(new_slot)
		new_slot.set_item(recipe_material, 1)
		if recipe_material_dictionary.has(recipe_material.name):
			recipe_material_dictionary[recipe_material.name] += 1
		else:
			recipe_material_dictionary[recipe_material.name] = 1

func _on_craft_button_pressed() -> void:
	if player_inventory == null:
		print("No player inventory assigned!")
		return
	for material_name in recipe_material_dictionary:
		var required_amount = recipe_material_dictionary[material_name]
		var found_amount = 0
		for slot in player_inventory.slots:
			if slot.item != null and slot.item.name == material_name:
				found_amount += slot.amount
		if found_amount < required_amount:
			print("Not enough ", material_name)
			return
	for material_name in recipe_material_dictionary:
		var amount_to_remove = recipe_material_dictionary[material_name]
		for i in range(player_inventory.slots.size()):
			if amount_to_remove <= 0:
				break
			var slot = player_inventory.slots[i]
			if slot.item != null and slot.item.name == material_name:
				if slot.amount <= amount_to_remove:
					amount_to_remove -= slot.amount
					player_inventory.remove(i)
				else:
					slot.amount -= amount_to_remove
					amount_to_remove = 0
	player_inventory.insert(current_recipe.recipe_final_name)
	print("Crafted!", current_recipe.recipe_final_name.name)
