import UIKit
import AVFoundation


class ImageViewWithGradient: UIImageView
{
  var inset: CGFloat = 0
    {
    didSet
    {
      self.layoutSubviews()
    }
  }
  
  let myShapeLayer = CAShapeLayer()
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    self.setup()
  }
  
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    self.setup()
  }
  
  func setup()
  {
    self.layer.addSublayer(myShapeLayer)
    myShapeLayer.opaque = false
    myShapeLayer.fillColor = UIColor(white: 1, alpha: 0.8).CGColor
    myShapeLayer.fillRule = kCAFillRuleEvenOdd
    
    //The line below creates a frame around the view. 
    //Remove it if you don't want a frame
    myShapeLayer.borderWidth = 1.0
  }
  
  override func layoutSubviews()
  {
    var frame = self.layer.bounds
    myShapeLayer.frame = frame
    let smallest = min(frame.size.height, frame.size.width) - inset
    let square = CGRect(
      x: (frame.size.width - smallest)/2.0,
      y: (frame.size.height - smallest)/2.0,
      width: smallest,
      height: smallest)
    var path = UIBezierPath(rect: frame)
    path.appendPath(UIBezierPath(ovalInRect:  square))
    path.closePath()
    myShapeLayer.path = path.CGPath
  }
}

//Global code to create an example image. Click on the "eyeball" to the right of 
//the line below that assigns aView.image = anImage to see the resulting custom image.

let anImage = UIImage(named: "Scampers 6685.jpg")
if let anImage = anImage
{
  var aView = ImageViewWithGradient(frame: CGRect(x: 0, y: 0, width: anImage.size.width, height: anImage.size.height))
  aView.inset = CGFloat(100.0)
  aView.image = anImage
}
