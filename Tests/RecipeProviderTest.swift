import XCTest
@testable import AbilityKit

class RecipeProviderTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testRecipeCreation()  {
        let recipeProvider = RecipeProvider()
        recipeProvider.createRecipe(abilityId: "1P_ILLUMINATE", triggerId: "G_SWIPE_IN") { (isAbilityAssigned) in
            XCTAssertTrue(isAbilityAssigned)
        }
    }
    
    func testRecipeRetrieval() {
        let recipeProvider = RecipeProvider()
        let recipe = recipeProvider.fetchRecipeForTrigger(triggerUUID: "JQG_SWIPE_IN")!
        XCTAssertNotNil(recipe, "Recipe found")
    }
    
    func testFetchRecipes() {
        let recipeProvider = RecipeProvider()
        recipeProvider.fetchAllRecipes { (recipes, error) in
            XCTAssertNotNil(recipes, "Recipe found")
        }
        
    }
 
}
