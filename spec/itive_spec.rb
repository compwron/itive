  require_relative '../lib/itive'
  require 'timecop'

  describe Itive do
    subject { Itive.new }
    it 'returns no data for um if no data added' do
      expect(subject.data?('um')).to eq 0
    end

    it 'returns data for um if one data added' do
      subject.data('um')
      expect(subject.data?('um')).to eq 1
    end

    it 'returns data for um if two data added' do
      subject.data('um')
      subject.data('um')
      expect(subject.data?('um')).to eq 2
    end

    it 'returns data snapshot at specified time' do
      Timecop.freeze(Time.parse('1999-1-1')) do
        subject.data('um')
        subject.data('um')
      end

      Timecop.freeze(Time.parse('2000-1-1')) do
        subject.data('um')
      end

      expect(subject.data?('um', Time.parse('1999-1-2'))).to eq 2
      expect(subject.data?('um', Time.parse('2000-1-2'))).to eq 3
    end

    it 'returns data for reqquested datum only if data for um and qw are both added' do
      subject.data('um')
      subject.data('qw')
      subject.data('qw')
      expect(subject.data?('um')).to eq 1
      expect(subject.data?('qw')).to eq 2
    end
  end
