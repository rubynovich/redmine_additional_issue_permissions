require_dependency 'issue'

module IssuePatch
  def self.included(base)
    base.extend(ClassMethods)
    
    base.send(:include, InstanceMethods)
    
    base.class_eval do      
      safe_attributes 'status_id', 
        :if => lambda {|issue, user|
          if user == issue.assigned_to
            user.allowed_to?(:edit_status_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_status_4author, 
              issue.project)
          end
        }
      safe_attributes 'assigned_to_id',
        :if => lambda {|issue, user| 
          if user == issue.assigned_to
            user.allowed_to?(:edit_assigned_to_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_assigned_to_4author, 
              issue.project)
          end
        }
      safe_attributes 'done_ratio',
        :if => lambda {|issue, user|
          if user == issue.assigned_to
            user.allowed_to?(:edit_done_ratio_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_done_ratio_4author, 
              issue.project)
          end
        }
      safe_attributes 'start_date',
        :if => lambda {|issue, user|
          if user == issue.assigned_to
            user.allowed_to?(:edit_start_date_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_start_date_4author, 
              issue.project)
          end
        }
      safe_attributes 'due_date',
        :if => lambda {|issue, user| 
          if user == issue.assigned_to
            user.allowed_to?(:edit_due_date_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_due_date_4author, 
              issue.project)
          end
        }
      safe_attributes 'parent_issue_id',
        :if => lambda {|issue, user|
          if user == issue.assigned_to
            user.allowed_to?(:edit_parent_issue_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_parent_issue_4author, 
              issue.project)
          end
        }
      safe_attributes 'estimated_hours', 
        :if => lambda {|issue, user| 
          if user == issue.assigned_to
            user.allowed_to?(:edit_estimated_hours_4assigned_to, 
              issue.project)
          elsif user == issue.author
            user.allowed_to?(:edit_estimated_hours_4author, 
              issue.project)
          end
        }
    end
  end
    
  module ClassMethods
  end
  
  module InstanceMethods
    def allowed_additional_premissions?(user=User.current)
      %w{status assigned_to done_ratio start_date due_date parent_issue estimated_hours}.any?{ |field|
        (
          (user == self.assigned_to) &&
            (user.allowed_to?(:"edit_#{field}_4assigned_to", self.project))
        ) || (
          (user == self.author) &&
            (user.allowed_to?(:"edit_#{field}_4author", self.project))
        )
      }
    end
    
    def status_allowed?(user=User.current)
      if user == self.author
        user.allowed_to?(:edit_status_4author, self.project)
      elsif user == self.assigned_to
        user.allowed_to?(:edit_status_4assigned_to, self.project)
      else
        self.new_record? || user.allowed_to?(:edit_issues, self.project)
      end
    end
    
    def assigned_to_allowed?(user=User.current)
      if user == self.author
        user.allowed_to?(:edit_assigned_to_4author, self.project)
      elsif user == self.assigned_to
        user.allowed_to?(:edit_assigned_to_4assigned_to, self.project)
      else
        self.new_record? || user.allowed_to?(:edit_issues, self.project)
      end      
    end
    
    def done_ratio_allowed?(user=User.current)
      if user == self.author
        user.allowed_to?(:edit_done_ratio_4author, self.project)
      elsif user == self.assigned_to
        user.allowed_to?(:edit_done_ratio_4assigned_to, self.project)
      else
        self.new_record? || user.allowed_to?(:edit_issues, self.project)
      end      
    end
  end
end
