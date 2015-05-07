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

    #TODO: Check if we have persisted email first
    show_form
    
    load_petitions
    
  end
  
  def load_petitions
    AFMotion::JSON.get("http://localhost:3000/petitions/index.json") do |response|
          p response.body.to_str
    end
  end
  
  def show_form
    
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
              key: :first,
              placeholder: "Jonny",
              type: :string,
              auto_correction: :no,
              input_accessory: :done
            }, {
              title: "Last Name",
              key: :last,
              placeholder: "Appleseed",
              type: :string,
              auto_correction: :no,
              input_accessory: :done
            }, {
              title: "Zip",
              key: :zip,
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

      @form_controller = Formotion::FormController.alloc.initWithForm(@form)
      @form_controller.form.on_submit do |form|
        form.active_row && form.active_row.text_field.resignFirstResponder
        self.dismissViewControllerAnimated(true, completion:lambda {})
        
        #TODO: Persist data
        
        BW::UIAlertView.new({
          title: 'Thanks!',
          message: "We just sent you an email to #{@form.render[:email]}. Go get it to confirm your adress.",
          buttons: ['OK'],
          cancel_button_index: 0
        }) do |alert|
            puts 'They want more!'
        end.show
        
        # alert = UIAlertView.alloc.init
        #         alert.title = "@form.render"
        #         alert.message = @form.render.to_s
        #         alert.addButtonWithTitle("OK")
        #         alert.show
      end

    @form_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@form_controller)
     
    self.presentViewController(@navigation_controller,
    animated:true,
    completion: lambda {})    
    
  end
end