import Foundation
open class DataHandlerServices {
    public init() {
        
    }
    open func fetchAllRecipes(completion: @escaping (([Recipe])?, Error?) -> Void) {
        print("fetch recipe in DataHandler")
    }
    
    open func saveRecipe(withRecipe recipe: Recipe) {
        
    }
    
    open func deleteRecipe(trigggerId: String) {
        
    }
    
    open func updateRecipe(newRecipe: Recipe) {
        
    }
    
    open func fetchRecipeForTrigger(triggerUUID: String) -> Recipe? {
        return nil
    }
    
    open func fetchConfigurationForKey(configurationKey: String) -> ActiveConfiguration? {
        return nil
    }
    
    open func saveAbility(configuration: ActiveConfiguration)  {
    }
}
