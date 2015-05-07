class RootViewController < UIViewController
  def viewDidLoad
    super
    
    self.view.backgroundColor = UIColor.grayColor
    
    @label1 = UILabel.alloc.initWithFrame(CGRectZero)
    @label1.text = "Welcome to SumOfUs mobile."
    @label1.sizeToFit
    @label1.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2) - 250)

    @label2 = UILabel.alloc.initWithFrame(CGRectZero)
    @label2.text = "Enter your email address:"
    @label2.sizeToFit
    @label2.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2) - 225)


    self.view.addSubview @label1
    self.view.addSubview @label2    
  end
end