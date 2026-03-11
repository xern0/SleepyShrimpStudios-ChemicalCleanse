extends Resource
class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
		emit_signal("update")
		return
	
	var empty = slots.filter(func(slot): return slot.item == null)
	if !empty.is_empty():
		empty[0].item = item
		empty[0].amount = 1
		emit_signal("update")
	else:
		print("Inventory full!")
