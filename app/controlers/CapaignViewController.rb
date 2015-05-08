class CampaignViewController < UIViewController
  attr_accessor :campaign
  
  def viewDidLoad
    super
       
    self.view.backgroundColor = UIColor.whiteColor
    self.title = @campaign["title"]
    self.view = UIWebView.alloc.init
    self.view.loadRequest(
      NSURLRequest.requestWithURL(NSURL.URLWithString(@campaign["signing_url"]))
    )
    self.view.stringByEvaluatingJavaScriptFromString("alret('hi')")
    
  end
end
