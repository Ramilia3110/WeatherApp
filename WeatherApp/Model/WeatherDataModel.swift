//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Ramilia Imankulova on 11/13/18.
//  Copyright © 2018 Ramilia Imankulova. All rights reserved.
//

import UIKit

class WeatherDataModel: UIViewController {
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        func updateWeatherIcon(condition: Int) -> String {
                switch (condition) {
            
                    case 0...300 :
                        return "tstorm1"
            
                    case 301...500 :
                        return "light_rain"
            
                    case 501...600 :
                        return "shower3"
            
                    case 601...700 :
                        return "snow4"
            
                    case 701...771 :
                        return "fog"
            
                    case 772...799 :
                        return "tstorm3"
            
                    case 800 :
                        return "sunny"
            
                    case 801...804 :
                        return "cloudy2"
            
                    case 900...903, 905...1000  :
                        return "tstorm3"
            
                    case 903 :
                        return "snow5"
            
                    case 904 :
                        return "sunny"
            
                    default :
                        return "dunno"
                    }
            
        }
    
    
}
