# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rubocop, all_on_start: false, cli: ['--display-cop-names'] do
  watch(/.+\.(rb|rake)$/)
  watch(%r{(?:.+/)?\.rubocop(_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
