import Foundation

class AbilityExecutionManager {
    
    func triggerReceived(triggerUUID: String, completion: AbilityResponse) {
        let recipeObject = AbilityKitManager.sharedInstance.recipeHandler.fetchRecipeForTrigger(forTriggerId: triggerUUID)
        guard let recipe = recipeObject else {
            return
        }
        let configKey = "\(triggerUUID)_\(recipe.abilityId!)"
        print(configKey)
        let userconfiguration = AbilityKitManager.sharedInstance.configurationHandler.retrieveActiveConfiguration(configKey: configKey)
        let abilityDetail = AbilityDetails(abilityId: recipe.abilityId, abilityConfiguration: userconfiguration)
        guard let ability = AbilityKitManager.sharedInstance.abilityHandler.fetchAbilityForAbilityId(forId: recipe.abilityId) else{
            return
        }
        ability.abilityExecutor?.execute(withDetails: abilityDetail,  completion: completion)
    }
    
    func triggerAbilityWithoutConfiguration(ability: Ability) {
    }
}
