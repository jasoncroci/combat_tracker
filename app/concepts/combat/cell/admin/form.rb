module Combat::Cell::Admin
  class Form < Trailblazer::Cell
    include Cell::Erb
    include BootstrapForm::Helper
    property :current_turn

    def my_fields_for(form, sym, &block)
      form.fields_for sym do |subfields|
        (yield subfields).html_safe
      end
    end

    def button_text
      current_turn ? "Next" : "Start"
    end
  end
end
