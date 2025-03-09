class_name HitBox extends Area2D

@export var is_enemy: bool = false
@export var parent_entity: CharacterBody2D

func on_hit(hit_source: Area2D) -> void:
	if hit_source is HitSource and hit_source.is_enemy != self.is_enemy:
		parent_entity.call_deferred("decrease_health", hit_source.damage)
