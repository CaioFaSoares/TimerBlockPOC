//
//  WeekDayType.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

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
    
    //TODO: - Voltar aqui
    
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
