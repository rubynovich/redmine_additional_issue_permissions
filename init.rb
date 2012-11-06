require 'redmine'

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
  [:issue].each do |cl|
    require "aip_#{cl}_patch"
  end

  [ 
    [Issue, AdditionalIssuePermissionsPlugin::IssuePatch]
  ].each do |cl, patch|
    cl.send(:include, patch) unless cl.included_modules.include? patch
  end
end

Redmine::Plugin.register :redmine_additional_issue_permissions do
  name 'Дополнительные разрешения для задач'
  author 'Roman Shipiev'
  description 'Вводятся новые разрешения для следующих полей: status, start_date, due_date, assigned_to, parent_issue, done_ratio, estimated_hours. Каждое из этих разрешений доступно в двух вариантах: для автора и для исполнителя.'
  version '0.0.4'
  url 'https://github.com/rubynovich/redmine_additional_issue_permissions'
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
