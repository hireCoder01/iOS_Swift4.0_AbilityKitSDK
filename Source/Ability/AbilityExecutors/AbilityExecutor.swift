import Foundation
public typealias AbilityResponse = (_ response: JacquardResponse <String>, _ executorResult: AbilityExecutorResult) -> Void

public protocol AbilityExecutor: class {
    func execute(withDetails details: AbilityDetails, completion: AbilityResponse)
}

public protocol AbilityExecutorResult {
    var isRunning: Bool { get }
    var status: AbilityExecutorStatus { get }
    func pause()
    func resume()
    func stop()
}

public enum JacquardResponse <T> {
    case success(T)
    case error(Error)
}

public enum AbilityError: Error {
    case notConfigured
}

public struct AbilityDetails {
    public let abilityId: String!
    public var abilityConfiguration: ActiveConfiguration?
}

public enum AbilityExecutorStatus {
    case stopped, running, failed
}
