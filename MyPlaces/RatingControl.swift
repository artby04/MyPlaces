//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Artyom on 7.07.21.
//  Copyright © 2021 Artyom Yarmoluk. All rights reserved.

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    var rating = 0 {
        didSet{
            updateButtonSelectionState()
        }
    }
    
    // MARK: Props
    
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44, height: 44) { didSet { setupButtons() } }
    @IBInspectable var starCount: Int = 5 { didSet { setupButtons() } }
    
    
    
    // MARK: INIT

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button action
    
    @objc func ratingButtonTap(button: UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        // Calc the rating of selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    // MARK: Private Methods
    
    private func setupButtons () {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load button image
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar",
                                      in: bundle,
                                      compatibleWith: self.traitCollection)
        
        for _ in 1...starCount {
            // Create buttons
            let button = UIButton()
            
            // Set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .focused)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            // Constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button action
            
            button.addTarget(self, action: #selector(ratingButtonTap(button:)), for: .touchUpInside)
            
            // Add to the stack
            addArrangedSubview(button)
            
            // Add to array
            ratingButtons.append(button)
        }
        
      updateButtonSelectionState()
        
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
}
