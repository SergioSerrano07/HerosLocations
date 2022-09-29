//
//  TableViewCell.swift
//  AppleMaps
//
//  Created by sergio serrano on 29/9/22.
//

import UIKit

protocol ModelDisplayable {
    var photo: URL { get }
    var id: String { get }
    var name: String { get }
    var description: String { get }
    var longitude: Double { get }
    var latitude: Double { get }
}

final class TableViewCell: UITableViewCell {
  
  @IBOutlet weak var heroImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  func set(model: ModelDisplayable) {
    self.nameLabel.text = model.name
    self.descriptionLabel.text = model.description
    self.heroImage.setImage(url: model.photo.absoluteString)
  }

}
