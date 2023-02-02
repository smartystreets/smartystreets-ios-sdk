//
//  File.swift
//  
//
//  Created by Ryan Cox on 2/1/23.
//

import Foundation

func getEnvironmentVar(_ name: String) -> String? {
    guard let rawValue = getenv(name) else { return nil }
    return String(utf8String: rawValue)
}
