//
//  PredictionViewModel.swift
//  FuelEfficiencyPreditor
//
//  Created by Rakesh Yadav on 03/08/25.
//

import Foundation
import TensorFlowLite

final class PredictionViewModel: ObservableObject {
    @Published var mpg: Float = 0.0
    private var interpreter: Interpreter?
    private let means: [Float] = [5.477707, 195.318471, 104.869427, 2990.251592, 15.559236, 75.898089, 0.624204, 0.178344, 0.197452]
    private let stds: [Float] = [1.699788, 104.331589, 38.096214, 843.898596, 2.789230, 3.675642, 0.485101, 0.383413, 0.398712]
    
    func initializeInterpreter() {
        self.interpreter = self.loadModel()
    }
    
    private func loadModel() -> Interpreter? {
        guard let modelPath: String = Bundle.main.path(forResource: "automobile", ofType: "tflite") else {
            return nil
        }
        
        do {
            let interpreter: Interpreter = try Interpreter(modelPath: modelPath)
            try interpreter.allocateTensors()
            return interpreter
        } catch {
            return nil
        }
    }
    
    func predict(userInputs: [String]) {
        let userInputs: [Float] = self.processInputs(userInputs)
        let normalizedInputs: [Float] = self.normalizeValues(userInputs: userInputs)
        self.sendInputsToModel(normalizedInputs)
    }
    
    private func normalizeValues(userInputs: [Float]) -> [Float] {
        return userInputs.enumerated().map { index, value in
            return (value - means[index]) / stds[index]
        }
    }

    private func processInputs(_ userInputs: [String]) -> [Float] {
        guard userInputs.count == 7 else { return [] }

        let origin = userInputs.last!
        let numericInputs = userInputs.dropLast().compactMap(Float.init)

        let originOneHot: [Float] = {
            switch origin {
            case AppConstants.VehicleOrigin.usa.rawValue:
                return [1.0, 0.0, 0.0]
            case AppConstants.VehicleOrigin.europe.rawValue:
                return [0.0, 1.0, 0.0]
            default:
                return [0.0, 0.0, 1.0]
            }
        }()

        return numericInputs + originOneHot
    }
    
    private func sendInputsToModel(_ inputs: [Float]) {
        guard let interpreter: Interpreter = self.interpreter else { return }
        let data: Data = Data(bytes: inputs, count: MemoryLayout<Float>.size * inputs.count)
        
        do {
            try interpreter.copy(data, toInputAt: 0)
            try interpreter.invoke()
            self.getPrediction()
            
        } catch {
            debugPrint("Something went wrong: \(error)")
        }
    }
    
    private func getPrediction() {
        guard let interpreter: Interpreter = self.interpreter else { return }
        
        do {
            let outputTensor: Tensor = try interpreter.output(at: 0)
            let data: Data = outputTensor.data
            self.mpg = data.withUnsafeBytes({$0.load(as: Float.self)})
            
        } catch {
            debugPrint("Something went wrong: \(error)")
        }
    }
}
