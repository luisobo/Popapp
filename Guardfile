# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'coffeescript', :output => 'public/javascript/compiled' do
  watch(%r{^src/coffeescript/(.+\.coffee)$})
end

guard 'coffeescript', :noop => true, :input => 'spec'