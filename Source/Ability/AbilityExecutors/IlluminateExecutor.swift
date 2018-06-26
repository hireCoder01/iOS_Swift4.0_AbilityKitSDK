import Foundation

private let illuminate_config_id = "illuminate_light_id"
private let duration = 30

class IlluminateExecutor: AbilityExecutor {
    init() {}
    
    func execute(withDetails details: AbilityDetails, completion: (JacquardResponse<String>, AbilityExecutorResult) -> Void) {
        guard let _ = details.abilityConfiguration, let garmentOutputPattern = details.abilityConfiguration?.configurationItem(forKey: illuminate_config_id)?.item_value else {
            print("no config found")
            return
        }
        SpeechComponent.shared().speak(phrase: "Playing pattern \(garmentOutputPattern)")
        return
       
    }
}
