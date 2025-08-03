//
//  PredictionViewModel.swift
//  FuelEfficiencyPreditor
//
//  Created by Rakesh Yadav on 03/08/25.
//

import Foundation

final class PredictionViewModel: ObservableObject {
    @Published var mpg: Float = 0.0
    var userInputs: [Any] = []
}
