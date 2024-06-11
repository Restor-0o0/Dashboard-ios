//
//  RESTManager.swift
//  Dashboard
//
//  Created by User on 06.06.2024.
//

import Foundation

class RESTAuthManager: ObservableObject{
    @Published var Token: String = ""
    @Published var Error: String = ""
    func login(username: String, password: String, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "http://31.133.104.162:8080/auth/token/login/") else{
            print("Invalid URL")
            completion(false)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["username": username,"password": password]
        guard let jsonData = try? JSONEncoder().encode(body) else{
            print("Failed to encode JSON")
            completion(false)
            return
        }
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request){[weak self] data, response, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                self?.Error = error.localizedDescription
                completion(false)
                return
            }
            guard let data = data else{
                print("No  data returned")
                self?.Error = "Нет данных"
                completion(false)
                return
            }
            do{
                let authResponse = try JSONDecoder().decode(AuthAPIModel.self, from: data)
                DispatchQueue.main.async{
                    print(String(decoding: data,as: UTF8.self))
                    self?.Token = authResponse.auth_token
                    self?.Error = ""
                    completion(true)
                    
                }
            }catch{
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    
    
}
