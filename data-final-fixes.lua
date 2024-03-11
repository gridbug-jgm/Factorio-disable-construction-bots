-- data-final-fixes.lua
-- Part of disable-construction-robots Factorio mod, Johan Manske 2024-03-10
-- The data-final-fixes file is run LAST on game startup, we use this to alter base game prototypes

-- add a fast replace group to roboports
data.raw["roboport"]["roboport"].fast_replaceable_group = "roboports"
