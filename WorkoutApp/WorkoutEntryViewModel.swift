//
//  WorkoutEntryViewModel.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/26/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class WorkoutEntryViewModel: ObservableObject {
    
    @Published var workouts = [WorkoutEntryModel]()
    private let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("workouts")
            .getDocuments { [weak self] querySnapshot, error in
                if let error = error {
                    print("Error fetching workouts: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No workouts found.")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.workouts = documents.compactMap { doc in
                        try? doc.data(as: WorkoutEntryModel.self)
                    }
                }
            }
    }

    func saveData(workout: WorkoutEntryModel) {
        guard !workout.workoutTitle.isEmpty, !workout.exercises.isEmpty else {
            print("Invalid workout data: Title and exercises cannot be empty.")
            return
        }
        
        if let id = workout.id {
            
            do {
                try db.collection("workouts").document(id).setData(from: workout) { error in
                    if let error = error {
                        print("Error updating workout: \(error)")
                    } else {
                        print("Workout successfully updated.")
                    }
                }
            } catch {
                print("Error encoding workout for update: \(error)")
            }
        } else {
            
            do {
                _ = try db.collection("workouts").addDocument(from: workout) { error in
                    if let error = error {
                        print("Error adding new workout: \(error)")
                    } else {
                        print("Workout successfully added.")
                    }
                }
            } catch {
                print("Error encoding workout for save: \(error)")
            }
        }
    }
}

