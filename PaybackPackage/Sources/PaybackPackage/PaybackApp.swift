//
//  File.swift
//  
//
//  Created by Jakub Legut on 13/03/2024.
//

import SwiftUI
import Localization

public struct PaybackApp: View {
	public init() {}
	
	public var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundStyle(.tint)
			Text(L10n.`init`)
		}
		.padding()
	}
}
