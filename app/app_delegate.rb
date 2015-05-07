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

    @form = Formotion::Form.new({
          title: "SomeOfUs",
          sections: [{
            title: "Welcome, let's get started!",
            footer: "We will never spam you, or sell your data. Seriously. Ever.",
            rows: [{
              title: "Email",
              key: :email,
              placeholder: "me@mail.com",
              image: "email",
              type: :email,
              auto_correction: :no,
              auto_capitalization: :none,
              input_accessory: :done
            }, {
              title: "First Name",
              key: :email,
              placeholder: "Jonny",
              type: :string,
              auto_correction: :no,
              input_accessory: :done
            }, {
              title: "Last Name",
              key: :email,
              placeholder: "Appleseed",
              type: :string,
              auto_correction: :no,
              input_accessory: :done
            }, {
              title: "Zip",
              key: :number,
              placeholder: "12345",
              type: :number,
              auto_correction: :no,
              auto_capitalization: :none,
              input_accessory: :done
            }]
          }, {
            rows: [{
              title: "Submit",
              type: :submit,
            }]
          }]
        })

        @view_controller = Formotion::FormController.alloc.initWithForm(@form)
        @view_controller.form.on_submit do |form|
          form.active_row && form.active_row.text_field.resignFirstResponder
          alert = UIAlertView.alloc.init
          alert.title = "@form.render"
          alert.message = @form.render.to_s
          alert.addButtonWithTitle("OK")
          alert.show
        end

        @view_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')

        @navigation_controller = UINavigationController.alloc.initWithRootViewController(@view_controller)

        @window.rootViewController = @navigation_controller
        @window.makeKeyAndVisible

    rootviewcontroller = RootViewController.alloc.initWithNibName(nil, bundle: nil)
    
    true
  end
end
