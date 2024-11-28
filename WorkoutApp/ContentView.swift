//
//  ContentView.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var workoutApp = WorkoutEntryViewModel()
    @State private var isRefreshing = false
    @EnvironmentObject var authModel: AuthModel
    @State private var newWorkout = WorkoutEntryModel(workoutTitle: "", exercises: [])

    var body: some View {
        NavigationView {
            VStack {
                if isRefreshing {
                    ProgressView("Refreshing, Please Wait.")
                        .padding()
                }

                List {
                    ForEach($workoutApp.workouts) { $workout in
                        NavigationLink {
                            WorkoutEntryDetail(workoutEntry: $workout)
                        } label: {
                            Text(workout.workoutTitle)
                        }
                    }
                    Section {
                        NavigationLink {
                            WorkoutEntryDetail(workoutEntry: Binding(
                                get: { newWorkout },
                                set: { newWorkout = $0 }
                            ))
                            .onAppear {
                                newWorkout = WorkoutEntryModel(workoutTitle: "", exercises: [])
                                print("New Workout initialized: \(newWorkout)")
                            }
                        } label: {
                            Text("New Workout")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    refreshData()
                }

                ScrollView {
                    VStack {
                        Button(action: {
                            authModel.signOut()
                        }) {
                            Text("Sign Out")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.top, 20)
                        }
                        .padding(.bottom, 20)
                        
                        NavigationLink(destination: OneRepMaxView()) {
                            Text("Go to 1RM Calculator")
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .bold))
                                .padding()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Workouts")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func refreshData() {
        isRefreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            workoutApp.fetchData()
            isRefreshing = false
        }
    }
}


