extends RichTextLabel

#const title_pattern = "title"
#const title_template = "[b][color=teal][url]title[/url][/color][/b]"
const lore_pattern = "lore"
const meta_template = "[b][color=green][url]lore[/url][/color][/b]"
const stat_pattern = "stat"
const stat_template = "[b][color=orange]stat[/color][/b]"

@export var quest:Quest
var lores:Array[Lore]

func set_quest(quest: Quest):
	lores.clear()
	self.quest = quest
	clear()
	add_lore_text(quest.lore)

func add_lore_text(lore:Lore):
	lores.append(lore)
	var richtext = lore.text
	for s in ItemStats.Stat:
		s = s.replace("_", " ")
		richtext = richtext.replacen(s, stat_template.replace(stat_pattern, s))
	for sub in lore.get_children():
		richtext = richtext.replace(sub.name, meta_template.replace(lore_pattern, sub.name))
		lores.append(sub)
	append_text(richtext)

func _on_meta_clicked(meta):
	for l in lores:
		var n = l.name
		if l.name == meta:
			append_text("\n")
			add_lore_text(l)
			break
