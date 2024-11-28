//
//  WorkoutEntry.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/26/24.
//

import Foundation
import FirebaseFirestoreSwift

struct WorkoutEntryModel: Codable, Identifiable {
    @DocumentID var id: String?
    var workoutTitle: String
    var exercises: [Exercise]
}

struct Exercise: Codable, Identifiable {
     var id = UUID()
    var name: String
    var reps: Int
    var weight: Double
}
