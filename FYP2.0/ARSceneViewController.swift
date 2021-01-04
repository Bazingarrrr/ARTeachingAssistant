//
//  ViewController.swift
//  FYP2.0
//
//  Created by yi 万 on 11/17/20.
//



import UIKit
import ARKit

let pi:Float = 3.14
var indicatorOfNode = 1




class ARSceneViewController: UIViewController {

    var fourBarLinkLength:[Float]?
    var fourBarInitialAngle:[Float]?
    var fourBarRotationAngle:[Float]?
    var linkLength:Float?
    var linkRadius:Float = 0.005
    
    var mode:String = ""
    
    var currentNode:SCNNode?
    var currentNode_detected:SCNNode?
    
    var directionFlag:Bool = true
    var timer:Timer?
    
    @IBOutlet weak var arView: ARSCNView!
    @IBOutlet weak var sliderBarLink1: UISlider!
    @IBOutlet weak var driveAngleVelocity: UISlider!
    
    @IBOutlet weak var driverLength: UITextField!
    @IBOutlet weak var driverVelocity: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fourBarLinkParametersSetUp()
        arViewSetUp()
        sliderSetUp()
        GestureSetUp()
        determineTypeOfFourBar(fourBarLinkLength: fourBarLinkLength!)
        
        addFourBarLink(to: arView, ofLength: fourBarLinkLength!, with: fourBarInitialAngle!)
        addCrankSlider(driveAngle: pi/6)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tapTimer()
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    // MARK: - IBAction methods
    

    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
//            .fadeOut(duration: 0.5),
//            .removeFromParentNode()
        ])
    }
    
    
    @IBAction func changeVelocity(_ sender: Any) {
        timer!.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1/self.driveAngleVelocity.value), repeats: true) { (Timer) in
            self.driverVelocity.text = String( self.driveAngleVelocity.value )
            self.generateNewNode(mode:self.mode)
        }
    }
    
    
} // end ViewController


// MARK: - Other Set Up Methods
extension ARSceneViewController {
    
    func arViewSetUp() {
        let configuration = ARWorldTrackingConfiguration()
        superImpositionSetUp(configuration: configuration)
        arView.session.run(configuration)
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    func fourBarLinkParametersSetUp() {
        
        self.fourBarLinkLength = Array(repeating: sliderBarLink1.value, count: 4)
        self.fourBarInitialAngle = [0, -pi/2, -pi/2, -pi/2]
//        self.fourBarInitialAngle = initialPositionCaculate(fourBarLinkLength: self.fourBarLinkLength!)
        
        self.fourBarRotationAngle = [0 , 0, 0, 0]
        self.currentNode = arView.scene.rootNode
        
    }
    
}









