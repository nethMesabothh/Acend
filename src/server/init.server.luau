--!nonstrict
-- Requires every service in Services and starts it. Add a new gameplay
-- system by dropping a ModuleScript in Services with an optional Start().

local Services = script.Services

for _, moduleScript in Services:GetChildren() do
	if moduleScript:IsA("ModuleScript") then
		local service = require(moduleScript)
		if type(service) == "table" and typeof(service.Start) == "function" then
			service.Start()
		end
	end
end

print("Server bootstrapped.")
