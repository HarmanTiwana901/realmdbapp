//
//  Task.swift
//  ToDo
//
//  Created by Jessie sihota on 2022-07-18.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId 
    @Persisted var title = ""
    @Persisted var completed = false
}
