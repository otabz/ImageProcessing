//
//  ViewController.swift
//  ImageProcessing
//
//  Created by Waseel ASP Ltd. on 4/23/17.
//  Copyright © 2017 Waseel ASP Ltd. All rights reserved.
//

import UIKit
import SwiftOCR

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var label: UILabel!
    var imagePicker: UIImagePickerController!
     let ocrInstance   = SwiftOCR()
    
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicked.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        self.ocrInstance.recognize(imagePicked.image!) { [weak self] recognizedString in
           // DispatchQueue.main.async {
                self?.label.text = recognizedString
                print(self?.ocrInstance.currentOCRRecognizedBlobs ?? "Recoginzed Blob is empty")
            //}
        }
    }
    
    func maskImage(image:UIImage?, mask:(UIImage)?)->UIImage{
        
        let imageReference = image?.cgImage
        let maskReference = mask?.cgImage
        
        let imageMask = CGImage(maskWidth: maskReference!.width,
                                height: maskReference!.height,
                                bitsPerComponent: maskReference!.bitsPerComponent,
                                bitsPerPixel: maskReference!.bitsPerPixel,
                                bytesPerRow: maskReference!.bytesPerRow,
                                provider: maskReference!.dataProvider!, decode: nil, shouldInterpolate: true)
        
        let maskedReference = imageReference!.masking(imageMask!)
        
        let maskedImage = UIImage(cgImage:maskedReference!)
        
        return maskedImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

