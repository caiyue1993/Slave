import Vapor
import LeafProvider

extension Droplet {
    func setupRoutes() throws {
        
        // for debug use
        get("info") { req in
            return req.description
        }
        
        // Comply with the order that customer wants
        post("v1/order") { request in
            guard let json = request.json else {
                throw Abort(.badRequest)
            }
            
//            guard let bar = request.json?["foo"]?.string else {
//                throw Abort(.badRequest)
//            }
            return Order(with: json).comply()
        }
        
//        try resource("posts", PostController.self)
//        try resource("v1/order", OrderController.self)
    }
}
