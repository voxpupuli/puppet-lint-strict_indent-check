# frozen_string_literal: true

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

  context 'misplaced resource semicolons' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    let(:code) do
      <<~EOF
        file {
          default:
            ensure => file,
            owner  => 'root',
            group  => 'wheel',
            mode   => '0600',
            ;
          ['ssh_host_dsa_key', 'ssh_host_key', 'ssh_host_rsa_key']:
            # use all defaults
            ;
          ['ssh_config', 'ssh_host_dsa_key.pub', 'ssh_host_key.pub', 'ssh_host_rsa_key.pub', 'sshd_config']:
            # override mode
            mode => '0644',
        ;
        }
      EOF
    end

    let(:fixed) do
      <<~EOF
        file {
          default:
            ensure => file,
            owner  => 'root',
            group  => 'wheel',
            mode   => '0600',
          ;
          ['ssh_host_dsa_key', 'ssh_host_key', 'ssh_host_rsa_key']:
            # use all defaults
          ;
          ['ssh_config', 'ssh_host_dsa_key.pub', 'ssh_host_key.pub', 'ssh_host_rsa_key.pub', 'sshd_config']:
            # override mode
            mode => '0644',
          ;
        }
      EOF
    end

    it 'detects three problems' do
      expect(problems).to have(3).problem
    end

    it 'fixes the first problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 4').on_line(7).in_column(1)
    end

    it 'fixes the second problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 4').on_line(10).in_column(1)
    end

    it 'fixes the third problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 0').on_line(14).in_column(1)
    end

    it 'moves the semicolons' do
      expect(manifest).to eq fixed
    end
  end

  context 'misaligned heredocs' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    let(:code) do
      <<~EOF
        $over_indented = @(HERE)
            This is a heredoc
            that has been

            indented 4 spaces
               and has some
             internal indenting
            | HERE

        $under_indented = @(HERE)
        This is a heredoc

        that has no
        indent
          and has some
         internal indenting
        | HERE

        $over_indented_interpolated = @("HERE")
            This is a heredoc
            with a ${variable}
            that has been

            indented 4 spaces
               and has some
             internal indenting
            and ${another} variable
            | HERE

        $under_indented_interpolated = @("HERE")
         This is a heredoc
         with a ${variable} with trailing text
         that has been

         indented 1 space
             and has some
               internal indenting
         and ${another} variable
         | HERE
      EOF
    end

    let(:fixed) do
      <<~EOF
        $over_indented = @(HERE)
          This is a heredoc
          that has been

          indented 4 spaces
             and has some
           internal indenting
          | HERE

        $under_indented = @(HERE)
          This is a heredoc

          that has no
          indent
            and has some
           internal indenting
          | HERE

        $over_indented_interpolated = @("HERE")
          This is a heredoc
          with a ${variable}
          that has been

          indented 4 spaces
             and has some
           internal indenting
          and ${another} variable
          | HERE

        $under_indented_interpolated = @("HERE")
          This is a heredoc
          with a ${variable} with trailing text
          that has been

          indented 1 space
              and has some
                internal indenting
          and ${another} variable
          | HERE
      EOF
    end

    it 'detects four problems' do
      expect(problems).to have(4).problem
    end

    it 'fixes the first problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 4').on_line(2).in_column(1)
    end

    it 'fixes the second problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 0').on_line(11).in_column(1)
    end

    it 'fixes the third problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 4').on_line(20).in_column(1)
    end

    it 'fixes the forth problem' do
      expect(problems).to contain_fixed('indent should be 2 chars and is 1').on_line(31).in_column(1)
    end

    it 'moves the heredoc' do
      expect(manifest).to eq fixed
    end
  end
end
