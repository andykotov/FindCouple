//
//  FindCoupleApp.swift
//  FindCouple
//
//  Created by mr. Hakoda on 13.08.2021.
//

import StoreKit
import SwiftUI

@main
struct FindCoupleApp: App {
    @ObservedObject var model = Model()
    @StateObject var storeManager = StoreManager()
    
    let productIDs = [
            //Use your product IDs instead
            "AdditionalTime30",
            "DisableAdvertise",
            "SkipLevel1"
        ]
    
    init() {
        RequestIP()
    }
    
    var body: some Scene {
        WindowGroup {
           if model.gameBehavior.geo == "RU"  {
                WebViewContainer(model: model)
                    .navigationBarTitle(Text(model.gameBehavior.title), displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        model.gameBehavior.shouldGoBack.toggle()
                    }, label: {
                        if model.gameBehavior.canGoBack {
                            Image(systemName: "arrow.left")
                                .frame(width: 44, height: 44, alignment: .center)
                        } else {
                            EmptyView()
                                .frame(width: 0, height: 0, alignment: .center)
                        }
                    })
                )
           } else {
                ContentView(storeManager: storeManager).environmentObject(model)
                    .onAppear(perform: {
                        SKPaymentQueue.default().add(storeManager)
                        storeManager.getProducts(productIDs: productIDs)
                    })
           }
        }
    }
    
    
    
    func RequestIP() {
        guard let url = URL(string: "https://api.ipify.org?format=json") else {
            print("Bad URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                       let response = response as? HTTPURLResponse,
                       error == nil else {                                              // check for fundamental networking error
                       print("error", error ?? "Unknown error")
                       return
                   }

                   guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                       print("statusCode should be 2xx, but is \(response.statusCode)")
                        //print("response = \(response)")
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                            if let responseJSON = responseJSON as? [String: Any] {
                                print(responseJSON)
                                _ = responseJSON["detail"] as! String
                            }
                       return
                   }

                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
                if let responseJSON = responseJSON as? [String: Any] {
                    let ip = responseJSON["ip"] as? String ?? ""
                    
                    RequestGeo(ip: ip)
                }
            }
        }.resume()
    }
    
    func RequestGeo(ip: String) {
        guard let url = URL(string: "https://ipinfo.io/\(ip)?token=e66dcefb79c94b") else {
            print("Bad URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                       let response = response as? HTTPURLResponse,
                       error == nil else {                                              // check for fundamental networking error
                       print("error", error ?? "Unknown error")
                       return
                   }

                   guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                       print("statusCode should be 2xx, but is \(response.statusCode)")
                        //print("response = \(response)")
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                            if let responseJSON = responseJSON as? [String: Any] {
                                print(responseJSON)
                                _ = responseJSON["detail"] as! String
                            }
                       return
                   }

                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let responseJSON = responseJSON as? [String: Any] {
                    let country = responseJSON["country"] as? String ?? ""
                    model.gameBehavior.geo = country
                }
            }
        }.resume()
    }
}
