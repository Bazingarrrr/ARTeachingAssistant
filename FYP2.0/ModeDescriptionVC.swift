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
        modeDiscription.text = "NKJJY!!!!!"
        
        
        
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
