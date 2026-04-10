extends Node

var selected_index: int = -1
var inv: Inv = null

func select_slot(index: int, inventory: Inv):
	print("select_slot called, index: ", index, " selected_index: ", selected_index)
	if selected_index == -1:
		# First click - select if slot has item
		if inventory.slots[index].item != null:
			selected_index = index
			inv = inventory
			print("Selected slot: ", index)
		else:
			print("Slot is empty, not selecting")
	else:
		inv.move(selected_index, index)
		print("Moved from ", selected_index, " to ", index)
		selected_index = -1
		inv = null
