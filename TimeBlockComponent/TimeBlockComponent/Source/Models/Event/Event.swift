//
//  Event.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import Foundation

@Observable
class Event: Hashable, Identifiable, EventInterface {
    var delegate: TimeBlockDelegate?
    
    var id: String = UUID().uuidString
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    
    var name: String
    var dateInterval: DateInterval
    var day: Day
    
    init(id: String = UUID().uuidString,
         name: String,
         dateInterval: DateInterval,
         day: Day) {
        self.id = id
        self.name = name
        self.dateInterval = dateInterval
        self.day = day
    }
    
}
