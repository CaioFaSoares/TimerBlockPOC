//
//  DateInterval.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import Foundation

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
