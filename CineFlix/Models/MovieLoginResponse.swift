
struct MovieLoginResponse: Codable {
    struct Gravatar: Codable {
        let hash: String
    }

    struct TMDB: Codable {
        let avatarPath: String?

        enum CodingKeys: String, CodingKey {
            case avatarPath = "avatar_path"
        }
    }

    let gravatar: Gravatar
    let tmdb: TMDB

    enum CodingKeys: String, CodingKey {
        case gravatar, tmdb
    }
}

struct UserProfile: Codable {
    let avatar: MovieLoginResponse
    let id: Int
    let iso639_1: String
    let iso3166_1: String
    let name: String
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, username
    }
}

struct LogoutResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}


