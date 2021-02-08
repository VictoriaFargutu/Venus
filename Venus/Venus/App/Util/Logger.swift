//
//  Logger.swift
//  Venus
//
//  Created by Victoria Fargutu on 08.02.2021.
//

import Foundation

public final class Logger {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSS"
        return formatter
    }()
    
    private init() {}
    
    private static var time: String {
        return Logger.formatter.string(from: Date())
    }
    
    public static func debug(tag: String, message: String) {
        print("\(time) D/\(tag): \(message)")
    }
    
}
