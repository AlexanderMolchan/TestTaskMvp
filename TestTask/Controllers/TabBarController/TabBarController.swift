//
//  TabBarController.swift
//  TestTask
//
//  Created by Александр Молчан on 3.04.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarConfiguration()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              tabBar.subviews.count > index + 1,
              let imageView = tabBar.subviews[index + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
        imageView.layer.add(bounceAnimation, forKey: nil)
        hapticAlternative()
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.3, 0.9, 1.0]
        bounceAnimation.duration = 0.3
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    private func hapticAlternative() {
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
    }
    
    private func tabbarConfiguration() {
        let mainVc = MainViewController()
        let contactsVc = ContactsViewController()
        let profileVc = ProfileViewController()
        let basketVc = BasketViewController()
        viewControllers = [mainVc, contactsVc, profileVc, basketVc]
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        tabBar.unselectedItemTintColor = .lightGray
        
        mainVc.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "Menu3x"), tag: 0)
        contactsVc.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(named: "Contacts3x"), tag: 1)
        profileVc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Person3x"), tag: 2)
        basketVc.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(named: "Basket3x"), tag: 3)
    }
}
