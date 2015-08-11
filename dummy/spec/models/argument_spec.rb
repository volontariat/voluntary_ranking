require 'spec_helper'

describe 'Argument' do
  describe '.create_with_topic' do
    context 'topic_name is blank' do
      it 'returns an error' do
        Argument.create_with_topic(topic_name: '').should == { errors: { topic: { name: ["can't be blank"] } }}
      end
    end

    context 'topic does not exist' do
      it 'creates a new topic' do
        expect do 
          Argument.create_with_topic(topic_name: 'Dummy', thing_id: FactoryGirl.create(:thing).id, value: 'Dummy')
        end.to change{ArgumentTopic.count}
      end
    end
    
    context 'topic already exists' do
      it 'creates no new topic' do
        topic = FactoryGirl.create(:argument_topic, name: 'Dummy')
        
        expect do 
          Argument.create_with_topic(topic_name: 'Dummy', thing_id: FactoryGirl.create(:thing).id, value: 'Dummy')
        end.to_not change{ArgumentTopic.count}
      end
    end
    
    context 'argument invalid' do
      it 'returns an error' do
        response = Argument.create_with_topic(topic_name: 'Dummy', value: 'Dummy')
        
        response[:errors][:thing_id].should == ["can't be blank"]
      end
    end
  end
end