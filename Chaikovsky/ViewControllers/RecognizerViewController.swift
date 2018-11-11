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
import FloatingPanel

class RecognizerViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet private var sceneView: ARSCNView!

    private var imageConfiguration: ARImageTrackingConfiguration?
    private var hasSetWorldOrigin = false

    lazy private var fpc: FloatingPanelController = {
        let fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.surfaceView.cornerRadius = 12.0
        fpc.surfaceView.grabberHandle.isHidden = true
        return fpc
    }()

    private var floatingPanelIsShown = false
    private var foundedPortraits: [String] = []
    private var currentArtist = Artist()

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

        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - IBActions

    @IBAction func unwindToRecognizerViewController(segue: UIStoryboardSegue) { }

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

    private func showFloatingPanel() {
        guard let contentVC = self.storyboard?.instantiateViewController(withIdentifier: PreviewViewController.className) as? PreviewViewController else { return }
        contentVC.artist = currentArtist
        contentVC.delegate = self
        self.fpc.set(contentViewController: contentVC)
        self.fpc.addPanel(toParent: self, belowView: nil, animated: true)
        self.floatingPanelIsShown = true
    }

    @objc
    private func dismissFloatingPanel() {
        fpc.removePanelFromParent(animated: true)
        floatingPanelIsShown = false
    }

    // Mark: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.className {
            guard let destinationVC = segue.destination as? DetailViewController else { return }
            destinationVC.artist = currentArtist
        }
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

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            handleFoundImage(imageAnchor, node)
        }
    }

    private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
        DispatchQueue.main.async {
            guard let name = imageAnchor.referenceImage.name else { return }
            print("You found a \(name) image")

            if !self.foundedPortraits.contains(name) {
                self.sceneView.session.setWorldOrigin(relativeTransform: imageAnchor.transform)
                self.hasSetWorldOrigin = true

                let size = imageAnchor.referenceImage.physicalSize

                let plane = SCNPlane(width: size.width, height: size.height)
                let image = UIImage(named: "\(name)-origin")
                if image != nil {
                    let imageNode = SCNNode(geometry: plane)
                    imageNode.geometry?.firstMaterial?.diffuse.contents = image
                    imageNode.name = name
                    imageNode.opacity = 1.0
                    imageNode.eulerAngles.x = -.pi / 2
                    node.addChildNode(imageNode)
                }

                self.foundedPortraits.append(name)
            }

            let artistName = String(name.split(separator: "-").first!)

            if self.currentArtist.imageName != artistName || !self.floatingPanelIsShown || self.fpc.position == .tip {
                self.currentArtist = Artist(imageName: artistName)
                self.showFloatingPanel()
            }
        }
    }

}

extension RecognizerViewController: FloatingPanelControllerDelegate {

    // MARK: - Floating panel controller delegate

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return DetailFloatingPanelLayout()
    }

    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
        if targetPosition == .tip {
            dismissFloatingPanel()
            floatingPanelIsShown = false
        }
    }

}

extension RecognizerViewController: PreviewViewControllerDelegate {

    // MARK: - PreviewViewControllerDelegate
    
    func didTapMoreButton() {
        performSegue(withIdentifier: DetailViewController.className, sender: nil)
    }

}
