class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # Parse.setApplicationId("fM6NplGC1fMxqLUmWu8xihY9T35uK0JGbWklAbuY", clientKey:"W88e1fP47MoqUjQzReWJlkLYbOXKUS1pq7YYyYc1")

    # rootViewController = UIViewController.alloc.init
    # rootViewController.title = 'signal'
    # rootViewController.view.backgroundColor = UIColor.whiteColor
    # 
    # navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)
    

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    rootviewcontroller = RootViewController.alloc.initWithNibName(nil, bundle: nil)

    @navigation_controller = UINavigationController.alloc.initWithRootViewController(rootviewcontroller)

    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    
    true
  end
  
end
