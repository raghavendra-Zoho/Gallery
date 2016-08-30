import UIKit
import Cartography
import Photos

extension UIViewController {

  func addChildController(controller: UIViewController) {
    addChildViewController(controller)
    view.addSubview(controller.view)
    controller.didMoveToParentViewController(self)

    controller.view.translatesAutoresizingMaskIntoConstraints = false

    constrain(controller.view) { view in
      view.edges == view.superview!.edges
    }
  }
}

extension UIImageView {

  func loadImage(asset: PHAsset) {
    if tag == 0 {
      image = Bundle.image("gallery_placeholder")
    } else {
      PHImageManager.defaultManager().cancelImageRequest(PHImageRequestID(tag))
    }

    let options = PHImageRequestOptions()

    let id = PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: frame.size,
                                                         contentMode: .AspectFill, options: options)
    { [weak self] image, _ in

      self?.image = image
    }

    tag = Int(id)
  }
}