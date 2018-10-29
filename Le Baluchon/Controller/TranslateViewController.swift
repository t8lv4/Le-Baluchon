//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Morgan on 25/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var traduireLabel: UILabel!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Methods
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translateTextField.resignFirstResponder()
        traduireLabel.isEnabled = true
    }
}

// MARK: -

/// Set up UITextFieldDelegate
extension TranslateViewController: UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.translateTextField.delegate = self
        toggleActivityIndicator(shown: false)

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        traduireLabel.isEnabled = false
    }

}

// MARK: - Request

extension TranslateViewController {

    func launchRequest() {



    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        translateTextField.becomeFirstResponder()

        guard let text = translateTextField.text else { return false }
        TranslateService.shared.query(to: GoogleTranslation.url, with: text) { (success, translatedText) in
            print("r::::::::::::")
            print(translatedText as Any)

            if success, let translatedText = translatedText {
                // update display
                self.translateTextField.text = translatedText
            } else {
                // alert
            }
        }

        return true
    }

}



// MARK: Activity Indicator

extension TranslateViewController {

    /// Toggle an activity indicator
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }

}
