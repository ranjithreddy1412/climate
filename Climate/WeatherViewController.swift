//
//  WeatherViewController.swift
//  Climate
//
//  Created by apple on 11/03/21.
//

import UIKit

class WeatherViewController: UIViewController {

  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cloudLabel: UILabel!
  
  var weatherModel = WeatherDataModel()
  var temp: Int?
  var cityName: String?
  var iconName: String?
  var cloudStatus: String?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      // Do any additional setup after loading the view.
      updateWeatherData(model: weatherModel)
    }
    
  func updateWeatherData(model: WeatherDataModel) {
    
    let tempResult = model.list?.first?.main?.temp ?? 0.0
    temp = Int(tempResult - 273.15)
    
    cityName = model.city?.name ?? ""
    
    if let weatherCondition = model.list?.first?.weather?[0].id {
      iconName = updateWeatherIcon(condition: weatherCondition)
    }
    
    if let cloudCondition = model.list?.first?.weather?[0].weatherDescription {
      cloudStatus = cloudCondition
    }
    
    updateUIWithWeatherData()
    
  }
  
  func updateUIWithWeatherData() {
      
      cityLabel.text = cityName
      temperatureLabel.text = "\(temp!)°"
      weatherIcon.image = UIImage(named: iconName ?? "")
      cloudLabel.text = "Cloudy: \(cloudStatus ?? "")"
      
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
