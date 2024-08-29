//
//  Day.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import Foundation

struct Day: Hashable, Identifiable, DayInterface {
    
    var id: String = UUID().uuidString
    
    var name: WeekDayType
    var monthDay: Int
    var date: Date
    
    init(date: Date) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)
        self.date = today
        self.monthDay = calendar.component(.day, from: today)
        self.name = .build(calendar.component(.weekday, from: today))
    }
    
}
