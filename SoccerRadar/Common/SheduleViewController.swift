//
//  ViewController.swift
//  SoccerRadar
//
//  Created by Egor on 28/06/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class SheduleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonPars()
    }
    
    private func jsonPars() {
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?apiKey=824f5258ca0541fa824da8bd1417eba4&category=sports") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: data)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
