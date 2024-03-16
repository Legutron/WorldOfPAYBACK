//
//  Date+Pretty.swift
//
//
//  Created by Jakub Legut on 15/03/2024.
//

import Foundation

public extension Date {
	var prettyDate: String {
		let formatter = PaybackAssembler.shared.dateFormatter
		formatter.dateFormat = DateFormat.dateAndHours
		return formatter.string(from: self)
	}
}
