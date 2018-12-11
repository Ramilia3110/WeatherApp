//
//  GetWeatherVC.swift
//  WeatherApp
//
//  Created by Ramilia Imankulova on 11/13/18.
//  Copyright © 2018 Ramilia Imankulova. All rights reserved.
//

import UIKit

protocol ChangePlace {
    func userEnteredNewCity(city: String)
}

class GetWeatherVC: UIViewController {
    
    var delegate : ChangePlace?
    
    @IBOutlet weak var cityField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func getPressed(_ sender: Any) {
        let cityName = cityField.text!
        delegate?.userEnteredNewCity(city: cityName)
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
