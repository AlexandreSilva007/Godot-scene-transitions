![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)
# Title
Scene Transitions Manager for Godot Engine

## Description
Autoload class to manage scene transisitons between levels. 

## Install
Copy /autoload to your porject. In project settings add global_manager.gd as an autoload file. 

## Usage
Considering your autoload was named GlobalManager:
```
GlobalMananger.goto_scene(<levelinfo:LevelInfo>, <transition:String>)
```
transition is an optional parameter. Default is a simple fade in and out rectangle.
In this project there are another examples: sonic_like.tscn and hole.tscn

To implement a new transition, create a Control type scene that extends from SceneTransition (scene_transition.gd) and implements:
```
func get_animation_player()
```
- Returns the animationPlayer responsible for intro and out animations

```
func set_text(txt) - Optional. 
```
- The transition scene shows a text with the name of the level during transition.

## Contributing
---

## License
MIT © 2024 Alexandre Soares da Silva
