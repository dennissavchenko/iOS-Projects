import UIKit
import AVFoundation
import Vision
import CoreML

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var requests = [VNRequest]()
    
    // Add a UILabel to display recognized object names and confidence
    var recognizedTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Detecting..."
        label.textColor = .white
        label.backgroundColor = UIColor.white.withAlphaComponent(0)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupVision()
        setupOverlay() // Add this call to setup the overlay
    }
    
    func setupCamera() {
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession?.addInput(input)
        } catch let error {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer!)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession?.addOutput(dataOutput)
        
        captureSession?.startRunning()
        
    }
    
    func setupVision() {
        // Create a model configuration object
        let configuration = MLModelConfiguration()
        
        do {
            // Load the Core ML model with configuration and error handling
            let model = try VNCoreMLModel(for: MyLife(configuration: configuration).model)
            
            // Create a request with the model
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                self?.handleVisionRequest(request: request, error: error)
            }
            request.imageCropAndScaleOption = .centerCrop
            requests = [request]
            
        } catch {
            print("Failed to load CoreML model: \(error.localizedDescription)")
        }
    }
    
    func setupOverlay() {
        // Add the label to the view
        view.addSubview(recognizedTextLabel)
        
        // Set up constraints to position the label at the top of the screen
        NSLayoutConstraint.activate([
            recognizedTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recognizedTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recognizedTextLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recognizedTextLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func handleVisionRequest(request: VNRequest, error: Error?) {
        if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
            DispatchQueue.main.async { [weak self] in
                self?.recognizedTextLabel.text = "\(topResult.identifier.components(separatedBy: ",").first ?? topResult.identifier)"
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try requestHandler.perform(requests)
        } catch {
            print("Failed to perform Vision request: \(error)")
        }
    }
}
