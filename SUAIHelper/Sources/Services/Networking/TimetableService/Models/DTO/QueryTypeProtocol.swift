import Foundation

protocol QueryType: Sendable {
    init(id: Int, name: String)
    var id: Int { get }
    var name: String { get }
}
