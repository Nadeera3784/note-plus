import Foundation

struct Note: Identifiable, Equatable, Codable{
    var id = UUID()
    var title: String
    var description: String
    var createdDate: Date
}
