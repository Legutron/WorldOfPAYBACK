//
//  Mocks.swift
//  
//
//  Created by Jakub Legut on 19/03/2024.
//

import Foundation

public extension Splash.State {
	static let mock: Self = .init(
		translations: .init(
			errorTitle: "No internet connection",
			errorDescription: "Check if your phone is connected to the Internet.",
			errorButton: "Try again"
		),
		assets: .init(icon: "wifi.exclamationmark")
	)
}
