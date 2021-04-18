//
//  FoodFinderApp.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 12/04/2021.
//

import Resolver
import SwiftUI
import SwiftUICombineToolBox

@main
struct FoodFinderApp: App {
    var body: some Scene {
        WindowGroup {
            HomeMapView().embedInNavigation()
        }
    }
}
