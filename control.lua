--control.lua
-- Part of disable-construction-robots Factorio mod, Johan Manske 2024-03-10
-- The control file handles events during runtime

function disable_roboports_in_area(force, surface, area)
  local roboports = surface.find_entities_filtered {
    area = area,
    force = force,
    type = "roboport",
	name = "roboport"
  }

  for _, entity in pairs(roboports) do
	  entity.surface.create_entity{name="disabled-roboport",position=entity.position,force=entity.force, fast_replace=true}

  end

  return #roboports
end

function restore_roboports(force, surface)
	local disabled_roboports = surface.find_entities_filtered {
		force = force,
		type = "roboport",
		name = "disabled-roboport"
	}
	for _, entity in pairs(disabled_roboports) do
		entity.surface.create_entity{name="roboport",position=entity.position,force=entity.force, fast_replace=true}
	end

	return #disabled_roboports
end

script.on_event(defines.events.on_player_selected_area,
  function(event)
    if event.item == "disable-roboports" then
      local player = game.get_player(event.player_index)
	  local n = disable_roboports_in_area(player.force, event.surface, event.area) 
      if n > 0 then
        player.play_sound { path = "utility/upgrade_selection_ended" }
		player.print(string.format("Disabled construction for %d roboports",n))
      end
    end
  end
)

script.on_event("restore-roboports",
	function(event)
		local player = game.get_player(event.player_index)
		local n = restore_roboports(player.force, player.surface)
		  if n > 0 then
			player.play_sound { path = "utility/upgrade_selection_ended" }
			player.print(string.format("Restored construction for %d roboports",n))
		  end
	end
	)

script.on_event(defines.events.on_lua_shortcut,
  function(event)
    if (event.prototype_name == "restore-roboports") then
		local player = game.get_player(event.player_index)
		local n = restore_roboports(player.force, player.surface) 
		if n > 0 then
			player.play_sound { path = "utility/upgrade_selection_ended" }
			player.print(string.format("Restored construction for %d roboports",n))
		  end
    end
  end
)

