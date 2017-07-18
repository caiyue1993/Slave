import Vapor
import LeafProvider

extension Droplet {
    func setupRoutes() throws {
        
        // for debug use
        get("info") { req in
            return req.description
        }
        
        get("/") { req in
            return try self.view.make("base", [
                    "name": "hello"
                ])
        }
        
        // Comply with the order that customer wants
        post("v1/order") { request in
            return try index(request: request)
        }
        
        func index(request: Request) throws -> ResponseRepresentable {
            if let json = request.json {
                return Order(with: json).comply()
            } else {
                return Abort(.badRequest)
            }
        }
        
    }
}
