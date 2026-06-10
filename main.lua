local me_controller = peripheral.wrap("right")

local autocrafts = {
	{
		name = "minecraft:iron_ingot",
		count = 218,
		fluid = false,
	},
}

for i, v in pairs(autocrafts) do
	if not v.fluid then
		local item_info = me_controller.getItem({ name = v.name })
		if not (item_info or item_info.isCraftabile) then
			print("Cannot craft " .. v.name .. " because it has no pattern.")
			goto continue
		end

		local item_count = item_info.amount

		if item_count < v.count and not me_controller.isItemCrafting({ name = v.name }) then
			local success, err = me_controller.craftItem({ name = v.name, count = v.count - item_count })

			if not success then
				print("Failed to craft " .. v.name .. ": " .. err)
			else
				print("Beginning craft for " .. v.name)
			end
		end
	end
	::continue::
end
sleep(0.5)
