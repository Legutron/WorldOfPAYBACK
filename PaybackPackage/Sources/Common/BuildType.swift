//
//  BuildType.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Foundation

public enum BuildType {
	case debug
	case debugWithMock
	case prod
	
	/// The active BuildType
	public static var active: BuildType {
		#if DEBUG
		return .debug
		#else
		return .prod
		#endif
	}
}
