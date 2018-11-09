//
//  RecognizerViewController
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class RecognizerViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private var sceneView: ARSCNView!

    private var imageConfiguration: ARImageTrackingConfiguration?
    private var hasSetWorldOrigin = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        setupSceneView()
        setupImageDetection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let configuration = imageConfiguration {
            sceneView.debugOptions = .showFeaturePoints
            sceneView.session.run(configuration)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - Private methods

    private func setupSceneView() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
    }

    private func setupImageDetection() {
        imageConfiguration = ARImageTrackingConfiguration()

        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Images",bundle: nil) else {
                fatalError("Missing expected asset catalog resources.")
        }
        imageConfiguration?.trackingImages = referenceImages
    }

}

extension RecognizerViewController: ARSessionDelegate {

    // MARK: - ARSessionDelegate

    func session(_ session: ARSession, didFailWithError error: Error) {
        guard
            let error = error as? ARError,
            let code = ARError.Code(rawValue: error.errorCode)
            else { return }

        switch code {
        case .cameraUnauthorized:
            print("Camera tracking is not available. Please check your camera permissions.")
        default:
            print("Error starting ARKit. Please fix the app and relaunch.")
        }
    }

    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                print("Too much motion! Slow down.")
            case .initializing, .relocalizing:
                print("ARKit is doing it's thing. Move around slowly for a bit while it warms up.")
            case .insufficientFeatures:
                print("Not enough features detected, try moving around a bit more or turning on the lights.")
            }
        case .normal:
            print("Point the camera at a portrait.")
        case .notAvailable:
            print("Camera tracking is not available.")
        }
    }

}

extension RecognizerViewController: ARSCNViewDelegate {

    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            handleFoundImage(imageAnchor, node)
        }
    }

    private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
        DispatchQueue.main.async {
            guard let name = imageAnchor.referenceImage.name else { return }
            print("You found a \(name) image")

            if !self.hasSetWorldOrigin {
                self.sceneView.session.setWorldOrigin(relativeTransform: imageAnchor.transform)
                self.hasSetWorldOrigin = true

                let size = imageAnchor.referenceImage.physicalSize

                let plane = SCNPlane(width: size.width, height: size.height)
                let image = UIImage(named: "\(name)-origin")
                let imageNode = SCNNode(geometry: plane)
                imageNode.geometry?.firstMaterial?.diffuse.contents = image
                imageNode.name = name
                imageNode.opacity = 0.3
                imageNode.eulerAngles.x = -.pi / 2
                node.addChildNode(imageNode)

//                let annotationPlane = SCNPlane(width: plane.width * 1.5, height: plane.width * 0.5)
//                let annotationNode = SCNNode(geometry: annotationPlane)
//                let annotationView = PopUpView(frame: CGRect(x: 0, y: 0, width: 300, height: 120))
//                annotationView.configure(with: "Какой-то текст")
//                annotationNode.geometry?.firstMaterial?.diffuse.contents = annotationView
//                annotationNode.eulerAngles.x = -.pi / 2
//                // TODO: calculate delta
//                let delta = simd_float3(0, 0, -5.5)
//                annotationNode.simdPosition += delta
//                node.addChildNode(annotationNode)
            }
        }
    }

}
