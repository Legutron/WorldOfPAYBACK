//
//  PBError.swift
//
//
//  Created by Jakub Legut on 19/03/2024.
//

import Foundation

public enum PBError: Error {
	case randomError(String)
	case noConnection(String)
}
