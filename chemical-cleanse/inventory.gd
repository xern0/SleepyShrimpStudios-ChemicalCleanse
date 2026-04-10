extends Resource
class_name Inv

signal update

@export var slots: Array[InvSlot]
 

func insert(item: InvItem):
	var itemslots = slots.filter(func(slots): return slots.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
		emit_signal("update") 
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1 
			emit_signal("update")
		#print("Inventory full!")

func move(from_index: int, to_index: int):
	if from_index == to_index:
		return
	var from_slot = slots[from_index]
	var to_slot = slots[to_index]
	var temp_item = to_slot.item
	var temp_amount = to_slot.amount
	to_slot.item = from_slot.item
	to_slot.amount = from_slot.amount
	from_slot.item = temp_item
	from_slot.amount = temp_amount
	emit_signal("update")

func remove(index: int):
	slots[index].item = null
	slots[index].amount = 0
	emit_signal("update")
	
