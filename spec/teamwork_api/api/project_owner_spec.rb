# frozen_string_literal: true

require 'spec_helper'

describe TeamworkApi::API::ProjectOwner do
  subject { TeamworkApi::Client.new('http://localhost:3000', 'xxx') }

  describe '#project_owner' do
    before do
      stub_get(
        'http://localhost:3000/projects/1.json?project%5B' \
        'include_project_owner%5D=true'
      ).to_return(
        body: fixture('project_owner.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.project_owner(1)
      expect(
        a_get(
          'http://localhost:3000/projects/1.json'
        ).with(
          query: { project: { include_project_owner: true } }
        )
      ).to have_been_made
    end

    it 'returns the project owner' do
      owner = subject.project_owner(1)
      expect(owner).to be_a Hash
    end
  end
end
