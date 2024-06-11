//
//  RESTSettingsManager.swift
//  Dashboard
//
//  Created by User on 10.06.2024.
//

import Foundation

class RESTSettingsManager: ObservableObject{
    @Published var SettingsData: [SettingsItem] = []
    @Published var DrawingData: [DrawingItem] = []
    @Published var CountData: [CountItem] = []
    @Published var drawingList: [String:String] = [:]
    @Published var countList: [String:String] = [:]
    @Published var Error: String = ""
    /*init(){
        self.getSettingsData(){success in
            
        }
        self.getDrawingData(){success in
            
        }
        self.getCountData(){success in
            
        }
    }*/
    func getSettingsData(completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "http://31.133.104.162:8080/api/groupuser/") else{
            print("Invalid URL")
            completion(false)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token " + (SaveManager.shared.get(key: "token") ?? ""), forHTTPHeaderField: "Authorization")
        
        /*guard let jsonData = try? JSONEncoder().encode(body) else{
            print("Failed to encode JSON")
            completion(false)
            return
        }
        request.httpBody = jsonData*/
        
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
                let authResponse = try JSONDecoder().decode([SettingsItem].self, from: data)
                DispatchQueue.main.async{
                    //print(String(decoding: data,as: UTF8.self))
                    self?.SettingsData = authResponse
                    completion(true)
                    
                }
            }catch{
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    
    func getDrawingData(completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "http://31.133.104.162:8080/api/drawingtypelist") else{
            print("Invalid URL")
            completion(false)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token " + (SaveManager.shared.get(key: "token") ?? ""), forHTTPHeaderField: "Authorization")
        
        /*guard let jsonData = try? JSONEncoder().encode(body) else{
            print("Failed to encode JSON")
            completion(false)
            return
        }
        request.httpBody = jsonData*/
        
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
                let authResponse = try JSONDecoder().decode([DrawingItem].self, from: data)
                DispatchQueue.main.async{
                    //print(String(decoding: data,as: UTF8.self))
                    self?.DrawingData = authResponse
                    self?.drawingList = ((authResponse.reduce(into: [String: String]()) { dictionary, Item in
                        dictionary[String(Item.id)] = Item.name}) +
                                         authResponse.reduce(into: [String: String]()) { dictionary, Item in
                        dictionary[Item.name] = String(Item.id)})
                    completion(true)
                    
                    
                }
            }catch{
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    func getCountData(completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "http://31.133.104.162:8080/api/typescountlist") else{
            print("Invalid URL")
            completion(false)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token " + (SaveManager.shared.get(key: "token") ?? ""), forHTTPHeaderField: "Authorization")
        
        /*guard let jsonData = try? JSONEncoder().encode(body) else{
            print("Failed to encode JSON")
            completion(false)
            return
        }
        request.httpBody = jsonData*/
        
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
                let authResponse = try JSONDecoder().decode([CountItem].self, from: data)
                DispatchQueue.main.async{
                    //print(String(decoding: data,as: UTF8.self))
                    self?.CountData = authResponse
                    self?.countList = ((authResponse.reduce(into: [String: String]()) { dictionary, Item in
                        dictionary[String(Item.id)] = Item.name}) +
                                       authResponse.reduce(into: [String: String]()) { dictionary, Item in
                        dictionary[Item.name] = String(Item.id)})
                    completion(true)
                    
                }
            }catch{
                print("Failed to decode JSON: \(error.localizedDescription)")
                self?.Error = error.localizedDescription
                completion(false)
            }
        }
        task.resume()
    }
    
    
    
    func sendSettings(settingsItems: [SettingsItem], completion: @escaping (Bool) -> Void) {
        // Создаем URL
        guard let url = URL(string: "http://31.133.104.162:8080/api/groupuser/") else {
            completion(false)
            return
        }

        // Создаем URLRequest и устанавливаем метод PUT
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        // Устанавливаем заголовок Content-Type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token " + (SaveManager.shared.get(key: "token") ?? ""), forHTTPHeaderField: "Authorization")

        // Сериализуем массив структур в JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(settingsItems)
            request.httpBody = jsonData
            print(jsonData)
        } catch {
            print("Ошибка при сериализации данных: \(error)")
            completion(false)
            return
        }

        // Создаем и запускаем задачу URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error)")
                completion(false)
                return
            }

            if let response = response as? HTTPURLResponse {
                print("Код ответа: \(response.statusCode)")
                completion(true)
                
            }

            if let data = data {
                //print("Ответ: \(String(data: data, encoding: .utf8) ?? "Нет данных")")
            }
        }

        task.resume()
        
    }
}
