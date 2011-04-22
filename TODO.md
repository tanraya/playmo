# TODO
- Integrates with jammit
- Add content for sidebar
- Add links to devise controllers into layout
- Add name column to users table
- Add scoped_link_to helper
- Add footer content
- Modify default layout styles
* Add styles for formtastic
* Transform boilerplate & other styles to scss
- Templates customizing (http://zigzag.github.com/2010/01/18/customizing-your-scaffold-template-become-easier-in-rails3.html)
- Create an html5 simple template and rails application to develop playmo gem
- Add link to homepage into "Welcome to abroad!"
- Add default users into seeds
- Generate assets.yml
- Modify compass.rb
- initialize git repository
- add capistrano and capify!
- https://gist.github.com/280196/5c075f4a3d3a4118d1d706fce07e40572a3873c7
- Remove scss files from public after deploy. Create special task for it.
* Add dynamic processing for 500, 404, 422 errors
* Generate models with useful comments that define code order (like: associations, validations, constants, etc.)
- That's what I need to customize generators templates: http://www.railsdispatch.com/posts/building-or-updating-a-rails-3-plugin
* Replace default forms by formtastic or simple_form
* Generate HomesController in rails3 style
* Do not copy playmo & boilerplate css styles into app - keep its inside gem
* Include google code into layout and copy google.yml into config dir


## Big changes:
* Move boilerplate & playmo stylesheets into gem, do not copy into new app!
* Move screen, print, layout, wysiwyg stylesheets into public/stylesheets.
* Split boilerplate stylesheet on 2 files: screen and print
* Import boilerplate screen, playmo, layout stylesheets into screen (on top of file).
* Import boilerplate screen, print, playmo, layout stylesheets into print (on top of file)
* Import boilerplate screen, print, playmo stylesheets into wysiwyg (on top of file)


