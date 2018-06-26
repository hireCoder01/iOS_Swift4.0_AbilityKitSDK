import Foundation

@objcMembers
open class Ability : NSObject {
  public override init () {}
  public var ability_name: String?
  public var ability_id: String!
  public var ability_category: String?
  public var ability_desc: String?
  public var ability_icon: String?
  public var ability_action: String?
  public var ability_trigger: [String]?
  public var ability_configuration: [AbilityConfiguration]?
  public var abilityExecutor: AbilityExecutor?
}



open class AbilityConfiguration : NSObject, Codable {
  public override init() {}
  public var action_key: String?
  public var config_type: String?
  public var config_api: String?
  public var config_data: [AbilityConfigurationItem]?
}

@objcMembers
open class AbilityConfigurationItem : NSObject, Codable {
  public override init() {}
  public var action_id: String?
  public var item_name: String?
  public var item_value: String?
  public var item_icon: String?
  public var item_icon_highlited: String?
  
  func toDictionary() -> [String : String] {
    var dict: [String : String] = Dictionary()
    dict["actionId"] = self.action_id
    dict["configValue"] = self.item_value
    dict["configName"] = self.item_name
    dict["item_icon"] = self.item_icon
    dict["item_icon_highlited"] = self.item_icon_highlited
    return dict;
  }
}

@objcMembers
public class Configuration: NSObject, Codable {
  public var actionId: String = ""
  public var configName: String = ""
  public var configValue: String = ""
}
