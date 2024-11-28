//
//  WorkoutEntryDetail.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/26/24.
//

import SwiftUI

struct WorkoutEntryDetail: View {
    
    @Binding var workoutEntry: WorkoutEntryModel
    @ObservedObject var workoutEntryViewModel = WorkoutEntryViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                TextField("Workout Title", text: $workoutEntry.workoutTitle)
                    .font(.system(size: 25, weight: .bold))
                    .disableAutocorrection(true)
                    .autocapitalization(.words)
                    .padding(.top, 25)

                ForEach(workoutEntry.exercises.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Exercise Name", text: $workoutEntry.exercises[index].name)
                            .font(.system(size: 12))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)

                        HStack {
                            TextField("Reps", value: $workoutEntry.exercises[index].reps, formatter: NumberFormatter())
                                .font(.system(size: 12))
                            
                            TextField("Weight (lbs)", value: $workoutEntry.exercises[index].weight, formatter: NumberFormatter())
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.bottom, 10)
                }
                .onDelete { indices in
                    workoutEntry.exercises.remove(atOffsets: indices)
                }

                Button(action: {
                    let newExercise = Exercise(name: "", reps: 0, weight: 0)
                    workoutEntry.exercises.append(newExercise)
                    print("After append: \(workoutEntry.exercises)")
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.red)
                        Text("Add Exercise")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 10)
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    workoutEntryViewModel.saveData(workout: workoutEntry)
                } label: {
                    Text("Save")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(workoutEntry.workoutTitle.isEmpty ? "New Workout" : workoutEntry.workoutTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print("WorkoutEntryDetail appeared with \(workoutEntry.exercises.count) exercises.")
        }
    }
}

