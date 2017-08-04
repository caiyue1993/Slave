import Vapor
import LeafProvider

extension Droplet {
    func setupRoutes() throws {
        
        // For debug use
        get("info") { req in
            return req.description
        }
        
        get("/") { req in
            return try self.view.make("base")
        }
        
        // Comply with the order that customer wants
        post("v1/order") { [weak self] request in
            guard let welf = self else { return ""}
            return try welf.index(request: request)
        }
    }
}

extension Droplet {
    func index(request: Request) throws -> ResponseRepresentable {
        if let json = request.json {
            return Order(with: json).comply()
        } else {
            return ""
        }
    }
}
