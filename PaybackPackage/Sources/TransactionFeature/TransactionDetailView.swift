//
//  TransactionDetailView.swift
//
//
//  Created by Jakub Legut on 19/03/2024.
//

import SwiftUI
import Theme

public struct TransactionDetailView: View {
	
	let transaction: TransactionModel
	
	public init(
		transaction: TransactionModel
	){
		self.transaction = transaction
	}
	
	public var body: some View {
		VStack {
			Text(transaction.partnerName)
				.apply(style: .h1)
			
			if let description = transaction.details.description {
				Text(description)
					.apply(style: .normal)
			}
		}
		.backgroundFull(Asset.background.swiftUIColor)
	}
}

#if DEBUG
#Preview {
	NavigationView {
		TransactionDetailView(transaction: .mock1)
	}
	.navigationViewStyle(.stack)
}
#endif
