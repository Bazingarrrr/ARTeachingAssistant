//
//  HomeVC.swift
//  FYP2.3
//
//  Created by Jason on 8/1/2021.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var homeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.layer.cornerRadius = 30
        
        let min = CGFloat(-80)
        let max = CGFloat(80)
              
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
              
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
              
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]

        homeImage.addMotionEffect(motionEffectGroup)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
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
