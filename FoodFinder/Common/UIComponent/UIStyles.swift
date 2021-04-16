//
//  UIStyles.swift
//  FoodFinder
//
//  Created by Martin Lukacs on 16/04/2021.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(currentForegroundColor, lineWidth: 1))
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 14, weight: .semibold))
    }
}
