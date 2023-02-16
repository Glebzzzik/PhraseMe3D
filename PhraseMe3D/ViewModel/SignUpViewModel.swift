//
//  SingInViewModel.swift
//  PhraseMe3D
//
//  Created by Глеб Голощапов on 15.02.2023.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON

class SignUpViewModel: ObservableObject{
    
    
    func SignUpAction(email: String, password: String, username: String, con: ((_ result: String, _ error: String) -> Void )? = nil) {
        let url = "http://localhost:8080/register/user?username=\(username)&email=\(email)&password=\(password)"
        
    


        
        AF.request(url, method: .get).validate().responseString() { response in
            switch response.result{
            case .success(let value):
                let answer = value
                con!(answer, "Succed")
//                print(answer)
                
//                print(value)
//                let json = JSON(value)
//                let token = json["token"].stringValue
//                UserDefaults.standard.setValue(token, forKey: "token")
//                con!(token, "Success")
//                print(json)
            case .failure(let error):
                print(error.localizedDescription)
                con!("", error.localizedDescription)
            }
        }
    }
    
}
