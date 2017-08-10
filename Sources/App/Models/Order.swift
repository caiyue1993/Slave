//
//  Order.swift
//  Slave
//
//  Created by 蔡越 on 11/07/2017.
//
//

import Vapor
import HTTP

struct Order {
    
    // 用户传过来的 json 数据
    let originJSON: JSON
    
    init(with json: JSON) {
        originJSON = json
    }
    
    func comply() -> String {
        
        let jsonArray = originJSON.wrapped
        
        switch jsonArray {
        case .object(let dict):
            
            let outputType = dict["outputLan"]?.string
            let variableCombines = dict["variableCombines"]?.object
            
            if let outputType = outputType, let variableCombines = variableCombines {
                if outputType == "Objective-C" {
                    
                    let properties = variableCombines.map({ (name: String, type: StructuredData) -> String in
                        return "@property (nonatomic, strong) " + type.description + " *" + name
                    }).reduce("", { (resultStr, str) -> String in
                        return resultStr + str + ";\n"
                    })
                    
                    let lazygetters = variableCombines.map({ (name: String, type: StructuredData) -> String in
                        return "- (\(type.description) *)\(name) { \n if (!_\(name)){\n\t_\(name)=[\(type.description) alloc] init];\n }\n\treturn _\(name);\n}"
                    }).reduce("", { (resultStr, str) -> String in
                        return resultStr + str + "\n"
                    })
                    
                    return properties + lazygetters
                    
                }
                if outputType == "Swift" {
                    let lazygetters = variableCombines.map({ (name: String, type: StructuredData) -> String in
                        return "lazy var " + name + ": \(type.description) = {\n let token = \(type.description)() \n return token\n }()"
                    }).reduce("", { (resultStr, str) -> String in
                        return resultStr + str + "\n"
                    })
                    return lazygetters
                }
            }
            
            default:
            break
        }
        
        return ""
    }
    
}


