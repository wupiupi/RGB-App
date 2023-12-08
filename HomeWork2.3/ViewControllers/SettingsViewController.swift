//
//  ViewController.swift
//  RGB_App
//
//  Created by Paul Makey on 16.11.23.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var rgbView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Properties
    var colorView: UIView!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rgbView.layer.cornerRadius = 15
        
        /*
        guard let backgroundColor = colorView.backgroundColor else { return }
        if let colorComponents = extractColors(for: backgroundColor) {
            updateRGBview(
                redVal: colorComponents.red,
                greenVal: colorComponents.green,
                blueVal: colorComponents.blue
            )
            redSlider.value = colorComponents.red
            greenSlider.value = colorComponents.green
            blueSlider.value = colorComponents.blue
            
            redLabel.text = roundString(for: colorComponents.red)
            greenLabel.text = roundString(for: colorComponents.green)
            blueLabel.text = roundString(for: colorComponents.blue)
        }
         */
        
        guard let components = colorView.backgroundColor?.components else { return }
        
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
        
        redLabel.text = roundString(for: redSlider.value)
        greenLabel.text = roundString(for: greenSlider.value)
        blueLabel.text = roundString(for: blueSlider.value)
        
        updateRGBview(
            redVal: redSlider.value,
            greenVal: greenSlider.value,
            blueVal: blueSlider.value
        )
    }
    
    // MARK: - IB Actions
    @IBAction func sliderValueHasChanged(_ sender: UISlider) {
        updateRGBview(
            redVal: redSlider.value,
            greenVal: greenSlider.value,
            blueVal: blueSlider.value
        )
        
        switch sender {
        case redSlider:
            redLabel.text = roundString(for: sender.value)
        case greenSlider:
            greenLabel.text = roundString(for: sender.value)
        default:
            blueLabel.text = roundString(for: sender.value)
        }
    }
    
    @IBAction func doneButtonDidTapped() {
        delegate?.setColor(with: rgbView)
        dismiss(animated: true)
    }
    
 }

// MARK: - Private Methods
private extension SettingsViewController {
    
    func roundString(for value: Float) -> String {
        String(format: "%.2f", value)
    }
    
    func updateRGBview(redVal: Float, greenVal: Float, blueVal: Float) {
        rgbView.backgroundColor = UIColor(
            red: CGFloat(redVal),
            green: CGFloat(greenVal),
            blue: CGFloat(blueVal),
            alpha: 1
        )
    }
    
    /*
    func extractColors(for color: UIColor) -> (red: Float, green: Float, blue: Float)? {
        guard let components = color.cgColor.components else { return nil }
        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        
        return (red, green, blue)
    }
     */
}

extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
