import Foundation

/*
 Basic idea for interacting with sdk.
 - This is the public class that is going to provide ability related operations.
 - Fetching abilities from JAB(Still need to discuss).
 - Assign ability against the trigger.
 - Ability execution on triggering.
 */

@objcMembers public class AbilityKitManager: NSObject {
    
    public static let sharedInstance = AbilityKitManager()
    let triggerHandler = TriggerHandler()
    let abilityHandler = AbilityHandler()
    let recipeHandler = RecipeHandler()
    let configurationHandler = ConfigurationHandler()
    let executionManager = AbilityExecutionManager()
    var dataHandler:DataHandlerServices? = nil
    /**
     * @method      - fetchDefaultAbilities:
     * @brief       - Retrive all the Defaults abilities Provided by the SDK.
     */
    public func fetchDefaultAbilities(abilityResponse: (_ abilities : ([Ability])?, _ error : Error?) -> Void) {
        abilityHandler.fetchDefaultAbilities { (abilities) in
            abilityResponse(abilities, nil)
        }
    }
    
    /**
     * @method      - registerAbility:
     * @brief       - Register any Ability in List of Supported Ability.
     */
    public func registerAbility(ability: Ability) {
        abilityHandler.registerAbility(ability: ability)
    }
    
    
    /**
     * @method      - fetchAllRegisteredAbilities:
     * @brief       - Retrive list of all Registered (Active) abilities.
     */
    public func fetchAllRegisteredAbilities(abilityResponse: (_ abilities : ([Ability])?, _ error : Error?) -> Void) {
        abilityHandler.fetchAbilities { (abilities, error) in
            abilityResponse(abilities, error)
        }
        
    }
    
    /**
     * @method      - fetchAllTriggers:
     * @brief       - Provide list of all Registered triggers (Defaults + Custom)
     */
    public func fetchAllTriggers(triggerResponse: (_ triggers : ([Trigger])?, _ error : Error?) -> Void) {
        triggerHandler.fetchTriggers { (triggers, error) in
            triggerResponse(triggers, error)
        }
        
    }
    
    
    /**
     * @method      - assignAbility:
     * @brief       - Assign an ability against the trigger.
     */
    public func assignAbility(ability: Ability, trigger: Trigger, configuration : ActiveConfiguration?) {
        recipeHandler.assignAbility(ability: ability, trigger: trigger, configuration: configuration)
    }
    
    /**
     * @method      - assignAbility:
     * @brief       - Assign an ability against the trigger.
     */
    public func unAssignAbility(trigger: Trigger) {
        recipeHandler.removeRecipe(forTrigger: trigger)
    }
    
    /**
     * @method      - fetchAllRecipes:
     * @brief       - Get All saved recipes
     */
    public func fetchAllRecipes(recipeResponse: @escaping (_ recipes : ([Recipe])?, _ error : Error?) -> Void) {
        recipeHandler.fetchAllRecipes { (recipes, error) in
            recipeResponse(recipes,error)
        }
    }
    
    /**
     * @method      - saveAbilityConfiguration:
     * @brief       - Set configuration against the ability.
     */
    public func saveAbilityConfiguration(abilityConfig: ActiveConfiguration?) {
        configurationHandler.saveConfiguration(configuration: abilityConfig!)
    }
    
    /**
     * @method      - fetchAbilityConfiguration:
     * @brief       - Get configuration against the ability.
     */
    public func fetchActiveAbilityConfiguration(ability: Ability, trigger: Trigger) -> ActiveConfiguration?{
        return configurationHandler.retrieveActiveConfiguration(ability: ability, trigger: trigger)
    }
    
    /**
     * @method      - fetchAssignedAbilityIDFor:
     * @brief       - Get Assigned Ability to trigeer if Any
     */
    public func fetchAssignedAbilityIDFor(trigger: Trigger) -> String? {
        return recipeHandler.fetchAssignedAbilityID(forTrigger: trigger)
    }
    
    /**
     * @method      - triggerReceived:
     * @brief       - Perform ability execution, if it is assigned against any trigger.
     */
    public func triggerReceived(triggerId: String, completion: AbilityResponse) {
        executionManager.triggerReceived(triggerUUID: triggerId,completion: completion)
    }
    
    /**
     * @method      - setDataProvider:
     * @brief       - Sets DataProvider which will source of data
     */
    public func setDataProvider (provider: DataHandlerServices) {
        self.dataHandler = provider
    }
    
    /**
     * @method      - speak:
     * @brief       - Utility Method to speak
     */
    public func speak(phrase: String) {
        SpeechComponent.shared().speak(phrase: phrase)
    }
    
}
