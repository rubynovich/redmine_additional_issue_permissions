require 'redmine'

Redmine::Plugin.register :redmine_additional_issue_permissions do
  name 'Redmine Additional Issue Permissions plugin'
  author 'Roman Shipiev'
  description 'Redmine plugin for add 14 new issue permissions (edit)'
  version '0.0.1'
  url 'https://github.com/rubynovich/redmine_secretary'
  author_url 'http://roman.shipiev.me'
  
  project_module :issue_tracking do
    permission :edit_status_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_status_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_start_date_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_start_date_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_due_date_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_due_date_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_assigned_to_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_assigned_to_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
         
    permission :edit_parent_issue_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_parent_issue_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_done_ratio_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_done_ratio_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_estimated_hours_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_estimated_hours_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
  end  
end
