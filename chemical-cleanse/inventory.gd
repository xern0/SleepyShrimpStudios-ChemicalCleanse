extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemlots = slots.filter(func(slot): return slot.item == item):
		if !itemslots.is_empty():
			itemslots[0].amount += 1 
