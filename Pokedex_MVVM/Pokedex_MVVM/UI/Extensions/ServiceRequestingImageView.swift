//
//  ServiceRequestingImageView.swift
//  Pokedex_MVVM
//
//  Created by Karl Pfister on 10/19/22.
//

import UIKit

class ServiceRequestingImageView: UIImageView {
    
    let service = APIService()
    
    func fetchImage(using url: URL) {
        let request = URLRequest(url: url)
        service.perform(request) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    self?.setDefaultImage()
                    return
                }
                DispatchQueue.main.async {
                    self?.contentMode = .scaleAspectFill
                    self?.image = image
                }
            case .failure:
                self?.setDefaultImage()
            }
        }
    }
    
    func setDefaultImage() {
        contentMode = .scaleAspectFit
        self.image = UIImage(systemName: "ticket")
    }
}
