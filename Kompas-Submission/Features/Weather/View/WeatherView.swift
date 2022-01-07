//
//  WeatherPage.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidLabel: UILabel!
    
    @IBOutlet weak var sunriseCard: UIView!
    @IBOutlet weak var sunsetCard: UIView!
    @IBOutlet weak var windCard: UIView!
    @IBOutlet weak var pressureCard: UIView!
    @IBOutlet weak var humidCard: UIView!
    @IBOutlet weak var infoCard: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        contentView.frame = self.bounds
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = .white
        sunriseCard.roundCorner(withRadius: 8)
        sunsetCard.roundCorner(withRadius: 8)
        windCard.roundCorner(withRadius: 8)
        pressureCard.roundCorner(withRadius: 8)
        humidCard.roundCorner(withRadius: 8)
        infoCard.roundCorner(withRadius: 8)
        
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
