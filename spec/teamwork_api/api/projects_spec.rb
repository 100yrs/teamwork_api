# frozen_string_literal: true

require 'spec_helper'

describe TeamworkApi::API::Projects do
  subject { TeamworkApi::Client.new('http://localhost:3000', 'xxx') }

  describe '#create_project' do
    before do
      stub_post(
        'http://localhost:3000/projects.json'
      ).to_return(
        body: fixture('create_project.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.create_project(name: 'My Project')
      expect(a_post('http://localhost:3000/projects.json')).to have_been_made
    end

    it 'returns the project id' do
      id = subject.create_project(name: 'My Project')
      expect(id).to eq 323_605
    end
  end

  describe '#update_project' do
    before do
      stub_put(
        'http://localhost:3000/projects/1.json'
      ).to_return(
        body: fixture('update.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.update_project(1, name: 'My renamed Project')
      expect(a_put('http://localhost:3000/projects/1.json')).to have_been_made
    end

    it 'returns ok' do
      response = subject.update_project(1, name: 'My renamed Project')
      expect(response.body).to eq('STATUS' => 'OK')
    end
  end

  describe '#projects' do
    before do
      stub_get(
        'http://localhost:3000/projects.json'
      ).to_return(
        body: fixture('projects.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.projects
      expect(a_get('http://localhost:3000/projects.json')).to have_been_made
    end

    it 'returns the requested projects' do
      projects = subject.projects
      expect(projects).to be_an Array
      projects.each { |g| expect(g).to be_a Hash }
    end
  end

  describe '#project' do
    before do
      stub_get(
        'http://localhost:3000/projects/1.json'
      ).to_return(
        body: fixture('project.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.project(1)
      expect(
        a_get('http://localhost:3000/projects/1.json')
      ).to have_been_made
    end

    it 'returns a single project' do
      project = subject.project(1)
      expect(project).to be_a Hash
    end
  end

  describe '#delete_project' do
    before do
      stub_delete(
        'http://localhost:3000/projects/1.json'
      ).to_return(
        body: fixture('delete.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.delete_project(1)
      expect(
        a_delete('http://localhost:3000/projects/1.json')
      ).to have_been_made
    end

    it 'returns ok' do
      response = subject.delete_project(1)
      expect(response.body).to eq('STATUS' => 'OK')
    end
  end
end
