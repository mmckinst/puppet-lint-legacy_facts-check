require 'spec_helper'

describe 'legacy_facts' do
  let(:msg) { 'legacy fact' }
  context 'with fix disabled' do
    context "fact variable using modern $facts['os']['family'] hash" do
      let(:code) { "$facts['os']['family']" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context "fact variable using modern $facts['ssh']['rsa']['key'] hash" do
      let(:code) { "$facts['ssh']['rsa']['key']" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context "fact variable using legacy $osfamily" do
      let(:code) { "$osfamily" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context "fact variable using legacy $facts['osfamily']" do
      let(:code) { "$facts['osfamily']" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $::osfamily" do
      let(:code) { "$::osfamily" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $::blockdevice_sda_model" do
      let(:code) { "$::blockdevice_sda_model" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $facts['ipaddress6_em2']" do
      let(:code) { "$facts['ipaddress6_em2']" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $::zone_foobar_uuid" do
      let(:code) { "$::zone_foobar_uuid" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $::processor314" do
      let(:code) { "$::processor314" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $::sp_l3_cache" do
      let(:code) { "$::sp_l3_cache" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable using legacy $::sshrsakey" do
      let(:code) { "$::sshrsakey" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end

    context "fact variable in interpolated string \"${::osfamily}\"" do
      let(:code) { '"start ${::osfamily} end"' }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
    end
  end


  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context "fact variable using modern $facts['os']['family'] hash" do
      let(:code) { "$facts['os']['family']" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context "fact variable using modern $facts['ssh']['rsa']['key'] hash" do
      let(:code) { "$facts['ssh']['rsa']['key']" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end
    end

    context "fact variable using legacy $osfamily" do
      let(:code) { "$osfamily" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problem
      end

    end

    context "fact variable using legacy $facts['osfamily']" do
      let(:code) { "$facts['osfamily']" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the problem' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(1)
      end

      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['os']['family']")
      end
    end

    context "fact variable using legacy $::osfamily" do
      let(:code) { "$::osfamily" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the problem' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(1)
      end

      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['os']['family']")
      end
    end

    context "fact variable using legacy $::sshrsakey" do
      let(:code) { "$::sshrsakey" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the problem' do
        expect(problems).to contain_fixed(msg).on_line(1).in_column(1)
      end

      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['ssh']['rsa']['key']")
      end
    end

    context "fact variable using legacy $::memoryfree_mb" do
      let(:code) { "$::memoryfree_mb" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should continue to use the legacy fact' do
        expect(manifest).to eq("$::memoryfree_mb")
      end
    end

    context "fact variable using legacy $::blockdevice_sda_model" do
      let(:code) { "$::blockdevice_sda_model" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['disks']['sda']['model']")
      end
    end

    context "fact variable using legacy $facts['ipaddress6_em2']" do
      let(:code) { "$facts['ipaddress6_em2']" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['networking']['interfaces']['em2']['ip6']")
      end
    end

    context "fact variable using legacy $::zone_foobar_uuid" do
      let(:code) { "$::zone_foobar_uuid" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['solaris_zones']['zones']['foobar']['uuid']")
      end
    end

    context "fact variable using legacy $::processor314" do
      let(:code) { "$::processor314" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['processors']['models'][314]")
      end
    end

    context "fact variable using legacy $::sp_l3_cache" do
      let(:code) { "$::sp_l3_cache" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['system_profiler']['l3_cache']")
      end
    end

    context "fact variable using legacy $::sshrsakey" do
      let(:code) { "$::sshrsakey" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end
      it 'should use the facts hash' do
        expect(manifest).to eq("$facts['ssh']['rsa']['key']")
      end
    end

    context "fact variable in interpolated string \"${::osfamily}\"" do
      let(:code) { '"start ${::osfamily} end"' }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should use the facts hash' do
        expect(manifest).to eq('"start '"${facts['os']['family']}"' end"')
      end
    end
  end
end
