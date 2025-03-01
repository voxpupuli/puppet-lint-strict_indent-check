require 'spec_helper'

describe 'strict_indent' do
  before do
    # disable all other checks
    PuppetLint.configuration.checks.reject do |check|
      check == :indent
    end.each do |check|
      PuppetLint.configuration.send(:"disable_#{check}")
    end
  end

  after do
    # re-enable other checks
    PuppetLint.configuration.checks.reject do |check|
      check == :indent
    end.each do |check|
      PuppetLint.configuration.send(:"enable_#{check}")
    end
  end

  context 'on manifest' do
    Dir['spec/fixtures/pass/*'].each do |manifest|
      context manifest do
        let(:code) { File.read(manifest) }

        it 'detects no problems' do
          expect(problems).to have(0).problems
        end
      end
    end

    Dir['spec/fixtures/fail/*'].each do |manifest|
      context manifest do
        let(:code) { File.read(manifest) }

        it 'detects problems' do
          expect(problems).to have(1).problems
        end
      end
    end
  end

  context 'comment after resource title.' do
    let(:code) do
      <<-EOF.gsub(/^ {8}/, '')
        class (
        ) {
          file {
            'this': #comment
              ensure  => 'present',
          }
        }
      EOF
    end

    it 'detects 0 problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'invalid array indent' do
    let(:code) do
      <<-EOF.gsub(/^ {8}/, '')
        class (
        ) {
          file { 'this':
            ensure  => 'present',
            require => [ 'abc',
                         'def', ],
          }
        }
      EOF
    end

    it 'detects 1 problems' do
      expect(problems).to have(1).problems
    end
  end

  context 'blank line at beginning of file' do
    let(:code) do
      <<-EOF.gsub(/^ {8}/, '')

        class () {}
      EOF
    end

    it 'detects 0 problems' do
      expect(problems).to have(0).problems
    end
  end
end
