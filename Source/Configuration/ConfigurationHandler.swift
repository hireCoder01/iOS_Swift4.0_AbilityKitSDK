import Foundation

class ConfigurationHandler {
    
    func saveConfiguration(configuration: ActiveConfiguration) {
        AbilityKitManager.sharedInstance.dataHandler?.saveAbility(configuration: configuration)
    }
    
    func retrieveActiveConfiguration(configKey: String) -> ActiveConfiguration? {
        let dataHandler = AbilityKitManager.sharedInstance.dataHandler
        return dataHandler?.fetchConfigurationForKey(configurationKey: configKey)
    }
    
    func retrieveActiveConfiguration(ability: Ability, trigger: Trigger) -> ActiveConfiguration? {
        let configKey = "\(trigger.triggerId!)_\(ability.ability_id!)"
        print("retrieveActiveConfiguration \(configKey)")
        return retrieveActiveConfiguration(configKey: configKey)
    }
    
}
