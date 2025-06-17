extends GridContainer
class_name WordBottomPanel

var entry_map = {}

func add_entry(id: int, entry: WordEntry) -> void:
	entry_map[id] = entry

func get_entry(id: int) -> WordEntry:
	return entry_map.get(id)
