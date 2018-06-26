import XCTest
@testable import AbilityKit


class AbilityKitManagerTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    
    func testRegisterAbility() {
        AbilityKitManager.sharedInstance.abilityProvider.fetchDefaultAbilities { (abilities) in
            for ability in abilities {
                AbilityKitManager.sharedInstance.abilityProvider.registerAbility(ability: ability)
            }
        }
        AbilityKitManager.sharedInstance.triggerReceived(triggerId: "G_SWIPE_IN") { (response, result) in
            
        }
    }
        
    
}

