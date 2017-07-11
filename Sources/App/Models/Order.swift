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
    
    let originJSON: JSON
    
    init(with json: JSON) {
        originJSON = json
    }
    
    func comply() -> String {
        let result = "this is what I have done"
        return result
    }
    
}
