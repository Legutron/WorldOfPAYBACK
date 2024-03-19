// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// ******************************************************************************
  ///  * Exported from POEditor - https://poeditor.com
  ///  ******************************************************************************
  public static let `init` = L10n.tr("Localizable", "init", fallback: "init")
  /// Try again
  public static let internetConnectionErrorButton = L10n.tr("Localizable", "internet_connection_error_button", fallback: "Try again")
  /// Check if your phone is connected to the Internet.
  public static let internetConnectionErrorDescription = L10n.tr("Localizable", "internet_connection_error_description", fallback: "Check if your phone is connected to the Internet.")
  /// No internet connection
  public static let internetConnectionErrorTitle = L10n.tr("Localizable", "internet_connection_error_title", fallback: "No internet connection")
  /// Retry
  public static let transactionConnectionErrorButton = L10n.tr("Localizable", "transaction_connection_error_button", fallback: "Retry")
  /// We were unable to download the transaction list, please try again by pressing the button below, if the download fails after several attempts, please contact our customer support.
  public static let transactionConnectionErrorDescription = L10n.tr("Localizable", "transaction_connection_error_description", fallback: "We were unable to download the transaction list, please try again by pressing the button below, if the download fails after several attempts, please contact our customer support.")
  /// The connection failed
  public static let transactionConnectionErrorTitle = L10n.tr("Localizable", "transaction_connection_error_title", fallback: "The connection failed")
  /// All
  public static let transactionListDefaultCategory = L10n.tr("Localizable", "transaction_list_default_category", fallback: "All")
  /// selected
  public static let transactionListSelectedLabel = L10n.tr("Localizable", "transaction_list_selected_label", fallback: "selected")
  /// Sum
  public static let transactionListSum = L10n.tr("Localizable", "transaction_list_sum", fallback: "Sum")
  /// Transaction List
  public static let transactionListTitle = L10n.tr("Localizable", "transaction_list_title", fallback: "Transaction List")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
