//
//  DatabaseManager.swift
//  Messenger
//
//  Created by 나지혜 on 2021/04/28.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    static let shared = DatabaseManager() //make singleton
    
    private let database = Database.database().reference()
    
}

//MARK: - Account Management
extension DatabaseManager{
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)){
        //있으면 false, 없으면 true
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else{
                completion(false)
                return
            }
            completion(true)
        })
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAddress).setValue([ //use email as key
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
    }
}
struct ChatAppUser{
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
}
