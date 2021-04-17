//
//  MainRouter.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 12/04/2021.
//

import SwiftUI
import SwiftUICombineToolBox

enum PageDestinationType {
    case detailVenue(detailVenueId: String)
}

protocol RouteToPageContract {
    func goToPage(for destination: PageDestinationType) -> AnyView
}

final class MainRouter {}

extension MainRouter: RouteToPageContract {
    func goToPage(for destination: PageDestinationType) -> AnyView {
        switch destination {
        case let .detailVenue(detailVenueId):
            let destination = DetailVenuePageView()
            destination.viewModel.setUpViewModel(with: detailVenueId)
            return destination.eraseToAnyView()
        }
    }
}
