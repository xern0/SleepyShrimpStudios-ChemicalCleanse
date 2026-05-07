extends Panel

@onready var amount_label: Label = $AmountLabel
@onready var item_texture: TextureRect = $ItemTexture

func set_item(item: InvItem, amount: int):
	if item:
		item_texture.texture = item.texture
		amount_label.text = str(amount)
	else:
		item_texture.texture = null
		amount_label.text = ""
