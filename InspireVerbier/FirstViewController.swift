//
//  FirstViewController.swift
//  InspireVerbier
//
//  Created by Ihor Dolhalov on 30.09.2022.
//

import UIKit
import AppTrackingTransparency

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func contunueButtonPressed(_ sender: UIButton) {
        requestTrackingAuthorization()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    private func requestTrackingAuthorization() {
        guard #available(iOS 14, *) else { return }
        
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                  DispatchQueue.main.async {
                      ATTrackingManager.requestTrackingAuthorization {status in
                          switch status {
                              // Проверяем status
                          case .notDetermined:
                              print ("notDetermined")
                          case .restricted:
                              print ("restricted")
                          case .denied:
                              let alertController = UIAlertController(title: nil, message: "Sorry, tracking is a highly desireble for the application to remember your preferances. Please go to settings to allow", preferredStyle: .alert)
                              let allowAction = UIAlertAction(title: "Allow", style: .default) {_ in
                                  //Переход в настройки приложения
                                  if let url = URL(string: UIApplication.openSettingsURLString) {
                                      if UIApplication.shared.canOpenURL(url) {
                                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                      }
                                  }
                              }
                              let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) {_ in
                                  self.performSegue(withIdentifier: "secondVCSegue", sender: nil)}
                              
                              alertController.addAction(allowAction)
                              alertController.addAction(cancelAction)
                              self.present(alertController, animated: true)
                              print ("denied")
                              
                          case .authorized:
                              print ("authorized")
                                  // Переходим на второй контроллер
                              self.performSegue(withIdentifier: "secondVCSegue", sender: nil)
                          @unknown default:
                              print ("unknown")
                          }
                      }
                      
                     
                  }
        })
    }
    
    
}
