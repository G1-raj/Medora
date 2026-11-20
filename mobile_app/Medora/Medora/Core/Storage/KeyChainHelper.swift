//
//  KeyChainHelper.swift
//  Medora
//
//  Created by Govine Rajput on 20/11/26.
//

import Foundation
import Security

enum KeyChainHelper {
    
    nonisolated private static let service = "devplaceholder.IJGCAWK5.Medora"
    nonisolated private static let account = "accessToken"
    
    enum KeychainError: Error {
        case unhandledError(OSStatus)
        case invalidData
    }
    
    //save access token
    nonisolated static func save(_ token: String) throws {
        let data = Data(token.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String:
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        let status = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )
        
        switch status {
        case errSecSuccess:
            return
            
        case errSecItemNotFound:
            var newItem = query
            attributes.forEach {
                newItem[$0.key] = $0.value
            }
            
            let addStatus = SecItemAdd(
                newItem as CFDictionary,
                nil
            )
            
            if addStatus == errSecDuplicateItem {
                try save(token)
                return
            }
            
            guard addStatus == errSecSuccess else {
                throw KeychainError.unhandledError(addStatus)
            }
            
         default:
            throw KeychainError.unhandledError(status)
        }
        
    }
    
    //read token
    nonisolated static func read() throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: CFTypeRef?
        
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )
        
        if status == errSecItemNotFound {
            return nil
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status)
        }
        
        guard let data = result as? Data, let token = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidData
        }
        
        return token
    }
    
    //delete token
    nonisolated static func delete() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess ||
              status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status)
        }
    }
    
    
}
