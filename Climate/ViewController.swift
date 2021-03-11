//
//  ViewController.swift
//  Climate
//
//  Created by apple on 11/03/21.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var changeCityTextField: UITextField!
  
  let dashboardServiceLayer = DashboardServiceLayer()
  var weatherModel = WeatherDataModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    dashboardServiceLayer.delegate = self
    
    
  }

  @IBAction func getWeatherPressed(_ sender: AnyObject) {
    
    if let city = changeCityTextField.text {
      dashboardServiceLayer.dasboardServiceRequest(cityName: city)
    }
  }

}

extension ViewController: DashboardServiceLayerDelegate {
  
  var cityName: String {
    return changeCityTextField.text ?? ""
  }
  
  var appId: String {
    return ""
  }
  
  func responseFromDashboardService(_ weatherResponse: WeatherDataModel, error: String?) {
    if weatherResponse.cod == "200" {
      print("weatherResponse \(weatherResponse)")
      weatherModel = weatherResponse
      
      let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = myStoryBoard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
      if let vc = viewController {
        vc.weatherModel = self.weatherModel
        navigationController?.pushViewController(vc, animated: false)
      }
      
    }
  }
  
  
  
}

