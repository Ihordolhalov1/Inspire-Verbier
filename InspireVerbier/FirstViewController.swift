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
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            // показати алерт контроллер якщо прийшов пуш з текстом пуша
            if body != "" {
                let alert = UIAlertController(title: "",
                                              message: body,
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Got it", style: .default) { (action) in
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                body = ""
            } else { print(body) }
        }
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
                              
                                  //Тут прописан алерт контроллер, окно просьбой передумать и перейти в настройки чтоб разрешить трекинг с двумя кнопками, перейти в настройки или отмена. Пришлось закомментировать так как Apple не пропускает
                            /* let alertController = UIAlertController(title: nil, message: "Sorry, tracking is a highly desireble for the application to remember your preferances. Please go to settings to allow", preferredStyle: .alert)
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
                              self.present(alertController, animated: true) */
                              print ("denied")
                              self.performSegue(withIdentifier: "secondVCSegue", sender: nil)
                              
                              
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
