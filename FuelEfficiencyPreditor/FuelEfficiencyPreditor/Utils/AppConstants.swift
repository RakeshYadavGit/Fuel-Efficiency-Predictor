//
//  AppConstants.swift
//  FuelEfficiencyPreditor
//
//  Created by Rakesh Yadav on 03/08/25.
//

enum AppConstants {
    static let resultTextFormat: String = "Your estimated fuel efficiency is %.2f mpg"
    static let titleText: String = "Fuel Efficiency Predictor using AI"
    static let predictionErrorText: String = "Something went wrong. Please try again later."
    static let predictionLoadingText: String = "Predicting..."
    static let buttonText: String = "Predict"
    static let originPickerTitle: String = "Origin"

    enum TextHints: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case enterVehicleYear = "Enter the year of your vehicle"
        case cylinderCapacity = "Enter the cylinder capacity of your vehicle"
        case displacement = "Enter the displacement of your vehicle"
        case horsepower = "Enter the horsepower of your vehicle"
        case weight = "Enter the weight of your vehicle"
        case acceleration = "Enter the acceleration of your vehicle"
        case origin = "Select the origin of your vehicle"
    }
    
    enum VehicleOrigin: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case usa = "USA"
        case europe = "Europe"
        case japan = "Japan"
    }
}
