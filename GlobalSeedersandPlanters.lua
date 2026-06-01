-- Create a table for mod's functions
GlobalSeederPatch = {}

function GlobalSeederPatch:injectCategories(...)
    -- The game categories to expand
    local targetCategories = {
        "SOWINGMACHINE", 
        "PLANTER", 
        "PLANTER_SMALL", 
        "SUGARCANE_PLANTER"
    }
    
    local injectedCount = 0

    -- Loop through all fruit types the map just registered
    for index, fruitType in pairs(self.fruitTypes) do
        
        -- Check if the crop is actually designed to be planted/sown
        if fruitType.allowsSeeding then
            
            for _, categoryName in ipairs(targetCategories) do
                self:addFruitTypeToCategory(fruitType.index, categoryName)
            end
            injectedCount = injectedCount + 1
            
        end
    end
    
    print(string.format("[GlobalSeederPatch] Successfully injected %d plantable fruits into all seeder categories.", injectedCount))
end

-- Hook into the Giants Engine
FruitTypeManager.loadFruitTypes = Utils.appendedFunction(FruitTypeManager.loadFruitTypes, GlobalSeederPatch.injectCategories)