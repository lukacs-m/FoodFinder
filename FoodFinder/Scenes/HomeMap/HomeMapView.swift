//
//  HomeMapView.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 13/04/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the MVVM Xcode Templates
//

import MapKit
import Resolver
import SwiftUI
import SwiftUICombineToolBox

/// This scene presents a map with recommanded restaurants to a user
struct HomeMapView: View {
    @InjectedObject private var viewModel: HomeMapViewModel
    @State private var rec = MKMapRect.world
    @State private var showOverlay = false
    @State private var showDetailVenue = false

    var body: some View {
        mainContainerView
            .overlay(ZStack {
                if showOverlay {
                    venueOverlayDetails
                } else {
                    EmptyView().eraseToAnyView()
                }
            })
            .sheet(isPresented: $showDetailVenue) {
                LazyView(viewModel.router.goToPage(for: .detailVenue(detailVenueId: viewModel.getSelectedVenueId())))
            }
            .alert(isPresented: $viewModel.displayAlert, content: {
                Alert(title: Text("Maps Permissions Denied"),
                      message: Text("Please enable map permission in App Settings"),
                      dismissButton: .default(Text("Go to settings"), action: {
                          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                      }))
            })
    }
}

// MARK: - Main Container

extension HomeMapView {
    private var mainContainerView: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingMap
            case .localized:
                ZStack {
                    map()
                    recenterButton()
                }
            }
        }
    }
}

// MARK: - Loading map state view

extension HomeMapView {
    private var loadingMap: some View {
        ZStack {
            Map(mapRect: $rec)
                .ignoresSafeArea(.all, edges: .all)
            FoodFinderProgressView()
        }
    }
}

// MARK: - User position recenter button

extension HomeMapView {
    private func recenterButton() -> some View {
        let bottomPadding: CGFloat = 25
        let imagePadding: CGFloat = 10

        return VStack {
            Spacer()
            Button(action: {
                viewModel.resetFocus()
            }, label: {
                Image(systemName: "location.fill")
                    .font(.title2)
                    .padding(imagePadding)
                    .background(Color.primary)
                    .clipShape(Circle())
            })
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
        .padding(.bottom, bottomPadding)
    }
}

// MARK: - Map view

extension HomeMapView {
    private func map() -> some View {
        Map(coordinateRegion: $viewModel.currentRegion,
            showsUserLocation: true,
            annotationItems: viewModel.mapVenueAnnotations) { venueAnnotation in
                MapAnnotation(coordinate: venueAnnotation.coordinate) {
                    Button(action: {
                        viewModel.setSelectedVenue(for: venueAnnotation)
                        showOverlay = true
                    }) {
                            VStack {
                                Image(systemName: "mappin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                                    .foregroundColor(.red)
                                    .font(.title)
                                Text(venueAnnotation.name)
                            }
                    }
                }
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

// MARK: - Small overlay Venue details

extension HomeMapView {
    private var venueOverlayDetails: some View {
        ZStack {
            Color.gray
                .opacity(0.8)
                .blur(radius: 3)
                .ignoresSafeArea(.all, edges: .all)

            VStack(alignment: .leading, spacing: 15) {
                Text(viewModel.getSelectedVenue()?.name ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.body)
                        .clipShape(Circle())
                    Text(viewModel.getSelectedVenue()?.type ?? "")
                }
                HStack {
                    Spacer()
                    Button(action: {
                        showOverlay = false
                        showDetailVenue = true
                    }) {
                            Text("Want more details")
                    }.buttonStyle(LargeButtonStyle(backgroundColor: Color.black, foregroundColor: Color.white, isDisabled: false))

                    Button(action: {
                        showOverlay = false
                        viewModel.cleanSelection()
                    }) {
                            Text("Had enough")
                    }.buttonStyle(LargeButtonStyle(backgroundColor: Color.black, foregroundColor: Color.white, isDisabled: false))
                    Spacer()
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
        }
    }
}

struct HomeMapView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMapView()
    }
}
