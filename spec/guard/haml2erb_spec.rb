require 'spec_helper'

describe Guard::Haml2Erb do
  subject { Guard::Haml2Erb.new }
  
  describe 'run all' do
    it 'should rebuild all files being watched' do
      Guard::Haml2Erb.stub(:run_on_change).with([]).and_return([])
      Guard.stub(:guards).and_return([subject])
      subject.run_all
    end
  end
  
  describe '#get_output' do
    context 'by default' do
      it 'should return test/index.html.haml as test/index.html.erb' do
        subject.get_output('test/index.html.haml').should eq('test/index.html.erb')
      end
      
      it 'should return test/index.htm.haml as test/index.htm.erb' do
        subject.get_output('test/index.htm.haml').should eq('test/index.htm.erb')
      end
    end
    
    context 'when the output option is set to "demo/output"' do
      before do
        subject.options[:output] = 'demo/output'
      end
      
      it 'should return test/index.html.haml as demo/output/test/index.html.erb' do
        subject.get_output('test/index.html.haml').should eq('demo/output/test/index.html.erb')
      end
    end
    
    context 'when the exclude_base_dir option is set to "test/ignore"' do
      before do
        subject.options[:input] = 'test/ignore'
      end
      
      it 'should return test/ignore/index.html.haml as index.html' do
        subject.get_output('test/ignore/index.html.haml').should eq('index.html.erb')
      end
      
      context 'when the output option is set to "demo/output"' do
        before do
          subject.options[:output] = 'demo/output'
        end
        
        it 'should return test/ignore/abc/index.html.haml as demo/output/abc/index.html.erb' do
          subject.get_output('test/ignore/abc/index.html.haml').should eq('demo/output/abc/index.html.erb')
        end
      end
    end
  end
  
  describe 'building haml to erb' do
    it 'should notify other guards upon completion' do
      other_guard = mock('guard')
      other_guard.should_receive(:watchers).and_return([])
      Guard.stub(:guards).and_return([subject, other_guard])
      subject.notify([])
    end
  end  
end
