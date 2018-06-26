import Foundation

class AbilityIlluminate: Ability {
       override init() {
        super.init()
        self.ability_id = "1P_ILLUMINATE"
        self.ability_name = "ILLUMINATE"
        self.ability_icon = "icnIlluminate"
        self.ability_desc = "Turn the Jacquard snap tag light on for a moment. Continued use of Illuminate may dramatically decrease snap tag battery life."
        self.ability_category = "Expression"
        self.ability_configuration = self.createIlluminateConfiguration()
        self.abilityExecutor = IlluminateExecutor.init()
    }
    func createIlluminateConfiguration() -> [AbilityConfiguration] {
        let illuminateConfiguration = AbilityConfiguration()
        var configItems = [AbilityConfigurationItem]()
        illuminateConfiguration.action_key = "illuminate_light_id"
        illuminateConfiguration.config_type = "multiple"
        illuminateConfiguration.config_api = ""

        let strobeConfig = AbilityConfigurationItem()
        strobeConfig.item_name = "Strobe"
        strobeConfig.item_value = "32"
        strobeConfig.item_icon = "icnStrobe"
        strobeConfig.item_icon_highlited = "icnStrobeSelected"
        configItems.append(strobeConfig)
        
        let constantConfig = AbilityConfigurationItem()
        constantConfig.item_name = "Constant"
        constantConfig.item_value = "33"
        constantConfig.item_icon = "icnConstant"
        constantConfig.item_icon_highlited = "icnConstantSelected"
        configItems.append(constantConfig)
        
        let celebrationConfig = AbilityConfigurationItem()
        celebrationConfig.item_name = "Celebration"
        celebrationConfig.item_value = "34"
        celebrationConfig.item_icon = "icnCelebration"
        celebrationConfig.item_icon_highlited = "icnCelebrationSelected"
        configItems.append(celebrationConfig)
        
        illuminateConfiguration.config_data = configItems
        
        return [illuminateConfiguration]
    }
}
