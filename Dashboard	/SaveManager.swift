//
//  SaveManager.swift
//  Dashboard
//
//  Created by User on 07.06.2024.
//

import Foundation
import Security


class SaveManager {
    
    static let shared = SaveManager()
    
    private init() {}
    
    func save(key: String, value: String) -> Bool {
        // Удалите старое значение, если оно существует
        delete(key: key)
        
        // Преобразуйте строку в Data
        guard let data = value.data(using: .utf8) else { return false }
        
        // Создайте словарь атрибутов для сохранения данных в Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Добавьте данные в Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    func get(key: String) -> String? {
        // Создайте словарь атрибутов для поиска данных в Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        
        // Извлеките данные из Keychain
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let result = String(data: data, encoding: .utf8) else { return nil }
        
        return result
    }
    
    func delete(key: String) -> Bool {
        // Создайте словарь атрибутов для удаления данных из Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        // Удалите данные из Keychain
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
    func theme() -> ThemeManager{
        if(self.get(key: "theme") == nil){
            self.save(key: "theme", value:"light")
            return ThemeManager(initialScheme: .light)
        }
        else{
            if(self.get(key: "theme") == "light"){
                return ThemeManager(initialScheme: .light)
            }
            else{
                return ThemeManager(initialScheme: .dark)
            }
        }
    }
}
