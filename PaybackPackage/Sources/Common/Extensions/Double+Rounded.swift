//
//  Double+Rounded.swift
//  
//
//  Created by Jakub Legut on 17/03/2024.
//

import Foundation

public extension Double {
	func rounded(toPlaces places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
