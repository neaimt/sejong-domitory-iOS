//
//  Date+Extension.swift
//  Sejong_Domitory
//
//  Created by 박근경 on 2024/07/30.
//

import Foundation

extension DateFormatter {
    static let noticeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
}
