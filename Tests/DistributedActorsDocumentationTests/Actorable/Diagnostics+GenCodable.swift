// ==== ------------------------------------------------------------------ ====
// === DO NOT EDIT: Generated by GenActors
// ==== ------------------------------------------------------------------ ====

import DistributedActors

// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: DO NOT EDIT: Codable conformance for GeneratedActor.Messages.Diagnostics
// TODO: This will not be required, once Swift synthesizes Codable conformances for enums with associated values

extension GeneratedActor.Messages.Diagnostics: Codable {
    // TODO: Check with Swift team which style of discriminator to aim for
    public enum DiscriminatorKeys: String, Decodable {
        case printDiagnostics
    }

    public enum CodingKeys: CodingKey {
        case _case
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(DiscriminatorKeys.self, forKey: CodingKeys._case) {
        case .printDiagnostics:
            self = .printDiagnostics
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .printDiagnostics:
            try container.encode(DiscriminatorKeys.printDiagnostics.rawValue, forKey: CodingKeys._case)
        }
    }
}
