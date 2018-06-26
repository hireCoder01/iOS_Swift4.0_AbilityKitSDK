import Foundation
class TimeExecutor: AbilityExecutor {
    
    private let keyCurrentTimeConfigIncludeDate = "is_include_date"
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEELLLLdd"
        formatter.locale = Locale.current
        return formatter
    }()
    
    init() {}
    
    func execute(withDetails details: AbilityDetails, completion: (JacquardResponse<String>, AbilityExecutorResult) -> Void) {
        print("time executor")
      
        guard let _ = details.abilityConfiguration, let includeDate = details.abilityConfiguration?.configurationItem(forKey: keyCurrentTimeConfigIncludeDate)?.item_value else {
            print("no config found")
            return
        }
        
        let now = Date()
        let timeString = DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .short)
        var fullString: String!
        if includeDate == "yes" {
            let dateString: String = TimeExecutor.formatter.string(from: now)
            fullString = "It is \(timeString) on \(dateString)"
        } else {
            fullString = "It is \(timeString)"
        }
        SpeechComponent.shared().speak(phrase: fullString)
        print("Current Time is ==== \(fullString)")
        
    }
}
  

