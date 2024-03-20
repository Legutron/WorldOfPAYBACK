//
//  PaybackApp.swift
//  
//
//  Created by Jakub Legut on 13/03/2024.
//

import SwiftUI
import Common
import ComposableArchitecture
import TransactionFeature
import SplashFeature
import Theme
import OnlineShoppingFeature
import FeedFeature
import SettingsFeature

public let liveApp = PaybackAppView(
	store: Store(
		initialState: initialPaybackApp
	) {
		PaybackApp()
			.signpost()
	}
)

@Reducer
public struct PaybackApp {
	@ObservableState
	public struct State: Equatable {
		var splash: Splash.State
		var transaction: TransactionList.State
		
		var isSplashActive: Bool = true
		var selectedTab: Tab = .transactions
		
		public init(
			splash: Splash.State,
			transaction: TransactionList.State
		) {
			self.splash = splash
			self.transaction = transaction
		}
	}
	
	public enum Action: BindableAction {
		case splash(Splash.Action)
		case transaction(TransactionList.Action)
		
		case binding(BindingAction<State>)
	}
	
	public init() {}
	
	public var body: some Reducer<State, Action> {
		Reduce { state, action in
			switch action {
			case .splash(.delegate(let action)):
				switch action {
				case .navigateToHome:
					state.isSplashActive = false
					return .none
				}
			case .splash:
				return .none
			case .transaction:
				return .none
				
			case .binding:
			  return .none
			}
		}
		Scope(
			state: \.splash,
			action: \.splash
		) {
			Splash()
		}
		Scope(
			state: \.transaction,
			action: \.transaction
		) {
			TransactionList()
		}
	}
	
	enum Tab {
		case transactions, shopping, feed, settings
	}
}

public extension PaybackApp {
	struct Translations: Equatable {
		let transactionTranslations: TransactionList.Translations
		let splashTranslations: Splash.Translations
		
		public init(
			transactionTranslations: TransactionList.Translations,
			splashTranslations: Splash.Translations
		) {
			self.transactionTranslations = transactionTranslations
			self.splashTranslations = splashTranslations
		}
	}
}

public struct PaybackAppView: View {
	@Bindable var store: StoreOf<PaybackApp>
	
	public init(store: StoreOf<PaybackApp>) {
		self.store = store
	}
	
	public var body: some View {
		NavigationView {
			if store.isSplashActive {
				SplashView(
					store: store.scope(
						state: \.splash,
						action: \.splash
					)
				)
			} else {
				TabView(
					selection: $store.selectedTab
				) {
					NavigationStack {
						TransactionListView(
							store: store.scope(
								state: \.transaction,
								action: \.transaction
							)
						)
					}
					.tabItem {
						Image(systemName: "list.bullet")
						Text("Transactions")
					}
					.tag(PaybackApp.Tab.transactions)
					
					NavigationStack {
						OnlineShoppingView()
					}
					.tabItem {
						Image(systemName: "cart")
						Text("Shop")
					}
					.tag(PaybackApp.Tab.shopping)
					
					NavigationStack {
						FeedView()
					}
					.tabItem {
						Image(systemName: "magazine")
						Text("Feed")
					}
					.tag(PaybackApp.Tab.feed)
					
					NavigationStack {
						SettingsView()
					}
					.tabItem {
						Image(systemName: "gear")
						Text("Settings")
					}
					.tag(PaybackApp.Tab.feed)
				}
			}
		}
	}
}

// MARK: - Public Functions
public func setBuildType(_ type: BuildType) {
	PaybackAssembler.shared.setBuildType(type)
}

// MARK: - Initial States
private let initialPaybackApp: PaybackApp.State = .init(
	splash: initialSplashView, 
	transaction: initialTransactionListView
)

private let initialSplashView: Splash.State = .init(
	translations: .init(
		errorTitle: L10n.internetConnectionErrorTitle,
		errorDescription: L10n.internetConnectionErrorDescription,
		errorButton: L10n.internetConnectionErrorButton
	),
	assets: .init(icon: "wifi.exclamationmark")
)

private let initialTransactionListView: TransactionList.State = .init(
	translations: .init(
		title: L10n.transactionListTitle,
		defaultCategoryLabel: L10n.transactionListDefaultCategory,
		sumLabel: L10n.transactionListSum,
		selectedLabel: L10n.transactionListSelectedLabel,
		errorTitle: L10n.transactionConnectionErrorTitle,
		errorDescription: L10n.transactionConnectionErrorDescription,
		errorButton: L10n.transactionConnectionErrorButton
	),
	assets: .init(icon: "exclamationmark.circle.fill"),
	transactions: .init(uniqueElements: [])
)
