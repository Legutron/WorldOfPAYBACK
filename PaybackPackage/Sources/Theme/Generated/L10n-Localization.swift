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
