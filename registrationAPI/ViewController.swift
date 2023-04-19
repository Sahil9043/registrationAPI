//
//  ViewController.swift
//  registrationAPI
//
//  Created by Lalaiya Sahil on 28/02/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var arrUser: [User] = []
    @IBOutlet weak var passwordtextFilde: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var emailtextFilde: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        getUsers()
    
    }
    
    @IBAction func registrationButtonClicked(_ sender: Any) {
        let  registrationViewController = storyboard?.instantiateViewController(withIdentifier: " RegistrationViewController") as!  RegistrationViewController
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    private func getUsers(){
        let perameter: Parameters = ["email" : "\(emailtextFilde.text)", "password" : "\(passwordtextFilde.text)"]
        AF.request(" https://reqres.in/api/register", method: .post,parameters: perameter).responseData {  response in
            debugPrint("response \(response)")
            if response.response?.statusCode == 200{
                guard let apiData = response.data else {return}
                do{
                    self.arrUser = try JSONDecoder().decode([User].self, from: apiData)
                }
                catch{
                    print(error.localizedDescription)
                }
            }else{
                print("Something went wrong")
            }
        }
    }

}
struct User: Decodable{
    var email: String
    var password: String
}


