import Vapor
import LeafProvider

extension Droplet {
    func setupRoutes() throws {
        
        // for debug use
        get("info") { req in
            return req.description
        }
        
        try resource("posts", PostController.self)
    }
}
