import UIKit
import AVFoundation

/**
  ImageViewWithGradient: A custom subclass of UIImageView that adds a mask layer on top of the image with a circular cutout in the middle

  :param: inset: set inset to a non-zero value to inset the circular cutout
  :param: image: inherited from UIImageView.
*/
class ImageViewWithGradient: UIImageView
{
  
  //Changing this value invokes layoutSubviews to update the shape layer's path
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
    //Do onetime setup of the shape layer.
    myShapeLayer.opaque = false
    myShapeLayer.fillColor = UIColor(white: 1, alpha: 0.8).CGColor
    myShapeLayer.fillRule = kCAFillRuleEvenOdd
    
    //The line below creates a frame around the view.
    //TODO: Remove the line below if you don't want a frame around your image view.
    myShapeLayer.borderWidth = 1.0
    
    //add our shape layer as a sublayer of the image view's layer.
    self.layer.addSublayer(myShapeLayer)
  }
  
  /**
  Whenever our layout changes, rebuild the path used by the shape layer. 

  This method is also called if the view's inset property is changed.
*/
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

//------------------------------------------------------------
/**
  Global function to create an example image. Click on the "eyeball" to the right of the line below that assigns `aView.image = anImage` to see the resulting custom image.
*/
func createSampleImage()
{
  let anImage = UIImage(named: "Scampers 6685.jpg")
  if let anImage = anImage
  {
    var aView = ImageViewWithGradient(frame: CGRect(x: 0, y: 0, width: anImage.size.width, height: anImage.size.height))
    aView.inset = CGFloat(100.0)
    aView.image = anImage
  }
}

//This is playground-only code that invokes createSampleImage 
//to create a sample ImageViewWithMask
createSampleImage()