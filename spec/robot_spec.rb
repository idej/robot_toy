require 'robot'

shared_examples 'not_changed_location' do
  let(:x) { 0 }
  let(:y) { 0 }

  it 'should not change location' do
    expect(robot.location[:x]).to eq(x)
    expect(robot.location[:y]).to eq(y)
  end
end

describe Robot do
  let(:robot) { Robot.new({ x: 5, y: 5}) }

  describe '#place' do
    context 'not placed' do
      it 'with wrong coordinates' do
        robot.place(-1, -1, :south)
        expect(robot.placed).to be_nil
      end

      it 'with wrong direction' do
        robot.place(0, 0, :somewhere)
        expect(robot.placed).to be_nil
      end
    end

    context 'placed' do
      before(:each) do
        robot.place(0, 0, :north)
      end

      it 'set current location' do
        expect(robot.location[:x]).to eq(0)
        expect(robot.location[:y]).to eq(0)
      end

      it 'become placed' do
        expect(robot.placed).to eq(true)
      end
    end
  end

  describe '#move' do
    context 'not placed' do
      it 'do not move' do
        robot.move
        expect(robot.direction_name).to be_nil
      end
    end

    context 'possible move on the table' do
      it 'move to north' do
        robot.place(0, 0, :north)
        robot.move
        expect(robot.location[:x]).to eq(0)
        expect(robot.location[:y]).to eq(1)
      end
    end

    context 'impossible move' do
      it "doesn't move out of the table" do
        robot.place(0, 0, :south)
        robot.move
        expect(robot.location[:x]).to eq(0)
        expect(robot.location[:y]).to eq(0)
      end
    end
  end

  describe '#left' do
    context 'not placed' do
      before(:each) do
        robot.left
      end

      it 'should not turn' do
        expect(robot.direction_name).to be_nil
      end
    end

    context 'directed to north' do
      before(:each) do
        robot.place(0, 0, :north)
        robot.left
      end

      it 'should be directed to west' do
        expect(robot.direction_name).to eq('WEST')
      end

      it_should_behave_like 'not_changed_location'
    end

    context 'directed to west' do
      before(:each) do
        robot.place(0, 0, :west)
        robot.left
      end

      it 'should be directed to south' do
        expect(robot.direction_name).to eq('SOUTH')
      end

      it_should_behave_like 'not_changed_location'
    end

    context 'directed to south' do
      before(:each) do
        robot.place(0, 0, :south)
        robot.left
      end

      it 'should be directed to east' do
        expect(robot.direction_name).to eq('EAST')
      end

      it_should_behave_like 'not_changed_location'
    end

    context 'directed to east' do
      before(:each) do
        robot.place(0, 0, :east)
        robot.left
      end

      it 'should be directed to north' do
        expect(robot.direction_name).to eq('NORTH')
      end

      it_should_behave_like 'not_changed_location'
    end
  end

  describe '#right' do
    context 'not placed' do
      before(:each) do
        robot.right
      end

      it 'should not turn' do
        expect(robot.direction_name).to be_nil
      end
    end

    context 'directed to north' do
      before(:each) do
        robot.place(0, 0, :north)
        robot.right
      end

      it 'should be directed to east' do
        expect(robot.direction_name).to eq('EAST')
      end

      it_should_behave_like 'not_changed_location'
    end
  end
end
