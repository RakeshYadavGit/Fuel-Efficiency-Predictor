//
//  View + Extension.swift
//  FuelEfficiencyPreditor
//
//  Created by Rakesh Yadav on 03/08/25.
//

import SwiftUICore

extension View {
    func textFieldStyle() -> some View {
        self
            .padding(20)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "#FEF2F4").opacity(0.8))
            )
            .padding(.horizontal)
    }
}
