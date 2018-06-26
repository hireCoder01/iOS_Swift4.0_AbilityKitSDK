import XCTest
@testable import AbilityKit


class AbilityProviderTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAbilityLoad() {
        let abilityProvider = AbilityProvider()
        abilityProvider.fetchAbilities { (abilities, error) in
            guard let abilityResponse = abilities else {
                XCTAssert(false, "Failed to load abilities ")
                return
            }
            if abilityResponse.count == 0 {
                XCTAssert(false, "Failed to load abilities ")
            }
        }
    }
}
