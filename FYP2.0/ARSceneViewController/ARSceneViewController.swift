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
    
    var firstJoint:SCNNode?
    var secondJoint:SCNNode?
    var thirdJoint:SCNNode?
    var forthJoint:SCNNode?
    
    
    
    var directionFlag:Bool = false
    var timer:Timer?
    
    @IBOutlet weak var arView: ARSCNView!
    @IBOutlet weak var sliderBarLink1: UISlider!
    @IBOutlet weak var driveAngleVelocity: UISlider!
    
    @IBOutlet weak var sliderBarLink2: UISlider!
    @IBOutlet weak var sliderBarLink3: UISlider!
    @IBOutlet weak var sliderBarLink4: UISlider!
    
    
    @IBOutlet weak var driverLength: UITextField!
    @IBOutlet weak var driverVelocity: UITextField!
    
    @IBOutlet weak var popDownView: UIView!
    var popBtnStatus:Bool = false
    
    
    @IBOutlet weak var horizontalView: UIStackView!
    
    @IBAction func popDownBtn(_ sender: Any) {
        
        switch popBtnStatus {
        case false:
            popDownView.alpha = 0.7
            popBtnStatus = true
            break
        default:
            popDownView.alpha = 0
            popBtnStatus = false
            break
        }
        
        let velocityChartView = VelocityChartViewController()
        velocityChartView.viewDidLoad()
        guard let view = velocityChartView.view else{
            return
        }
        let view2 = velocityChartView.view!
        horizontalView.addSubview(view)
        horizontalView.addSubview(view2)
//        horizontalView.addSubview(view)
//        view.bottomAnchor.constraint(equalTo: popDownView.bottomAnchor).isActive = true
//        view.heightAnchor.constraint(equalToConstant: popDownView.frame.height - 10).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fourBarLinkParametersSetUp()
        arViewSetUp()
        sliderSetUp()
        GestureSetUp()
        determineTypeOfFourBar(fourBarLinkLength: fourBarLinkLength!)
        
        popDownView.alpha = 0
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
    
    
} // end ViewControllemeishi


// MARK: - Other Set Up Methods
extension ARSceneViewController {
    
    func arViewSetUp() {
        let configuration = ARWorldTrackingConfiguration()
        superImpositionSetUp(configuration: configuration)
        arView.session.run(configuration)
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
    }
    
    func fourBarLinkParametersSetUp() {
        
//        self.fourBarLinkLength = Array(repeating: sliderBarLink1.value, count: 4)
        self.fourBarLinkLength = [0.18, 0.18, 0.18, 0.18]
        self.fourBarInitialAngle = [-pi/2, 0, -pi, 0]
        
//        self.fourBarInitialAngle = initialPositionCaculate(fourBarLinkLength: self.fourBarLinkLength!)
        
        self.fourBarRotationAngle = [0, 0, 0, 0]
        self.currentNode = arView.scene.rootNode
        
        addFourBarLink(to: arView, ofLength: self.fourBarLinkLength! , with: self.fourBarInitialAngle! )
        
    }
}
