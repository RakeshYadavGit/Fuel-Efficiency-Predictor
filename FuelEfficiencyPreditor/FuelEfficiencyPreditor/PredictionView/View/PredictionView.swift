//
//  PredictionView.swift
//  FuelEfficiencyPreditor
//
//  Created by Rakesh Yadav on 03/08/25.
//

import SwiftUI

struct PredictionView: View {
    @StateObject var predictionViewModel: PredictionViewModel = PredictionViewModel()

    // Individual input variables
    @State private var vehicleYear: String = ""
    @State private var cylinderCapacity: String = ""
    @State private var displacement: String = ""
    @State private var horsepower: String = ""
    @State private var acceleration: String = ""
    @State private var selectedOrigin: String = ""


    var body: some View {
        VStack {
            Text(AppConstants.titleText)
                .italic()
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 10, x: 0, y: 5)

            Text(String(format: AppConstants.resultTextFormat, predictionViewModel.mpg))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .background(Color(hex: "#7D1E44"))

            VStack(spacing: 16) {
                TextField(AppConstants.TextHints.enterVehicleYear.rawValue, text: $vehicleYear)
                    .textFieldStyle()

                TextField(AppConstants.TextHints.cylinderCapacity.rawValue, text: $cylinderCapacity)
                    .textFieldStyle()

                TextField(AppConstants.TextHints.displacement.rawValue, text: $displacement)
                    .textFieldStyle()

                TextField(AppConstants.TextHints.horsepower.rawValue, text: $horsepower)
                    .textFieldStyle()

                TextField(AppConstants.TextHints.acceleration.rawValue, text: $acceleration)
                    .textFieldStyle()
                
                Picker(AppConstants.originPickerTitle, selection: $selectedOrigin) {
                    ForEach(AppConstants.VehicleOrigin.allCases) { origin in
                        Text(origin.rawValue).tag(origin)
                    }
                }
                .pickerStyle(.segmented)
                .padding()


            }
            .padding(.top, 40)

            Button {
                // Action here
            } label: {
                Text(AppConstants.buttonText)
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.black
                            .cornerRadius(10)
                    )
                    .padding()
            }
            
            Spacer()
        }
        .background(Color(hex: "#CF2F61"))
    }
}



#Preview {
    PredictionView()
}
