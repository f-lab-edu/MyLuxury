//
//  DateFormatter.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import Foundation

func convertDateToString(date: Date?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    guard let date = date else { return "" }
    return dateFormatter.string(from: date)
}
