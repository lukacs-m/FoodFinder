//
//  FoodFinderProgressView.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 13/04/2021.
//

import SwiftUI

struct FoodFinderProgressView: View {
    var body: some View {
        ProgressView("Loading...")
            .foregroundColor(Color.black)
            .scaleEffect(1.5, anchor: .center)
            .frame(width: 150, height: 150, alignment: .center)
            .background(Color.gray.opacity(0.40))
            .progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

struct FoodFinderProgressView_Previews: PreviewProvider {
    static var previews: some View {
        FoodFinderProgressView()
    }
}
