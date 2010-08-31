# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def selected_li(content, path)
    selected = current_page?(path) ? 'class="selected"' : ''
    "<li #{selected}>#{link_to content, path }</li>"
  end
  
  def selected_menu(content, path, submenu)
    "<li class='selected'>
      <span class='selected-arrow'></span>
      #{ link_to content, path }
      <ul>
         #{selected_li('Index', path) }
         #{selected_li("New #{content}", submenu) }
      </ul>
    </li>"
  end
  
end
