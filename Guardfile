guard :rspec, all_after_pass: false,
              cmd: 'rspec' do
  watch( 'spec/spec_helper.rb' ) { "spec" }
  watch( %r{^lib/(.+)\.rb$} ) { |m| "spec/#{m[1]}_spec.rb" }
  watch( %r{^spec/.+_spec\.rb$} )
end
