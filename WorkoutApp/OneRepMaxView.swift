//
//  OneRepMaxView.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/26/24.
//

import SwiftUI

struct OneRepMaxView: View {
    
    @State private var reps: String = ""
    @State private var weight: String = ""
    @State private var oneRepMax: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("One Rep Max Calculator")
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
            
            TextField("Enter Weight (lbs)", text: $weight)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter Reps", text: $reps)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: calculateOneRepMax) {
                Text("Calculate 1RM")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.system(size: 16))
            }
            .padding(.top, 20)
            
            if !oneRepMax.isEmpty {
                Text("One Rep Max: \(oneRepMax) lbs")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func calculateOneRepMax() {
        guard let weightValue = Double(weight), let repsValue = Double(reps), repsValue > 0 else {
            oneRepMax = "Invalid input. Please enter valid numbers."
            return
        }
    
        let calculatedOneRepMax = weightValue * (1 + 0.0333 * repsValue)
        oneRepMax = String(format: "%.2f", calculatedOneRepMax)
    }
}

struct OneRepMaxView_Previews: PreviewProvider {
    static var previews: some View {
        OneRepMaxView()
    }
}

