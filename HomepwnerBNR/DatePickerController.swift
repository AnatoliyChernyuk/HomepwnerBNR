//
//  DatePickerController.swift
//  HomepwnerBNR
//
//  Created by Anatoliy Chernyuk on 1/8/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var item: Item!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(item.dateCreated, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        item.dateCreated = datePicker.date
    }

}
