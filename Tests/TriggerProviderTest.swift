import XCTest
@testable import AbilityKit


class TriggerProviderTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testTriggerLoad() {
        let triggerProvider = TriggerProvider()
        triggerProvider.fetchTriggers { (triggers, error) in
            guard let triggerResponse = triggers else {
                XCTAssert(false, "Failed to load trigger ")
                return
            }
            if triggerResponse.count == 0 {
                XCTAssert(false, "Failed to load trigger ")
            }
            
        }
    }
}
