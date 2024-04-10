1.12.1 addon that adds 4 customizable weapon wheels aka dynamic selection wheels aka radial menus.

Bind the 4 wheels in the keybinds menu.
/weaponwheel for settings

Each wheel has 5 slots: 4 directional, 1 center. Every slot's action & icon can be edited independantly by rightclick or leftclick correspondingly.

How to use:
- Hold a wheel's keybind to show the wheel. While holding, right click one of the 4 directional slots or the middle slot to open an editbox. Write lua code that you want to execute into that editbox (addon format NOT macro format, [for example](https://github.com/balakethelock/WeaponWheel/assets/111737968/62cb00d4-0082-46c1-a0ee-1c483d726596)). Press escape to save to that slot.
- Next time you press that wheel's keybind, you can point your mouse in the direction of that slot & release the key to use the corresponding action.
- You can left click one of the 4 side slots to copy it to the center slot -"the quick use" slot- (the one that is used immediately if press the keybind without holding it down)
- Slots automatically grab spells icon, you can overwrite that by left clicking one of the 5 icons & pasting a texture name that you can get online.
