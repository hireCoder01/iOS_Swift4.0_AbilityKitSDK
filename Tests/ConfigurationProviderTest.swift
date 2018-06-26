import XCTest
@testable import AbilityKit

class ConfigurationProviderTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testConfigSaving()  {
        let configProvider = ConfigurationProvider()
        let abilityConfig = UserConfiguration.init()
        abilityConfig.key = "illuminate_light_id"
        abilityConfig.value = "illuminate_blink"
        abilityConfig.isPII = false
        configProvider.saveConfig(configKey: "G_SWIPE_IN-1P_ILLUMINATE", config: [abilityConfig])
    }
    
    func testConfigRetrieval() {
        let configProvider = ConfigurationProvider()
        let config = configProvider.retrieveConfig(configKey: "G_SWIPE_IN-1P_ILLUMINATE")
        XCTAssertNotNil(config, "Config found")
    }
    
    func testTriggerReceived () {
        let trigger = "JQG_SWIPE_IN"
        AbilityKitManager.sharedInstance.triggerReceived(triggerId: trigger) { (reposne, result) in
            
        }
    }
   
}
