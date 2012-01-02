# TODO
- Add scoped_link_to helper

recipe :js_framework do
  after :forms
  description 'Javascript Framework'

  question "Please choose JS framework you prefer to install" do
    answer "JQuery (with Jquery UI)"   => :install_jquery, :default => true
    answer "Mootools Core (with More)" => :install_mootools
  end

  def install_jquery

  end

  def install_mootools

  end
end

recipe :js_framework do
  description 'Javascript Framework'

  question "Please choose JS framework you prefer to install" do
    answer "JQuery (with Jquery UI)", :default => true do
      
    end

    answer "Mootools Core (with More)" do
      
    end
  end
end

recipe :js_framework do
  description 'Javascript Framework'

  question "Would you like to use Mootools?" do
    gem 'mootools-rails'
  end
end

recipe :locale do
  description 'Default locale'

  request "Please specify locale you prefer (en, de, ru, etc.)", :default => :en do |locale|
    # Do something with 'locale' variable
  end
end

!!! RECIPES ORDER IS IMPORTANT !!!

## Methods

git - before_exif
gem - after_install
generate - after_install


## What a gems
* will_paginate or kaminari
* dragonfly or paperclip
* simple_form or formtastic
* cancan or (?)
* devise or authlogic
* meta_where
* carrierwave or (?)
* nifty_generators or rails3-generators (?)

## What next
* Add default user when install devise or authlogic.
* Replace default form generator with simple_form or formtastic generator
* Configure dragonfly (like in lowjob). Also we can create polymorphic Image model
* CSS styles for will_paginate or kaminari pagination
* CSS styles for devise templates
* Configure generators in application.rb

=== Forms

1. simple_form
2. formtastic

Enter number you choice (or press 'n' to skip): 

=== Pagination

1. will_paginate
2. kaminari

=== Generators
=== Authentification
=== Authorization
=== Image processing
=== Uploads

