//
//  ViewController.swift
//  LoadJsonLocalFile
//
//  Created by Wanlou Feng on 19/4/17.
//  Copyright © 2017 Wanlou Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tvMessage: UITextView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btn1TouchUpInside(_ sender: Any) {
        //http://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
        if let path = Bundle.main.path(forResource: "userDataFakeData", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                var str:String = ""
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if let persons : [NSDictionary] = jsonResult["person"] as? [NSDictionary] {
                        for person: NSDictionary in persons {
                            for (name,value) in person {
                                str += "\(name) , \(value)    "
                            }
                            str += "\n"
                        }
                    }
                } catch {}
                tvMessage.text = str
                
            } catch {}
        }
    } //end of func
    
    
    @IBAction func btn2TouchUpInside(_ sender: Any) {
        //// http://swiftdeveloperblog.com/code-examples/download-file-from-a-remote-url-in-swift/
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile002.jpg")
    
        //Create URL to the source file you want to download
        let fileURL = URL(string: "http://caringsoftware.com/wnbjs/bmw01.jpg")   //"https://s3.amazonaws.com/learn-swift/IMG_0001.JPG")
    
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
    
        let request = URLRequest(url:fileURL!)
    
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file."); /// Error description: %@", error?.localizedDescription!);
            }
        }
        task.resume()
    
} // end of func

} //end of class

