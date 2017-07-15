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
            func string(forKey key: String) -> String? {
                //if let string = request.query?[key]?.string {
                if let string = request.data[key]?.string {
                    return string.isEmpty ? nil : string
                } else {
                    return nil
                }
            }
            
            let variableName = string(forKey: "variableName") ?? ""
            let variableType = string(forKey: "variableType") ?? ""
            var json = JSON()
            try json.set(variableName, variableType)
            
            return Order(with: json).comply()
            
        }
        
    }
}
