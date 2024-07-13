class_name SkillSaver
extends Node



func save_player_states():
	var saved_game:SkillData = SkillData.new()
	saved_game.skills = PlayerStats.skills
	ResourceSaver.save(saved_game, "user://savegame4.tres")
