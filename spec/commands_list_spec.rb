require 'commands_list'

describe CommandsList do
  let(:commands_list) { CommandsList.new('file_name.txt', { x: 5, y: 5 }) }

  describe '#parse_command' do
    it 'should ignore commands before PLACE' do
      commands_list.send(:parse_command, 'MOVE')
      commands_list.send(:parse_command, 'LEFT')
      commands_list.send(:parse_command, 'RIGHT')
      expect(commands_list.commands).to eq([])
    end

    it 'should ignore PLACE with wrong location' do
      commands_list.send(:parse_command, 'PLACE -1,-1,SOUTH')
      expect(commands_list.commands).to eq([])
    end

    it 'should ignore PLACE with location higher than size' do
      commands_list.send(:parse_command, 'PLACE 7,0,SOUTH')
      expect(commands_list.commands).to eq([])
    end

    it 'should parse PLACE command' do
      commands_list.send(:parse_command, 'PLACE 3,0,SOUTH')
      expect(commands_list.commands).to eq([{ command: :place, x: 3, y: 0, direction: :south}])
    end

    it 'should parse other commands after right PLACE' do
      commands_list.send(:parse_command, 'PLACE 3,0,SOUTH')
      commands_list.send(:parse_command, 'MOVE')
      commands_list.send(:parse_command, 'LEFT')
      commands_list.send(:parse_command, 'RIGHT')
      commands_list.send(:parse_command, 'REPORT')
      expected_result = [{ command: :place, x: 3, y: 0, direction: :south}, :move, :left, :right, :report]
      expect(commands_list.commands).to eq(expected_result)
    end

    it 'should contain error if wrong direction' do
      commands_list.send(:parse_command, 'PLACE 3,0,SOMEWHERE')
      expect(commands_list.error).to eq("Unknow command: PLACE 3,0,SOMEWHERE")
    end

    it 'should contain error if wrong command' do
      commands_list.send(:parse_command, 'UP')
      expect(commands_list.error).to eq("Unknow command: UP")
    end
  end
end
