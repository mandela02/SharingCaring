//
//  SideMenuHeaderView.swift
//  SharingCaring
//
//  Created by TriBQ on 9/27/20.
//

import UIKit

protocol HeaderDelegate: class {
    func didTapHeader()
}

class SideMenuHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!

    weak var delegate: HeaderDelegate?

    override func prepareForReuse() {
        generateGesture()
    }

    private func generateGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        containerView.addGestureRecognizer(gesture)
    }

    func createHeader(isExpanded: Bool) {
        nameLabel.text = "Category"
        if isExpanded {
            arrowImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }
    }

    @objc private func didTap() {
        delegate?.didTapHeader()
    }
}
