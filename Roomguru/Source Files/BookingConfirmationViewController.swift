//
//  BookingConfirmationViewController.swift
//  Roomguru
//
//  Created by Radoslaw Szeja on 30/03/15.
//  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

class BookingConfirmationViewController: UIViewController {
    
    let viewModel: BookingConfirmationViewModel
    private weak var aView: BookingConfirmationView?
    
    init(viewModel: BookingConfirmationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        aView = loadViewWithClass(BookingConfirmationView.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = viewModel.title
        
        aView?.moreMinutesButton.enabled = viewModel.canAddMinutes()
        aView?.summaryTextField.delegate = self
        
        updateActualBookingTimeLabel()
        connectActions()
    }
}

// MARK: Actions

extension BookingConfirmationViewController {
    
    func didTapConfirmButton(sender: UIButton) {
        dismissViewControllerAnimated(true) { [weak self] in
            self?.viewModel.confirmBooking()
        }
    }
    
    func didTapCancelButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTapLessMinutesButton(sender: UIButton) {
        viewModel.addBookingTimeMinutes(-15)
        updateActualBookingTimeLabel()
        
        sender.enabled = viewModel.canSubstractMinutes()
        aView?.moreMinutesButton.enabled = viewModel.canAddMinutes()
    }
    
    func didTapMoreMinutesButton(sender: UIButton) {
        viewModel.addBookingTimeMinutes(15)
        updateActualBookingTimeLabel()
        
        sender.enabled = viewModel.canAddMinutes()
        aView?.lessMinutesButton.enabled = viewModel.canSubstractMinutes()
    }
}


// MARK: UITextFieldDelegate

extension BookingConfirmationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        viewModel.summary = textField.text
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Private

private extension BookingConfirmationViewController {
    
    func updateViewForValidationResult(result: Bool) {
        if result {
            aView?.removeErrorFromSummaryTextField()
            aView?.confirmButton.backgroundColor = .ngOrangeColor()
        } else {
            aView?.markErrorOnSummaryTextField()
            aView?.confirmButton.backgroundColor = .lightGrayColor()
        }
        
        aView?.confirmButton.enabled = result
    }
    
    func connectActions() {
        aView?.confirmButton.enabled = false
        aView?.confirmButton.addTarget(self, action: Selector("didTapConfirmButton:"))
        aView?.cancelButton.addTarget(self, action: Selector("didTapCancelButton:"))
        aView?.lessMinutesButton.addTarget(self, action: Selector("didTapLessMinutesButton:"))
        aView?.moreMinutesButton.addTarget(self, action: Selector("didTapMoreMinutesButton:"))
    }

    func updateActualBookingTimeLabel() {
        let duration = viewModel.bookingTimeDuration()
        aView?.minutesToBookLabel.text = "\(Int(duration/60))"
    }
}
