//
//  ViewController.swift
//  FYP2.3
//
//  Created by yi 万 on 2021/1/3.
//

import UIKit

class ViewController: UIViewController {
    
    var mode = ""
    
    @IBOutlet weak var fourBarButton: UIButton!
    
    @IBOutlet weak var crankSliderButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let nextVC = segue.destination as? ARSceneViewController {
            
            if sender as? NSObject == fourBarButton {
                mode = "fourBar"
            }
            if sender as? NSObject == crankSliderButton {
                mode = "crankSlider"
            }
            nextVC.mode = mode
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
