//
//  Date+DateFormatter.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import Foundation

extension Date {
    func stringFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
