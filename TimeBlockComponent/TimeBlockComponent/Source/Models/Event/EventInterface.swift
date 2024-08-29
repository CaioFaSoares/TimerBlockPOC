//
//  EventInterface.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import Foundation

protocol EventInterface {
    var dateInterval: DateInterval { get set }
    var day: Day { get set }
    
    var delegate: TimeBlockDelegate? { get set }
}
