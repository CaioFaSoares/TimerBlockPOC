//
//  Event.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 24/07/24.
//

import Foundation
import SwiftUI


protocol EventInterface {
    var dateInterval: DateInterval { get set }
    var day: Day { get set }
    
    var delegate: TimeBlockDelegate? { get set }
}

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
