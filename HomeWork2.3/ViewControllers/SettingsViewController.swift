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
        updateUI()
       
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    // MARK: - IB Actions
    @IBAction func sliderValueHasChanged(_ sender: UISlider) {
        updateRGBview(
            redVal: redSlider.value,
            greenVal: greenSlider.value,
            blueVal: blueSlider.value
        )
        
        let roundedValue = roundString(for: sender.value)
        
        switch sender {
        case redSlider:
            redLabel.text = roundedValue
            redTextField.text = roundedValue
        case greenSlider:
            greenLabel.text = roundedValue
            greenTextField.text = roundedValue
        default:
            blueLabel.text = roundedValue
            blueTextField.text = roundedValue
        }
    }
    
    @IBAction func doneButtonDidTapped() {
        delegate?.setColor(with: rgbView)
        dismiss(animated: true)
    }
    
    // MARK: - Public Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
    
    func updateUI() {
        guard let components = colorView.backgroundColor?.components else { return }
        
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
        
        redLabel.text = roundString(for: redSlider.value)
        greenLabel.text = roundString(for: greenSlider.value)
        blueLabel.text = roundString(for: blueSlider.value)
        
        redTextField.text = redLabel.text
        greenTextField.text = greenLabel.text
        blueTextField.text = blueLabel.text
        
        updateRGBview(
            redVal: redSlider.value,
            greenVal: greenSlider.value,
            blueVal: blueSlider.value
        )
    }
}

extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        /*
         В вашем коде, метод getRed(_:green:blue:alpha:) вызывается с использованием передачи параметров по ссылке (&red, &green, &blue, &alpha). Это означает, что метод будет пытаться заполнить переданные параметры значениями компонентов цвета, и если это удастся, он вернет true, иначе вернет false.
         
         Метод извлекает цвета из UIColor и, если это получается, возвращает тру и заполняет переменные значениями
         */
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text,
              let floatText = Float(text) else { return }
        
        if !(0.0...1.0).contains(floatText) {
            showInvalidInputAlert(title: "Error.", message: "Invald input.\nValid input: 0.0 - 1.0") {
                textField.text = nil
            }
            return
        }
        
        switch textField {
            case redTextField:
                redSlider.setValue(floatText, animated: true)
                redLabel.text = roundString(for: redSlider.value)
            case greenTextField: 
                greenSlider.setValue(floatText, animated: true)
                greenLabel.text = roundString(for: greenSlider.value)
            default:
                blueSlider.setValue(floatText, animated: true)
                blueLabel.text = roundString(for: blueSlider.value)
        }
        
        updateRGBview(
            redVal: redSlider.value,
            greenVal: greenSlider.value,
            blueVal: blueSlider.value
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Alert Controller
private extension SettingsViewController {
    func showInvalidInputAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let alertAction = UIAlertAction(
            title: "Close",
            style: .default) { _ in
                completion?()
            }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
