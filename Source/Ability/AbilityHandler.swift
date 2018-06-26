import Foundation

class AbilityHandler {
    private static var registeredAbilities = [Ability]()
   
    func fetchAbilities(forCompletiton completion: (([Ability])?, Error?) -> Void) {
        completion(AbilityHandler.registeredAbilities, nil)
    }
    
    func fetchDefaultAbilities(forCompletiton completion: ([Ability]) -> Void) {
        let illuminateAbility = AbilityIlluminate.init()
        let timeAbility = AbilityTime.init()
        completion([illuminateAbility, timeAbility])
    }
    
    func registerAbility(ability: Ability) {
        AbilityHandler.registeredAbilities.append(ability)
    }
    
    func fetchAbilityForAbilityId(forId abilityId: String) -> Ability? {
        let ability = (AbilityHandler.registeredAbilities.filter({$0.ability_id == abilityId})).first
        return ability
    }
    
}
