import Foundation
open class Recipe: Codable {
    public init () {}
    public var abilityId: String!
    public var evevtUUID: String!
    public var sourceType: String?
    
    public func toDictionary() -> [String : String] {
        var dict: [String : String] = Dictionary()
        dict["abilityId"] = self.abilityId
        dict["evevtUUID"] = self.evevtUUID
        dict["sourceType"] = self.sourceType
        return dict
    }
}
