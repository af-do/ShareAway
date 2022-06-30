//
//  SharedItemTableViewCell.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 30/06/2022.
//

import UIKit

protocol SharedItemTableViewCellDelegate: AnyObject {
    func sharedItemTableViewCellPressedOnClaim(_ cell: SharedItemTableViewCell, item: SharedItem)
}

class SharedItemTableViewCell: UITableViewCell {

    static let identifier = "SharedItemTableViewCell"

    weak var delegate: SharedItemTableViewCellDelegate?

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var claimButton: UIButton!

    private var item: SharedItem?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func claimButtonPressed(_ sender: Any) {
        if let item = item {
            delegate?.sharedItemTableViewCellPressedOnClaim(self, item: item)
        }
    }

    func populate(_ item: SharedItem) {
        self.item = item
        itemName.text = item.itemName
        itemDescription.text = item.itemDescription
        itemDate.text = item.itemUploadDate

        Task.detached {
            if let data = Data(base64Encoded: item.imageBase64String ?? ""),
               let image = UIImage(data: data) {
                await MainActor.run {
                    self.itemImageView.image = image
                }
            }
        }
    }
}
