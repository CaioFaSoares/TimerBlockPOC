//
//  TimeBlockCalendar.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 24/07/24.
//

import Foundation
import SwiftUI

struct EmptyComponent: View {
    var body: some View {
        Rectangle()
            .stroke(lineWidth: 2)
            .foregroundStyle(.gray.opacity(0.6))
    }
}

protocol DayInterface {
    var id: String { get }
    
    var name: WeekDayType { get set }
    var monthDay: Int { get set }
    var date: Date { get set }
}

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

struct WeekDay: Hashable {
    var monthNumber: Int
    var day: WeekDayType
}

enum WeekDayType: String, CaseIterable, Hashable {
    case sunday
    case monday, tuesday, wednesday, thursday, friday
    case saturday
    
    
    var small: String {
        var name = self.rawValue
        var letters: String = String(name.removeFirst())
        letters += String(name.removeFirst())
        letters += String(name.removeFirst())
        return letters.uppercased()
    }
    
    var n: Int {
        switch self {
        case .sunday:
            1
        case .monday:
            2
        case .tuesday:
            3
        case .wednesday:
            4
        case .thursday:
            5
        case .friday:
            6
        case .saturday:
            7
        }
    }
    
    static func build(_ n: Int) -> WeekDayType {
        switch n {
        case 1:
                .sunday
        case 2:
                .monday
        case 3:
                .tuesday
        case 4:
                .wednesday
        case 5:
                .thursday
        case 6:
                .friday
        case 7:
                .saturday
        default:
                .sunday
        }
    }
}

extension DateInterval {
    
    func getHeight(hourHeight: CGFloat) -> CGFloat {
        self.end.timeIntervalSince(self.start)
        *
        (hourHeight/3600)
    }
    
    func getOffSetHeight(hourHeight: CGFloat) -> CGFloat {
        Calendar.current.startOfDay(for: self.start).timeIntervalSince(self.start)
        *
        (hourHeight/3600)
    }
    
}

