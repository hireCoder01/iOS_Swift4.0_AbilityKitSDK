import Foundation
typealias RecipeResponse = (_ recipes : ([Recipe])?, _ error : Error?) -> Void

class RecipeHandler: RecipeHandlerProtocol {
    
    func fetchAllRecipes(completion: @escaping RecipeResponse) {
        let dataHandler = AbilityKitManager.sharedInstance.dataHandler
        dataHandler?.fetchAllRecipes(completion: { (recips, error) in
            completion(recips,error)
        })
    }
    
    func fetchRecipeForTrigger(forTriggerId triggerUUID: String) -> Recipe? {
        let dataHandler = AbilityKitManager.sharedInstance.dataHandler
        return dataHandler?.fetchRecipeForTrigger(triggerUUID: triggerUUID)
    }
    
    func createRecipe(forId ability: Ability, trigger:Trigger) {
        let dataHandler = AbilityKitManager.sharedInstance.dataHandler
        let newRecipe = Recipe()
        newRecipe.evevtUUID = trigger.triggerId
        newRecipe.abilityId = ability.ability_id
        newRecipe.sourceType = trigger.triggerType
        dataHandler?.saveRecipe(withRecipe: newRecipe)
    }
    
    func assignAbility(ability: Ability, trigger:Trigger, configuration: ActiveConfiguration?) {
        createRecipe(forId: ability, trigger: trigger)
        guard let activeConfiguration = configuration else {
            return
        }
        AbilityKitManager.sharedInstance.configurationHandler.saveConfiguration(configuration: activeConfiguration)
    }
    
    func removeRecipe(forTrigger trigger: Trigger)  {
        let dataHandler = AbilityKitManager.sharedInstance.dataHandler
        dataHandler?.deleteRecipe(trigggerId: trigger.triggerId)
    }
    
    func fetchAssignedAbilityID(forTrigger trigger: Trigger) -> String? {
        if let recipe = fetchRecipeForTrigger(forTriggerId: trigger.triggerId) {
            return recipe.abilityId
        }
        return nil
    }

}
 
