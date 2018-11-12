//
//  ConfigurableCell.swift
//  TestApp
//
//  Created by Anton Muratov on 11/9/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import UIKit.UITableViewCell

class ConfigurableCell<T: BaseCellConfiguration>: UITableViewCell {
    func configure(with configuration: T) { }
}
