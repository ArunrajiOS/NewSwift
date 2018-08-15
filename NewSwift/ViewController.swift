//
//  ViewController.swift
//  NewSwift
//
//  Created by Arunraj on 28/07/18.
//  Copyright © 2018 Arunraj. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let missingName : String? = nil
//        let realName : String? = "John Doe"
//        let existentName : String = missingName ?? realName!
//        let BaseUrl : String? = "http://seekitechdemo.com/upark/api/api.php?request=uParkViewStreetEvents"
//        guard let url  = URL(string:(BaseUrl)!) else{
//            return
//        }
//        Alamofire.request(url,
//                          method: .post,
//                          parameters: nil)
//            .validate()
//            .responseJSON { response in
//
//
//                let JSON = response.result.value as! [String:Any]
//                let id = JSON["uParkViewStreetEvents"] as? [String : Any]
//                let first = id?["msg"] as! String
//
//
//
//    }
        CreatRequest()
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    func CreatRequest(){
        
    var request  = URLRequest(url: URL(string: "http://seekitechdemo.com/upark/api/api.php?request=uParkUserRegistratio")!)
        let chosenImage = UIImage(named: "ponda")
        let params:[String: Any] = [
            "DeviceToken" :"241241241241 4124124124",
            "UserName" : "sensorInformation",
            "EmailID" : "don@gmail.com",
            "Password" : "radius",
            "MobileNumber" : "0987654321",
            "Latitude" : "23.23234",
            "Longitude" : "3423434"]
        
        
    request.httpMethod = "POST"
    let boundary = "Boundary-\(UUID().uuidString)"
    let contentType = "multipart/form-data; boundary=\(boundary)"
    request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: params,
                                boundary: boundary,
                                data: UIImageJPEGRepresentation(chosenImage!, 0.7)!,
                                mimeType: "image/jpg",
                                filename: "hello.jpg")
        
        
       // myActivityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("******* response = \(String(describing: response))")
            
        }
        task.resume()
    
        
}
    
func createBody(parameters: [String: Any],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }

}
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

