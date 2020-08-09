//
//  UIViewController+ErrorHandling.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 09.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showError(_ error: Error ) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
