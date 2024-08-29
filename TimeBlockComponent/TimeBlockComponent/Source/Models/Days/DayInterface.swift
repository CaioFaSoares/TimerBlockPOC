//
//  DayInterface.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import Foundation

protocol DayInterface {
    
    var id: String { get }
    
    var name: WeekDayType { get set }
    var monthDay: Int { get set }
    var date: Date { get set }
    
}
