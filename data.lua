-- data.lua
-- Part of disable-construction-robots Factorio mod, Johan Manske 2024-03-10
-- The data file is run on game startup, it defines the new prototypes we're using

-- disabledRoboport entity
local disabledRoboport = table.deepcopy(data.raw["roboport"]["roboport"])

disabledRoboport.name = "disabled-roboport"

-- disable the roboport construction by setting the construction radius to zero
disabledRoboport.construction_radius = 0
disabledRoboport.fast_replaceable_group = "roboports" -- for hotswapping inventories

-- Add a new layer to the base patch displaying a warning icon, very ass way to do this but couldnt find a way to add new warnings
disabledRoboport.base_patch = {
	layers = {{
      filename = "__base__/graphics/entity/roboport/roboport-base-patch.png",
      priority = "medium",
      width = 69,
      height = 50,
      frame_count = 1,
      shift = {0.03125, 0.203125},
      hr_version =
      {
        filename = "__base__/graphics/entity/roboport/hr-roboport-base-patch.png",
        priority = "medium",
        width = 138,
        height = 100,
        frame_count = 1,
        shift = util.by_pixel(1.5, 5),
        scale = 0.5
      }
    },
	{
		filename = "__disable-construction-robots__/graphics/warning_red.png",
		priority = "high",
		width = 64,
		height = 64,
		frame_count = 1,
		shift = util.by_pixel(0,15),
		scale = 0.5,
	}
}
}

-- item and recipe for testing purposes
-- disabledRoboport.minable.result = "my-item"
-- local myItem = table.deepcopy(data.raw["item"]["roboport"])
-- myItem.name = "my-item"
-- myItem.place_result = "disabled-roboport"
-- 
-- local recipe = {
 -- type = "recipe",
 -- name = "my-item",
 -- enabled = true,
 -- energy_required = 1,
 -- ingredients = {{"iron-plate", 1}},
 -- result = "my-item"
-- }


-- Define the control action and the shortcut to the action for restoring all roboports
local restoreRoboports = {
 type = "custom-input",
 name = "restore-roboports",
 key_sequence = "SHIFT+ALT+C",
 action = "lua",
}

local restoreRoboportsShortcut = {
 type = "shortcut",
 name = "restore-roboports",
 order = "a[disable]",
 action = restoreRoboports.action,
 associated_control_input = restoreRoboports.name,
 style = "default",
	icon = {
		filename = "__disable-construction-robots__/graphics/roboport_shortcut_32.png",
		priority = "extra-high-no-scale",
		size = 32,
		scale = 0.5,
		mipmap_count = 2,
		flags = {"gui-icon"}
	},
	small_icon = {
	 filename = "__disable-construction-robots__/graphics/roboport_shortcut_24.png",
	 priority = "extra-high-no-scale",
	 size = 24,
	 scale = 0.5,
	 mipmap_count = 2,
	 flags = {"gui-icon"}
	}
}

-- Define the selection tool, the control action to give a selection tool and the shortcut to that action

local disableRoboports = {
    type = "selection-tool",
    name = "disable-roboports",
    order = "c[automated-construction]-b[disable-roboports]",
    icons = {
     {icon = "__base__/graphics/icons/upgrade-planner.png", icon_size = 64, icon_mipmaps = 4},
        {icon = "__disable-construction-robots__/graphics/selection_tool_32.png", icon_size = 32, scale = 0.75},
    },
    flags = {"hidden", "not-stackable", "spawnable", "only-in-cursor"},
    subgroup = "other",
    stack_size = 1,
    selection_color = {71, 255, 73}, -- copied from upgrade-planner
    selection_cursor_box_type = "copy", -- copied from upgrade-planner
    selection_mode = {"nothing"},
    alt_selection_color = {239, 153, 34}, -- copied from upgrade-planner
    alt_selection_cursor_box_type = "copy", -- copied from upgrade-planner
    alt_selection_mode = {"nothing"},
}

local giveDisableRoboports = {
    type = "custom-input",
    name = "disable-roboports",
    key_sequence = "ALT + C",
    action = "spawn-item",
    item_to_spawn = "disable-roboports",
}

local giveDisableRoboportsShortcut = {
    type = "shortcut",
    name = "disable-roboports",
    order = "b[blueprints]-g[disable-roboports]",
    associated_control_input = giveDisableRoboports.name,
    action = giveDisableRoboports.action,
    item_to_spawn = giveDisableRoboports.item_to_spawn,
    style = "green",
    icon = {
        filename = "__disable-construction-robots__/graphics/selection_tool_32.png",
        priority = "extra-high-no-scale",
        size = 32,
        scale = 0.5,
        mipmap_count = 2,
        flags = {"gui-icon"}
    },
    small_icon = {
        filename = "__disable-construction-robots__/graphics/selection_tool_24.png",
        priority = "extra-high-no-scale",
        size = 24,
        scale = 0.5,
        mipmap_count = 2,
        flags = {"gui-icon"}
    }
}

data:extend{restoreRoboports, restoreRoboportsShortcut, disableRoboports, giveDisableRoboports, giveDisableRoboportsShortcut, disabledRoboport, myItem, recipe}
