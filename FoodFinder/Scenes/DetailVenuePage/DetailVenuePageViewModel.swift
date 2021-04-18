//
//  DetailVenuePageViewModel.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 17/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//

import Combine
import Foundation
import Resolver
import SwiftUICombineToolBox

enum DetailVenuePageState {
    case loading
    case empty
    case detail(venue: DetailVenueContract)
}

final class DetailVenuePageViewModel: ObservableObject {
    @Published var state: DetailVenuePageState = .empty

    @Injected private var venueRepository: VenueRepositoryContract

    private var cancelBag = CancelBag()
    private var detailVenueId: String?

    init() {
        setUp()
    }

    func setUpViewModel(with detailVenueId: String) {
        self.detailVenueId = detailVenueId
    }

    func fetchDetailData() {
        guard let id = detailVenueId else {
            return
        }
        state = .loading
        venueRepository.getDetails(ofType: DetailedVenue.self, with: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] venue in
                guard let venue = venue else {
                    self?.state = .empty
                    return
                }
                self?.state = .detail(venue: venue)
            })
            .store(in: &cancelBag)
    }
}

extension DetailVenuePageViewModel {
    private func setUp() {}
}