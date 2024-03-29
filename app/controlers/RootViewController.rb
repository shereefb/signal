class RootViewController < UIViewController
  def viewDidLoad
    super
       
    self.view.backgroundColor = UIColor.grayColor
    self.title = "Campaigns"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    @table.dataSource = self
    @table.delegate = self
    @data = []

    @defaults = NSUserDefaults.standardUserDefaults
    show_form if @defaults[:email].nil?
    load_petitions
    
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
      @data.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault,reuseIdentifier:@reuseIdentifier)

    cell.imageView.image = UIImage.imageNamed("placeholder.jpg")
    
    AFMotion::Image.get(@data[indexPath.row]["image_url"]) do |result|
        cell.imageView.image = result.object
    end
    
    cell.textLabel.numberOfLines = 0; 
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap
    cell.textLabel.text = @data[indexPath.row]["title"]
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    letter = @data[indexPath.row]["title"]
    controller = CampaignViewController.alloc.initWithNibName(nil, bundle:nil)
    controller.campaign = @data[indexPath.row]
    self.navigationController.pushViewController(controller, animated:true)
    
  end
  
  def load_petitions
    AFMotion::JSON.get("http://localhost:3000/petitions/index.json") do |response|
          p response.body.to_str
          @data = response.object       
          self.view.addSubview(@table)
    end
  end
  
  def show_form
    
    @form = Formotion::Form.new({
          persist_as: :settings,
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
        
        #TODO: Send data to server
        @defaults[:email]= @form.render[:email]
        
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