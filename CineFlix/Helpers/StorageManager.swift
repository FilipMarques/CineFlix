//
//  File.swift
//  CineFlix
//
//  Created by Filipe Camargo Marques on 16/08/23.
//

import Foundation
import KeychainSwift

class StorageManager {

    let keychain = KeychainSwift()

    func getAccessToken() -> String? {
        return keychain.get("access_token")
    }

    func setAccessToken(accessToken: String?) {
        if let accessToken {
            keychain.set(accessToken, forKey: "access_token")
        } else {
            keychain.delete("access_token")
        }

    }

    func getAccountId() -> String? {
        return keychain.get("account_id")
    }

    func setAccountId(accountId: String?) {
        if let accountId {
            keychain.set(accountId, forKey: "account_id")
        } else {
            keychain.delete("account_id")
        }
    }
}
