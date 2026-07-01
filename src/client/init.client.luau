--!nonstrict
-- Requires every controller in Controllers and starts it. Add a new client
-- system by dropping a ModuleScript in Controllers with an optional Start().

local Controllers = script.Controllers

for _, moduleScript in Controllers:GetChildren() do
	if moduleScript:IsA("ModuleScript") then
		local controller = require(moduleScript)
		if type(controller) == "table" and typeof(controller.Start) == "function" then
			controller.Start()
		end
	end
end

print("Client bootstrapped.")
