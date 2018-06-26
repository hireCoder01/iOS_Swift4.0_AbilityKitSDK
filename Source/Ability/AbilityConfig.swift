import Foundation

@objcMembers
public class ActiveConfiguration: NSObject, Codable {
    public var configKey: String?
    public var configs: [AbilityConfigurationItem]?
    
    public func toDictionary () -> [String : [Any]]? {
        var jsonArray = Array<Any> ()
        if let c = self.configs {
            for config in c {
                jsonArray.append(config.toDictionary())
            }
        }
        return [self.configKey! : jsonArray]
    }
    
    func configurationItem(forKey configKey: String) -> AbilityConfigurationItem? {
        let abilityConfigurationItem = (self.configs?.filter({$0.action_id == configKey}))?.first
        return abilityConfigurationItem
    }
}
