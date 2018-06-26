import Foundation

class AbilityTime: Ability {
    override init() {
        super.init()
        self.ability_id = "1P_TIME"
        self.ability_name = "TIME"
        self.ability_icon = "icnCurrentTime"
        self.ability_desc = "Hear a read out of the current time."
        self.ability_category = "Keep Track"
        self.ability_configuration = createTimeConfiguration()
        self.abilityExecutor = TimeExecutor.init()
    }
    
    func createTimeConfiguration() -> [AbilityConfiguration] {
        let timeConfiguration = AbilityConfiguration()
        var configItems = [AbilityConfigurationItem]()
        timeConfiguration.action_key = "is_include_date"
        timeConfiguration.config_type = "multiple"
        timeConfiguration.config_api = ""
        
        let includeDateConfigurationItem  = AbilityConfigurationItem()
        includeDateConfigurationItem.item_name = "Yes"
        includeDateConfigurationItem.item_value = "yes"
        includeDateConfigurationItem.item_icon = "icnDateYes"
        includeDateConfigurationItem.item_icon_highlited = "icnDateYesSelected"
        configItems.append(includeDateConfigurationItem)
        
        let dontIncludeDateConfigurationItem  = AbilityConfigurationItem()
        dontIncludeDateConfigurationItem.item_name = "No"
        dontIncludeDateConfigurationItem.item_value = "no"
        dontIncludeDateConfigurationItem.item_icon = "icnDateNo"
        dontIncludeDateConfigurationItem.item_icon_highlited = "icnDateNoSelected"
        configItems.append(dontIncludeDateConfigurationItem)

        
        timeConfiguration.config_data = configItems
        
        return [timeConfiguration]
    }
}
