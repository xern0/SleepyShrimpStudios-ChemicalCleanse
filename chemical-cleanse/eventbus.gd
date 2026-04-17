extends Node

signal item_equipped(item)
var current_item = null

func equip(item):
	current_item = item
	item_equipped.emit(item)
