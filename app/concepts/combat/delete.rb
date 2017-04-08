class Combat::Delete < Trailblazer::Operation
  include Rails.application.routes.url_helpers

  step Macro::AdminPolicy()
  step Model(Combat, :find_by)
  step :delete!
  success :broadcast!

  def delete!(options,model:,**)
    model.destroy
  end

  def broadcast!(options,**)
    ActionCable.server.broadcast "combat_channel", url: root_path
  end
end
