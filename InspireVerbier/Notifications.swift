//
//  Notifications.swift
//  InspireVerbier
//
//  Created by Ihor Dolhalov on 18.09.2022.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    //створення запиту на повідомлення
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permission granted: \(granted)")
            guard granted else {return}
            self.getNotificationSettings()
        }
    }
    // Отримання інформації по дозволу на повідомлення з налаштувань додатка
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else {return}
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

        /* // Створюємо Локальне повідомлення
    func scheduleNotification(notifaicationType: String) {
        
        let content = UNMutableNotificationContent()
        let userAction = "User Action"
        content.categoryIdentifier = userAction
        content.title = notifaicationType
        content.body = "This is example how to create " + notifaicationType
        content.sound = UNNotificationSound.default
        content.badge = 0
        
        //Перевіряємо чи є файл картинка що треба передати в повідомленні
        guard let path = Bundle.main.path(forResource: "logo", ofType: "png") else {return}
        
        let url = URL(fileURLWithPath: path)
        // перевіряємо можливість создати аттачмент для повідомлення
        do {
            let attachment = try UNNotificationAttachment(
                identifier: "logo", url: url, options: nil)
            content.attachments = [attachment]
        } catch {
            print("The attachment couldn't be loaded")
        }
        
        // тріггер по часу
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        // додаємо дії
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        
        // визначаємо категорії дій
        let category = UNNotificationCategory(
            identifier: userAction,
            actions: [snoozeAction, deleteAction],
            intentIdentifiers: [],
            options: [])
        
        //реєструємо категорії в центрі повідомлень
        notificationCenter.setNotificationCategories([category])
    }*/
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
            UIApplication.shared.applicationIconBadgeNumber = -1
            
            body = response.notification.request.content.body // передача тіла пуша в глобальну переменну body
            print("***********************************")
            print("Пришло сообщение с текстом:  \(body)")
            print("***********************************")

        }
    
   /* // тут прописана дія що робити коли прийшло повідомлення
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the Local Notification Identifire")
        }
               
    // обробка екшенов повідомлень
            switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier: // пользователь отклоняет уведомления
                print("Dismiss Action")
            case UNNotificationDefaultActionIdentifier: // пользователь тапнет на уведомление и откроет приложение
                print("Default")
            case "Snooze": // пользователь виберет действие снуз
                print("Snooze")
                scheduleNotification(notifaicationType: "Reminder") //снова викличемо повідомлення
            case "Delete": // пользователь виберет действие делит
                print("Delete")
            default:
                print("Unknown action")
            }
            
        completionHandler()
    }*/
}

