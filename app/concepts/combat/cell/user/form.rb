module Combat::Cell::User
  class Form < Trailblazer::Cell
    include Cell::Erb
    include BootstrapForm::Helper

    def my_fields_for(form, sym, &block)
      form.fields_for sym do |subfields|
        (yield subfields).html_safe
      end
    end
  end
end
