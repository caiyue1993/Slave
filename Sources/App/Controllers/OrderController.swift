//
//  File.swift
//  Slave
//
//  Created by 蔡越 on 11/07/2017.
//
//

import Vapor
import HTTP

final class OrderController {
    
}

/// Since OrderController doesn't require anything to
/// be initialized we can conform it to EmptyInitializable.
///
/// This will allow it to be passed by type.
extension OrderController: EmptyInitializable { }
