![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)
# 2D Scene Transition Manager for Godot Engine

## Description
Autoload class to manage scene transitions between levels. 

## Install
Copy /autoload to your project. In project settings add global_manager.gd as an autoload file. 

## Usage
Considering your autoload was named GlobalManager:
```
GlobalMananger.goto_scene(<level_info_name>, <transition:String>)
```
level_info_name is a name of a map entry of a LevelInfo resource type, a Resource under utility folder. It encapsulates level atributes like PackedScene path, level name, complete, etc. It can be freely cusmomized.
transition is an optional parameter. Default is a simple fade in and out rectangle.
In this project there are another examples: sonic_like.tscn and hole.tscn.

To implement a new transition, create a Control type scene that extends from SceneTransition (scene_transition.gd) and implements:
```
func get_animation_player()
```
- Returns the animationPlayer responsible for intro and out animations

```
func set_text(txt)  
```
Optional - The transition scene shows a text with the name of the level during transition.

## Contributing
PRs accepted.

## License
MIT © Alexandre Soares da Silva

https://github.com/AlexandreSilva007/Godot-scene-transitions/tree/main?tab=MIT-1-ov-file#readme
