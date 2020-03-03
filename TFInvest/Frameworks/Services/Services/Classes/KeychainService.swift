//
//  KeychainService.swift
//  KeychainTest
//
//  Created by Михаил Борисов on 25.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Foundation
import Security
import Base

public class KeychainService { // : ServiceProtocol {

    enum Errors: Error {
        case keychainError
    }

    public static let shared = KeychainService()

    // make avaliable service name outside for getter
    private var service: String {
        guard let identifier = Bundle.main.bundleIdentifier else {
            return "com.investt.keychain"
        }
        return identifier
    }

    /// Check does the item exist
    /// - Parameter account: key of item
    public func exists(forKey account: String) throws -> Bool {
        // return keychain items that matching account name (key)
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: false
            ] as NSDictionary, nil)
        if status == errSecSuccess {
            // return found
            return true
        } else if status == errSecItemNotFound {
            // return not found
            return false
        } else {
            throw Errors.keychainError
        }
    }

    /// add item to keychain
    /// - Parameters:
    ///   - value: value for keychain
    ///   - account: key of item
    private func add(value: Data, forKey account: String) throws {
        // Adds one or more items to a keychain.
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            // Allow background access:
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecValueData: value
            ] as NSDictionary, nil)
        guard status == errSecSuccess else { throw Errors.keychainError }
    }

    /// update a keychain item
    /// - Parameters:
    ///   - value: value for Keychain
    ///   - account: key for item
    private func update(value: Data, forKey account: String) throws {
        // Modifies items that match a search query.
        let status = SecItemUpdate([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service
            ] as NSDictionary, [
            kSecValueData: value
            ] as NSDictionary)
        // if not success, throw error
        guard status == errSecSuccess else { throw Errors.keychainError }
    }

    /// Set item for Keychain
    /// - Parameters:
    ///   - value: value for Keychain
    ///   - account: key for item
    public func set(value: Data, forKey account: String) throws {
        // check if item exist
        if try exists(forKey: account) {
            // if it's true, try to update
            try update(value: value, forKey: account)
        } else {
            // if not found, just add new
            try add(value: value, forKey: account)
        }
    }

    /// Return key
    /// - Parameter account: Key for item
    public func get(forKey account: String) throws -> String? {
        var result: AnyObject?
        // Returns one or more keychain items that match a search query
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true
            ] as NSDictionary, &result)
        if status == errSecSuccess {
            guard let keychainData = result as? Data else {
                return nil
            }
            guard let keychainString = String(data: keychainData, encoding: .utf8) else {
                return nil
            }
            return keychainString

        } else if status == errSecItemNotFound {
            return nil
        } else {
            throw Errors.keychainError
        }
    }

    /// delete an item
    /// - Parameter account: item for key
    public func delete(forKey account: String) throws {
        // Delete item that match a search query.
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service
            ] as NSDictionary)
        // if not success, throw error
        guard status == errSecSuccess else { throw Errors.keychainError }
    }

    /// Delete all items
    public func deleteAll() throws {
        // Delete items that match a search query.
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword
            ] as NSDictionary)
        // if not success, throw error
        guard status == errSecSuccess else { throw Errors.keychainError }
    }
}
