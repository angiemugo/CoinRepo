//
//  Environment.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

import Foundation

typealias DebugEnvironment = CoinAppEnvironment

struct CoinAppEnvironment {
    static var log = Logger(handler: PrintLogHandler(), level: .info)
    static var logHandler: LoggerHandler {
        get { log.handler }
        set { log.handler = newValue }
    }
    
    static var logLevel: LogLevel {
        get { log.level }
        set { log.level = newValue }
    }
}
