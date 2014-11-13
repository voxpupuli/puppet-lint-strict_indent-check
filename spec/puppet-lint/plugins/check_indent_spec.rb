require 'spec_helper'

describe 'indent' do
  context 'with fix disabled' do
    context 'and correct indent' do
      let(:code) {
        <<-EOF.gsub(/^ {10}/, '')
          class (
          ) {
            file { 'this':
              ensure  => 'present',
              require => [
                'abc',
                'def',
              ],
            }
          }
        EOF
      }

      it 'should detect no problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'and incorrect indent' do
      let(:code) {
        <<-EOF.gsub(/^ {10}/, '')
          class (
          ) {
            file { 'this':
              ensure  => 'present',
              require => [ 'abc',
                           'def', ],
            }
          }
        EOF
      }

      it 'should detect 1 problems' do
        expect(problems).to have(1).problems
      end
    end
  end
end
