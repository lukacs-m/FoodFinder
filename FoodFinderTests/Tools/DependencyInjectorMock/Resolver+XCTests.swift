//
//  Resolver+XCTests.swift
//  FoodFinderTests
//
//  Created by Martin Lukacs on 14/04/2021.
//

import XCTest
import Resolver

@testable import FoodFinder

extension Resolver {
    
    static var test: Resolver!
    
    static func resetUnitTestRegistrations() {
        Resolver.test = Resolver(parent: .main)
        Resolver.root = .test
    }
}
