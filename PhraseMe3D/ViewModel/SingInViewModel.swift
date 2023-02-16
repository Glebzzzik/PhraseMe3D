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

class SignInViewModel: ObservableObject{
    
    func SignInAction(email: String, password: String, con: ((_ result: String, _ error: String) -> Void )? = nil) {
        let url = "http://localhost:8080/login/user?email=\(email)&password=\(password)"
        
    
//        let url = "http://localhost:8080/login/user?email=Sasamamleev1@gmail.com&password=123"

        
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
