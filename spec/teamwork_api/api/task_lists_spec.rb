# frozen_string_literal: true

require 'spec_helper'

describe TeamworkApi::API::TaskLists do
  subject { TeamworkApi::Client.new('http://localhost:3000', 'xxx') }

  describe '#create_task_list' do
    before do
      stub_post(
        'http://localhost:3000/projects/1/tasklists.json'
      ).to_return(
        body: fixture('create_task_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.create_task_list(1, name: 'My list')
      expect(
        a_post('http://localhost:3000/projects/1/tasklists.json')
      ).to have_been_made
    end

    it 'returns the task list id' do
      id = subject.create_task_list(1, name: 'My list')
      expect(id).to eq 1_234
    end
  end

  describe '#task_lists' do
    before do
      stub_get(
        'http://localhost:3000/tasklists.json'
      ).to_return(
        body: fixture('task_lists.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.task_lists
      expect(a_get('http://localhost:3000/tasklists.json')).to have_been_made
    end

    it 'returns the requested task lists' do
      task_lists = subject.task_lists
      expect(task_lists).to be_an Array
      task_lists.each { |tl| expect(tl).to be_a Hash }
    end
  end

  describe '#task_list' do
    before do
      stub_get(
        'http://localhost:3000/tasklists/1.json'
      ).to_return(
        body: fixture('task_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.task_list(1)
      expect(
        a_get('http://localhost:3000/tasklists/1.json')
      ).to have_been_made
    end

    it 'returns a single task list' do
      task_list = subject.task_list(1)
      expect(task_list).to be_a Hash
    end
  end

  describe '#delete_task_list' do
    before do
      stub_delete(
        'http://localhost:3000/tasklists/1.json'
      ).to_return(
        body: fixture('delete.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.delete_task_list(1)
      expect(
        a_delete('http://localhost:3000/tasklists/1.json')
      ).to have_been_made
    end

    it 'returns ok' do
      response = subject.delete_task_list(1)
      expect(response.body).to eq('STATUS' => 'OK')
    end
  end
end
