//
//  modeDescriptionVC.swift
//  FYP2.3
//
//  Created by yi 万 on 2021/1/8.
//

import UIKit

class ModeDescriptionVC: UIViewController {
    
    var mode = ""

    @IBOutlet weak var modeImage: UIImageView!
    
    @IBOutlet weak var modeDiscription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modeImage.image = UIImage(named: mode)
        modeDiscription.text = "Due to the limitation of the education and teaching resource，each Mechanism class always only has one mechanism modal or less to demonstrate the theory of mechanism. Student can only use unintuitive and obscure graph or video to help themselves understand the theory underlying the mechanisms. Current teaching methods cannot reach an ideal teaching effect since it requires students to have a strong spatial imagination. Therefore, AR technology can be introduced into the mechanical class to fulfill the current demands."
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        if let nextVC = segue.destination as? ARSceneViewController {
            nextVC.mode = mode
        }
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
