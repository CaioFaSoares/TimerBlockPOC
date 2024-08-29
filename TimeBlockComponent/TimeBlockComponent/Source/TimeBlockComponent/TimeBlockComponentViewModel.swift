//
//  TimeBlockComponentViewModel.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 29/07/24.
//

import SwiftUICore

@Observable
class TimeBlockComponentViewModel {
    
    var events: [EventInterface]
    private let beginDay: Day
    var numberOfDays: Int
    var numberOfHours: Int
    var days: [DayInterface] = []
    
    var selectedStartDate: Date
    var selectedFinalDate: Date
    
    var height: CGFloat
    var width: CGFloat
    
    init(events: [EventInterface] = [],
         numberOfDays: Int,
         numberOfHours: Int,
         height: CGFloat,
         width: CGFloat,
         selectedStartDate: Date = .now,
         selectedFinalDate: Date = .now) {
        self.events = events
        self.numberOfDays = numberOfDays
        self.numberOfHours = numberOfHours
        self.selectedStartDate = selectedStartDate
        self.selectedFinalDate = selectedFinalDate
        self.height = height
        self.width = width
        self.beginDay = .init(date: .now)
        self.days = (0..<self.numberOfDays).map {
            Day.init(date: beginDay.date.addingTimeInterval(TimeInterval($0*60*60*24)))
        }
    }
    
    func addEvent(selectedStartDate: Date,
                  selectedFinalDate: Date) {
        let dateInterval = DateInterval(start: selectedStartDate,
                                        end: selectedFinalDate)
        let date = Calendar.current.startOfDay(for: selectedStartDate)
        self.events.append(Event.init(name: "Teste1",
                                 dateInterval: dateInterval,
                                 day: Day(date: date)))
    }
    
    func finalRange() -> ClosedRange<Date> {
        selectedStartDate...(Calendar.current.startOfDay(for: selectedStartDate)).addingTimeInterval(1439)
    }
    
}

extension TimeBlockComponentViewModel: TimeBlockDelegate {
    func filteredEvents(event: EventInterface) -> [EventInterface] {
        let eventsInDay = self.events.filter {
            $0.day.date == event.day.date
        }
        let eventsNoRepeat = eventsInDay.filter {
            $0.dateInterval != event.dateInterval
        }
        return eventsNoRepeat
    }
}

// Comunicacao para colisoes ou outras coisas entre Eventos
protocol TimeBlockDelegate {
    func filteredEvents(event: EventInterface) -> [EventInterface]
}

