//
//  WorldOfPAYBACKAppApp.swift
//  WorldOfPAYBACKApp
//
//  Created by Jakub Legut on 13/03/2024.
//

import SwiftUI
import PaybackPackage

@main
struct WorldOfPAYBACKAppApp: App {
	
	public init() {
		#if MOCKDATA
		setBuildType(.debugWithMock)
		#elseif DEBUG
		setBuildType(.debug)
		#else
		setBuildType(.prod)
		#endif
	}
	var body: some Scene {
		WindowGroup {
			liveApp
		}
	}
}
