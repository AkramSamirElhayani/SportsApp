 
import Foundation

// MARK: - Leagues
struct Leagues: Codable {
    let leagues: [League]

    enum CodingKeys: String, CodingKey {
        case leagues
    }
}

// MARK: Leagues convenience initializers and mutators

extension Leagues {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Leagues.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        leagues: [League]? = nil
    ) -> Leagues {
        return Leagues(
            leagues: leagues ?? self.leagues
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - League
struct League: Codable {
    let idLeague: String
    let strLeague: String
    let strSport: String
    let strLeagueAlternate: String?

    enum CodingKeys: String, CodingKey {
        case idLeague
        case strLeague
        case strSport
        case strLeagueAlternate
    }
}

// MARK: League convenience initializers and mutators

extension League {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(League.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        idLeague: String? = nil,
        strLeague: String? = nil,
        strSport: String? = nil,
        strLeagueAlternate: String?? = nil
    ) -> League {
        return League(
            idLeague: idLeague ?? self.idLeague,
            strLeague: strLeague ?? self.strLeague,
            strSport: strSport ?? self.strSport,
            strLeagueAlternate: strLeagueAlternate ?? self.strLeagueAlternate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

 
