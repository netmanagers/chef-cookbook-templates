require 'spec_helper'

describe 'xxx_template_xxx program' do

  it 'should have xxx_template_xxx package installed on Ubuntu and binary on others OS' do
    case RSpec.configuration.os[:family]
    when "Ubuntu"
      expect(package 'xxx_template_xxx').to be_installed
    else
      expect(command 'which xxx_template_xxx').to return_stdout /\/usr\/bin\/xxx_template_xxx/
    end
  end
end
