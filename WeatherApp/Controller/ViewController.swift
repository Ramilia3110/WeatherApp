//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ramilia Imankulova on 11/13/18.
//  Copyright © 2018 Ramilia Imankulova. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, ChangePlace {
    
    
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var tempImage: UIImageView!
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"

    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLbl.text = "Connection Issues"
            }
        }
        
    }
    
    
    func updateWeatherData(json : JSON) {
        
        let tempResult = json["main"]["temp"].doubleValue
        
        weatherDataModel.temperature = Int(tempResult - 273.15)
        
        weatherDataModel.city = json["name"].stringValue
        
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        updateUIWithWeatherData()
    }
    
    
    
    
    func updateUIWithWeatherData() {
        
        cityLbl.text = weatherDataModel.city
        tempLbl.text = "\(weatherDataModel.temperature)°"
        tempImage.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLbl.text = "Location Unavailable"
    }
    
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        performSegue(withIdentifier: "toGetWeather", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGetWeather" {
            let destionation = segue.destination as! GetWeatherVC
            destionation.delegate = self
            
        }
    }
    
    func userEnteredNewCity(city: String) {
        let params: [String: String] = ["q": city, "appid": APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
}

