//
//  extensionString.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/18/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

extension String {
    func stringDate(dateFormatFrom: String, dateFormatTo: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateFormatFrom
        dateFormatterGet.locale = Locale(identifier: Locale.current.languageCode ?? "en_US_POSIX")
        dateFormatterGet.timeZone = TimeZone(identifier: "UTC")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = dateFormatTo
        
        guard let date: Date = dateFormatterGet.date(from: self) else { return self }
        return dateFormatterPrint.string(from: date)
    }
}
