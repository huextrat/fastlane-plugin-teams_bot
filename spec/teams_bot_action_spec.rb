describe Fastlane::Actions::TeamsBotAction do
  describe '.run' do
    let(:params) do
      {
        teams_url: 'https://example.test/workflows/hook?api-version=1&sig=secret',
        theme_color: '321244',
        title: 'Release ready',
        summary: 'CI passed',
        activity_title: 'Fastlane',
        activity_subtitle: 'main',
        activity_image: 'https://example.test/icon.png',
        text: 'Version 1.1.0',
        facts: [{ 'name' => 'Environment', 'value' => 'Production' }],
        use_markdown: true
      }
    end

    it 'sends a MessageCard payload to the configured webhook' do
      expected_payload = {
        '@type' => 'MessageCard',
        '@context' => 'http://schema.org/extensions',
        'themeColor' => '321244',
        'title' => 'Release ready',
        'summary' => 'CI passed',
        'sections' => [{
          'activityTitle' => 'Fastlane',
          'activitySubtitle' => 'main',
          'activityImage' => 'https://example.test/icon.png',
          'text' => 'Version 1.1.0',
          'facts' => [{ 'name' => 'Environment', 'value' => 'Production' }],
          'markdown' => true
        }]
      }

      expect(described_class).to receive(:send_message).with(params[:teams_url], expected_payload).and_return(true)

      expect(described_class.run(params)).to be(true)
    end
  end

  describe '.send_message' do
    let(:http) { instance_double(Net::HTTP) }
    let(:response) { instance_double(Net::HTTPResponse, code: '202', body: nil) }

    before do
      allow(Net::HTTP).to receive(:new).with('example.test', 443).and_return(http)
      allow(http).to receive(:use_ssl=).with(true)
    end

    it 'preserves the query parameters required by Power Automate' do
      expect(http).to receive(:post).with(
        '/workflows/hook?api-version=1&sp=%2Ftriggers%2Fmanual%2Frun&sig=secret',
        '{"title":"Hello"}',
        { 'Content-Type' => 'application/json' }
      ).and_return(response)
      expect(Fastlane::UI).to receive(:message).with('🍾 The message was sent successfully')

      result = described_class.send_message(
        'https://example.test/workflows/hook?api-version=1&sp=%2Ftriggers%2Fmanual%2Frun&sig=secret',
        { 'title' => 'Hello' }
      )

      expect(result).to be(true)
    end
  end

  describe '.is_message_success' do
    it 'accepts the legacy connector HTTP 200 response' do
      response = instance_double(Net::HTTPResponse, code: '200', body: '1')
      expect(Fastlane::UI).to receive(:message).with('🍾 The message was sent successfully')

      expect(described_class.is_message_success(response)).to be(true)
    end

    it 'accepts the Power Automate HTTP 202 response without a body' do
      response = instance_double(Net::HTTPResponse, code: '202', body: nil)
      expect(Fastlane::UI).to receive(:message).with('🍾 The message was sent successfully')

      expect(described_class.is_message_success(response)).to be(true)
    end

    it 'reports the status and body when the webhook rejects the request' do
      response = instance_double(Net::HTTPResponse, code: '403', body: 'Forbidden')
      expect(Fastlane::UI).to receive(:user_error!).with('⚠️ An error occurred (Status 403): Forbidden')

      described_class.is_message_success(response)
    end

    it 'handles an error response without a body' do
      response = instance_double(Net::HTTPResponse, code: '500', body: nil)
      expect(Fastlane::UI).to receive(:user_error!).with('⚠️ An error occurred (Status 500): No response body')

      described_class.is_message_success(response)
    end
  end
end
