//
//  ViewModels+Dependencies.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 12/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the MVVM Xcode Templates
//

import Resolver

extension Resolver {
    public static func registerViewModels() {
        register { HomeMapViewModel() }.scope(.shared)
    }
}
